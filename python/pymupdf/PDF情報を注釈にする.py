#!/usr/bin/env python3
# coding: utf-8
# 20240828 出力結果のテキスト少し読みやすくした
#	20240912 出力結果を注釈にして付与する形式にした
# 20240927 フォント情報とオブジェクトの塗り情報を入れるようにした
# 20240929 MSゴシック等SJISのフォント名に対応した
# 20250123 パス表記を統一　注釈にページ番号を入れた
import sys
import os
import pymupdf

# 入力ファイル受け取り
arg_path_pdf_file = sys.argv
path_pdf_file = str(arg_path_pdf_file[1])
path_save_base_dir = str(arg_path_pdf_file[2])
# テスト用のパス
# path_desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
# path_pdf_file = os.path.join(path_desktop_dir, "demo.pdf")
#テスト用
#path_pdf_file = "/Users/SOMEUID/Desktop/SOME.pdf"

#パスからベースファイル名とコンテナを取得
path_container_directory = os.path.dirname(path_pdf_file)
file_name = os.path.basename(path_pdf_file)
file_base_name = os.path.splitext(file_name)[0]
dir_make_dirname = file_base_name + "_PDF情報"
path_save_dir = os.path.join(path_save_base_dir,dir_make_dirname)
#保存先フォルダを作っておく
os.makedirs(path_save_dir, exist_ok=True)

# テキスト保存先
file_save_text_name = file_base_name + ".PDF情報.txt"
path_save_text_file = os.path.join(path_save_dir,file_save_text_name)

# フォント一覧用テキスト
file_save_fontinfo_name = file_base_name + ".Font情報.txt"
path_save_fontinfo_file = os.path.join(path_save_dir,file_save_fontinfo_name)
list_fontname = set()

# カラー一覧用テキスト
file_save_colorinfo_name = file_base_name + ".Color情報.txt"
path_save_colorinfo_file = os.path.join(path_save_dir,file_save_colorinfo_name)
list_color = set()

#注釈入れたPDFの保存先
file_save_pdf_name = file_base_name + ".PDF情報.pdf"
path_save_pdf_file = os.path.join(path_save_dir,file_save_pdf_name)


# PDFドキュメントを開く
pdf_document = pymupdf.open(path_pdf_file)
###################
def float_to_hex(float_color_no):
	if float_color_no is None:
		return "None"
	red = int(float_color_no[0] * 255)
	green = int(float_color_no[1] * 255)
	blue = int(float_color_no[2] * 255)
	hex_color = "#{:02X}{:02X}{:02X}".format(red, green, blue)
	return hex_color

def int_to_rgb(color_int):
	red = (color_int >> 16) & 0xFF
	green = (color_int >> 8) & 0xFF
	blue = color_int & 0xFF
	return red, green, blue

###################
#テキストファイルを用意して
with open(path_save_text_file, "w", encoding="utf-8") as file:
#PDFページを順に処理
	for page_number in range(len(pdf_document)):
	#PDFページを開いて
		pdf_page = pdf_document.load_page(page_number)
		#テキスト用の変えページ
		print(f"PAGE No:{page_number + 1} ----------------------")
		file.write(f"PAGE No:{page_number + 1} ----------------------\n")
###################
		list_draw_object = pdf_page.get_drawings()
		for item_draw in list_draw_object:
			seqno_no = item_draw['seqno']
			fill_color = item_draw['fill']
			fill_color_hex = float_to_hex(fill_color)
			list_color.add(fill_color_hex)
			print(f"塗色: {fill_color_hex}")
			line_color = item_draw['color']
			line_color_hex = float_to_hex(line_color)
			list_color.add(line_color_hex)
			print(f"線色: {line_color_hex}")
			draw_rect = item_draw['rect']
			print(f"RECT: {draw_rect}")
			left_top_x = draw_rect.x0
			left_top_y = draw_rect.y0
			rect_add_annot = pymupdf.Rect(left_top_x, left_top_y, left_top_x +
                                 20, left_top_y + 20)

			# コンソールに表示
			print(f"DRAW {seqno_no}:")
			print(f"  - 線色: {line_color_hex}")
			print(f"  - 塗色: {fill_color_hex}")

			# テキストファイル用にも書き出す
			file.write(f"DRAW {seqno_no}:")
			file.write(f"  - 線色: {line_color_hex}")
			file.write(f"  - 塗色: {fill_color_hex}")
			file.write(f"\n")

			# 同じ内容を注釈用のテキストにする
			list_annot_text = []
			list_annot_text.append(f"DRAW: {page_number + 1} : {seqno_no}:")
			list_annot_text.append(f"  - 線色: {line_color_hex}")
			list_annot_text.append(f"  - 塗色: {fill_color_hex}")
			str_annot_text = "\n".join(list_annot_text)

			# 注釈追加
			obj_add_annot = pdf_page.add_text_annot(
                            rect_add_annot.tl, str_annot_text, "Comment")
			strSetTitle = (f"DRAW情報: {page_number + 1} : {seqno_no}")
			strSetSubject = (f"DRAW:NO: {page_number + 1} : {seqno_no}")
			obj_add_annot.set_info({
                            'title': strSetTitle,
                            'author': 'DRAW情報',
                            'subject': strSetSubject
                        })

###################
		
		# ページ内のテキスト情報を取得
		list_text_block = pdf_page.get_text("dict")
		# テキストブロックの数だけ繰り返し
		for item_block in list_text_block['blocks']:
			if 'lines' in item_block:
				for line in item_block['lines']:
					for span in line['spans']:
						text_no = item_block['number']
						font_name = span['font']
						byte_sequence = font_name.encode('latin-1')
						font_name = byte_sequence.decode('shift_jis')
						list_fontname.add(font_name)
						font_size = span['size']
						text_bbox = span['bbox']
						color_int = span['color']
						color_hex = "#{:06X}".format(color_int)
						list_fontname.add(color_hex)
						list_color.add(color_hex)
						left_top_x = text_bbox[0]
						left_top_y = text_bbox[1]
						box_w = text_bbox[2] - text_bbox[0]
						box_h = 20
						rect_add_annot = pymupdf.Rect(
						    left_top_x, left_top_y, left_top_x + box_w, left_top_y + box_h)

						# コンソールに表示
						print(f"TEXT {text_no}:")
						print(f"  - Font: {font_name}")
						print(f"  - Size: {font_size}")
						print(f"  - Color: {color_hex}")

						# テキストファイル用にも書き出す
						file.write(f"TEXT {text_no}:\n")
						file.write(f"  - Font: {font_name}\n")
						file.write(f"  - Size: {font_size}\n")
						file.write(f"  - Color: {color_hex}\n")
						file.write(f"\n")

						# 同じ内容を注釈用のテキストにする
						list_annot_text = []
						list_annot_text.append(f"TEXT: {page_number + 1} : {text_no}:")
						list_annot_text.append(f"  - Font: {font_name}")
						list_annot_text.append(f"  - Size: {font_size}")
						list_annot_text.append(f"  - Color: {color_hex}")
						str_annot_text = "\n".join(list_annot_text)

						# 注釈追加
						obj_add_annot = pdf_page.add_text_annot(
							rect_add_annot.tl, str_annot_text)
						strSetTitle = (f"テキスト情報: {page_number + 1} : {text_no}")
						strSetSubject = (f"TEXT:NO: {page_number + 1} : {text_no}")
						obj_add_annot.set_info({
																	'title': strSetTitle,
																	'author': 'テキスト情報',
																	'subject': strSetSubject
															})

###################
		# ページ内の画像情報を取得
		image_list = pdf_page.get_images(full=True)
		#画像の数
		num_cnt_images = len(image_list)
		if num_cnt_images == 0:
			print(f"ページ:{page_number + 1} には画像がありません")
			file.write(f"ページ:{page_number + 1} には画像がありません\n\n")
		else:
			print(f"ページ:{page_number + 1} には画像が {num_cnt_images}点ありました")
			file.write(f"ページ:{page_number + 1} には画像が {num_cnt_images}点ありました\n")

	# 画像情報の表示
		for img_index, item_image in enumerate(image_list, start=1):
			xref = item_image[0]
			pixmap_ref = pymupdf.Pixmap(pdf_document, xref)
			base_image = pdf_document.extract_image(xref)
			image_ext = base_image["ext"]
			# 画像のサイズ
			image_bytes = base_image["image"]
			image_size = len(image_bytes) / (1024 * 1024)
			# ピクセルサイズと解像度
			image_width = pixmap_ref.width
			image_height = pixmap_ref.height
			# img_rect = pdf_page.get_image_rects(xref)[0]
			#画像の位置RECTを取得（同一画像が同一ページに複数配置されている場合はリストになる）
			list_image_rects = pdf_page.get_image_rects(xref)
			#RECT画像の位置情報の数だけ繰り返す
			for rect_index, img_rect in enumerate(list_image_rects, start=1):
				# RECT左上
				left_top_x = img_rect.x0
				left_top_y = img_rect.y0
				# 幅　縦
				rect_width = img_rect.width
				rect_height = img_rect.height
				#解像度
				resolution_width = image_width / (rect_width / 72)
				resolution_height = image_height / (rect_height / 72)
				resolution_width = round(resolution_width)
				resolution_height = round(resolution_height)
				#カラースペース判定
				colorspace = ""
				num_colorspace = base_image.get('colorspace', 1)
				if pixmap_ref.is_monochrome == 0:
					if pixmap_ref.is_unicolor == True:
						colorspace = "ユニ/SPOT"
					else:
						colorspace = "マルチ/ICC"
				else:
					colorspace = "モノ/単色"
				#カラースペース判定　ここの判定に自信がない
				if num_colorspace == 1:
					colorspace = (f"{colorspace} :Gray/BW")
				elif num_colorspace == 2:
					colorspace = (f"{colorspace}: Gray/BWA")
				elif num_colorspace == 3:
					colorspace = (f"{colorspace}: RGB")
				elif num_colorspace == 4:
					colorspace = (f"{colorspace}: CMYK")
				else:
					colorspace = (f"{colorspace}: Unknown: ")
				#コンソールに表示
				print(f"Image {img_index}:")
				print(f"  - Xref: {xref}")
				print(f"  - Size: {base_image['width']}x{base_image['height']}")
				print(f"  - Resolution: {resolution_width}x{resolution_height} ppi")
				# print(f"  - Format: {image_ext}")書き出し後だから意味ない
				print(f"  - ColorSpace: {colorspace} : {num_colorspace}")
				print(f"  - Image Size: {image_size:.3f} MB")
				# 同じ内容を注釈用のテキストにする
				list_annot_text = []
				list_annot_text.append(f"Image: {page_number + 1} : {img_index}:")
				list_annot_text.append(f"  - Xref: {xref}")
				list_annot_text.append(f"  - Size: {base_image['width']}x{base_image['height']}")
				list_annot_text.append(f"  - Resolution: {resolution_width}x{resolution_height} ppi")
				# list_annot_text.append(f"  - Format: {image_ext}")書き出し後だから意味ない
				list_annot_text.append(f"  - ColorSpace: {colorspace} : {num_colorspace}")
				list_annot_text.append(f"  - Image Size: {image_size:.3f} MB")
				str_annot_text = "\n".join(list_annot_text)
				rect_add_annot = pymupdf.Rect(left_top_x, 50, left_top_y, 50)
				#注釈追加
				obj_add_annot = pdf_page.add_text_annot(img_rect.tl, str_annot_text,"Tag")
				strSetTitle = (f"画像情報: {page_number + 1} : {xref}")
				strSetSubject = (f"画像:XREF: {page_number + 1} : {xref}")
				obj_add_annot.set_info({
						'title': strSetTitle,
						'author': '埋め込み画像情報',
						'subject': strSetSubject
				})
				#テキストファイル用にも書き出す
				file.write(f"Image {img_index}:\n")
				file.write(f"  - Xref: {xref}\n")
				file.write(f"  - Size: {base_image['width']}x{base_image['height']}\n")
				file.write(f"  - Resolution: {resolution_width}x{resolution_height} ppi\n")
				#file.write(f"  - Format: {image_ext}\n")　書き出し後だから意味ない
				file.write(f"  - ColorSpace: {colorspace}: {num_colorspace}\n")
				file.write(f"  - Image Size: {image_size:.3f} MB\n")
				file.write(f"\n")

file.close()

with open(path_save_fontinfo_file, "w", encoding="utf-8") as font_Info_file:
	sorted_list_fontname = sorted(list_fontname)
	str_add_fontList = "\n".join(map(str, sorted_list_fontname))
	font_Info_file.write(f"{str_add_fontList}\n")
	font_Info_file.write(f"\n")
font_Info_file.close()

with open(path_save_colorinfo_file, "w", encoding="utf-8") as color_Info_file:
	sorted_list_colorname = sorted(list_color)
	str_add_colorList = "\n".join(map(str, sorted_list_colorname))
	color_Info_file.write(f"{str_add_colorList}\n")
	color_Info_file.write(f"\n")
color_Info_file.close()

#全ページ終わったら注釈の入ったPDFを別名保存する
pdf_document.save(path_save_pdf_file)
#開いていたPDFを閉じて
pdf_document.close()
#処理終了
sys.exit(0)



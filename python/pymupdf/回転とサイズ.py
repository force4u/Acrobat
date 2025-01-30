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
file_save_text_name = file_base_name + ".回転チェック.txt"
path_save_text_file = os.path.join(path_save_dir,file_save_text_name)

num_point2mm = 0.352778
num_point2inch = 1 / 72

###PAGEBOX計算
def define_rect_2_string(arg_box_name,arg_box_rect):
	num_width_pt = arg_box_rect.width
	num_height_pt = arg_box_rect.height
	num_width_mm =  round(num_width_pt * num_point2mm, 2)
	num_height_mm = round(num_width_pt * num_point2mm, 2)
	num_width_inch = round(num_width_pt * num_point2inch, 2)
	num_height_inch = round(num_width_pt * num_point2inch, 2)
	str_mm_box = f"{num_width_mm:.2f}x{num_height_mm:.2f} mm"
	str_pt_box = f"{num_width_pt:.2f}x{num_height_pt:.2f} pt"
	str_in_box = f"{num_width_inch:.2f}x{num_height_inch:.2f} in"
	return f"{arg_box_name}: {str_mm_box} : {str_pt_box}  : {str_in_box}"


###ページのかずだけ繰り返し
with open(path_save_text_file, "w", encoding="utf-8") as save_text:
	# PDFドキュメントを開く
	pdf_document = pymupdf.open(path_pdf_file)
	#PDFページを順に処理
	for page_number in range(len(pdf_document)):
	#PDFページを開いて
		pdf_page = pdf_document.load_page(page_number)
		#回転
		num_page_rotation = pdf_page.rotation
		#	print(f"{num_page_rotation}")
		save_text.write(f"PAGE No:{page_number + 1} ----------------------\n")
		save_text.write(f"ページ回転: {num_page_rotation}\n")
		###
		rect_cropbox_page = pdf_page.cropbox
		rect_trimbox_page = pdf_page.trimbox
		rect_bleedbox_page = pdf_page.bleedbox
		rect_mediabox_page = pdf_page.mediabox
		
		str_cropbox_page = define_rect_2_string("CropBox",rect_cropbox_page)
		str_trimbox_page = define_rect_2_string("TrimBox",rect_trimbox_page)
		str_bleedbox_page = define_rect_2_string("BleedBox",rect_bleedbox_page)
		str_mediabox_page = define_rect_2_string("MediaBox",rect_mediabox_page)
		
		save_text.write(f"{str_cropbox_page}\n")
		save_text.write(f"{str_trimbox_page}\n")
		save_text.write(f"{str_bleedbox_page}\n")
		save_text.write(f"{str_mediabox_page}\n")
		save_text.write(f"\n")

save_text.close()
#開いていたPDFを閉じて
pdf_document.close()
#処理終了
sys.exit(0)

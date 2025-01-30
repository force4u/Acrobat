#!/usr/bin/env python3
# coding: utf-8
# 20240828 出力結果のテキスト少し読みやすくした
# 20240912 出力結果を注釈にして付与する形式にした
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


# パスからベースファイル名とコンテナを取得
#パスからベースファイル名とコンテナを取得
path_container_directory = os.path.dirname(path_pdf_file)
file_name = os.path.basename(path_pdf_file)
file_base_name = os.path.splitext(file_name)[0]
dir_make_dirname = file_base_name + "_PDF情報"
path_save_dir = os.path.join(path_save_base_dir,dir_make_dirname)
#保存先フォルダを作っておく
os.makedirs(path_save_dir, exist_ok=True)

# テキスト保存先
file_save_text_name = file_base_name + ".BookMarkList.tsv"
path_save_text_file = os.path.join(path_save_dir,file_save_text_name)


# 出力用のテキストの初期化
list_output_line = []
str_tsv_output_line = "NO\tNEST\tXREF\tKIND\tタイトル\tDistPage\t位置XY\tZoom"
list_output_line.append(str_tsv_output_line)

# PDF読み込み
pdf_document = pymupdf.open(path_pdf_file)
# BOOKMARK取得
list_toc = pdf_document.get_toc(simple=False)
# 階層を保持するDICT
dict_nest_no = {}
# 行番号カウンター
num_cnt_line = 1
# BOOKMARKの数だけくりかえし
for item_toc in list_toc:
    num_level = item_toc[0]
    str_title = item_toc[1]
    str_page = item_toc[2]
    dict_additional_info = item_toc[3]

    str_xref = dict_additional_info.get("xref", "")
    str_kind = dict_additional_info.get("kind", "")
    str_to_x = dict_additional_info["to"].x
    str_to_y = dict_additional_info["to"].y
    str_zoom = dict_additional_info.get("zoom", "")

    if num_level not in dict_nest_no:
        dict_nest_no[num_level] = 1
    else:
        dict_nest_no[num_level] += 1

    num_item_nest_no = [str(dict_nest_no[i]) for i in range(1, num_level + 1)]
    str_nest_no = "-".join(num_item_nest_no)

    str_tsv_output_line = f"{num_cnt_line}\t{str_nest_no}\t{str_xref}\t{str_kind}\t{str_title}\t{str_page}\t{str_to_x},{str_to_y}\t{str_zoom}"
    num_cnt_line = num_cnt_line + 1
    list_output_line.append(str_tsv_output_line)

with open(path_save_text_file, "w", encoding="utf-8") as f:
    f.write("\n".join(list_output_line))

pdf_document.close()
sys.exit(0)

#!/usr/bin/env python3
# coding: utf-8
# 20250213 v1 初回作成
# 20250213 v1.0.1 上書きしないようにした
import sys
import os
import uuid
import argparse
import pymupdf

########################################################
#アグリメント関連
def parse_args():
    parser = argparse.ArgumentParser(description="PDFの開き方設定＋パスワード設定")
    parser.add_argument(
        "path_pdf_file",
        type=str,
        help="入力PDFファイルパススペースエスケープせずにダブルクオテーションで",
    )
    parser.add_argument("num_layout_no", type=int, default=3, help="レイアウト番号")
    parser.add_argument("num_mode_no", type=int, default=2, help="モード番号")
    parser.add_argument(
        "num_open_perm",
        type=int,
        choices=[0, 1, 2],
        default=1,
        help="開封パスワード:0=有,1=無,2=パスワード設定無し",
    )
    parser.add_argument("num_enc_no", type=int, default=5, help="暗号化設定")
    parser.add_argument("num_perm_no", type=int, default=292, help="許可番号")
    return parser.parse_args()


arg_input = parse_args()
# 	arg_input.path_pdf_file
# 	arg_input.num_layout_no
# 	arg_input.num_mode_no
# 	arg_input.num_open_perm
# 	arg_input.num_enc_no
# 	arg_input.num_perm_no

# テスト用のパス
# path_desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
# path_pdf_file = os.path.join(path_desktop_dir, "サンプル 2.pdf")
# path_pdf_file = "/Users/SOMEUID/Desktop/SOME.pdf"
# テスト用の値
num_layout_no = 3
num_mode_no = 2
num_open_perm = 1
num_enc_no = 5
num_perm_no = 292

# 入力ファイル受け取り
path_pdf_file = str(arg_input.path_pdf_file)

# レイアウト受け取り
num_layout_no = arg_input.num_layout_no
"""
"PassThrough"           0   値を変更しない
"SinglePage"            1   単ページ
"OneColumn"             2   連続ページ
"TwoColumnLeft"         3   見開き左表紙
"TwoColumnRight"        4   見開き右表紙
"TwoPageLeft"           5   見開き左
"TwoPageRight"          6   見開き右
AdobeAcrobatでの呼称
"SinglePage"            1   単一ページ
"OneColumn"             2   連続ページ
"TwoColumnLeft"         3   連続見開きページ
"TwoColumnRight"        4   連続見開きページ（表紙）
"TwoPageLeft"           5   見開きページ
"TwoPageRight"          6   見開きページ（表紙）
"""

# モード受け取り
num_mode_no = arg_input.num_mode_no
"""
"PassThrough"           0   値を変更しない
"UseNone"               1   設定無し
"UseOutlines"           2   しおりアウトライン表示
"UseThumbs"             3   ページサムネイル表示
"FullScreen"            4   フルスクリーン
"UseOC"                 5   レイヤパネル
"UseAttachments"        6   添付ファイル
"""
# パスワード設定受け取り
num_open_perm = arg_input.num_open_perm

# 暗号化設定
num_enc_no = arg_input.num_enc_no

# 許可番号受け取り
num_perm_no = arg_input.num_perm_no

########################################################
#パス関連
def make_unique_dir(arg_path_make_dir):
    num_counter = 1
    path_set_make_dir = arg_path_make_dir
    while os.path.exists(path_set_make_dir):
        path_set_make_dir = f"{arg_path_make_dir}{num_counter}"
        num_counter += 1
    os.makedirs(path_set_make_dir)
    return path_set_make_dir

# パスからベースファイル名とコンテナを取得
path_container_directory = os.path.dirname(path_pdf_file)
file_name = os.path.basename(path_pdf_file)
file_base_name = os.path.splitext(file_name)[0]
dir_make_dirname = file_base_name + "_設定済"
path_save_dir = os.path.join(path_container_directory, dir_make_dirname)
# 保存先フォルダを作っておく
path_save_dir = make_unique_dir(path_save_dir)
#テスト用の上書きOK指定
#os.makedirs(path_save_dir, exist_ok=True)
# PDFの保存先
file_save_pdf_name = file_base_name + ".pdf"
path_save_pdf_file = os.path.join(path_save_dir, file_save_pdf_name)

####################
# レイアウトの設定
array_layout_value = [
    "SinglePage",
    "OneColumn",
    "TwoColumnLeft",
    "TwoColumnRight",
    "TwoPageLeft",
    "TwoPageRight",
]
str_set_layout = array_layout_value[num_layout_no]
print(f"layout: {str_set_layout}")

####################
# モードの設定
array_page_mode = [
    "UseNone",
    "UseOutlines",
    "UseThumbs",
    "FullScreen",
    "UseOC",
    "UseAttachments",
]
str_set_mode = array_page_mode[num_mode_no]
print(f"mode: {str_set_mode}")

####################
# 暗号化番号
array_enc_name = [
    "PDF_ENCRYPT_KEEP",
    "PDF_ENCRYPT_NONE",
    "PDF_ENCRYPT_RC4_40",
    "PDF_ENCRYPT_RC4_128",
    "PDF_ENCRYPT_AES_128",
    "PDF_ENCRYPT_AES_256",
    "PDF_ENCRYPT_UNKNOWN",
]
dict_enc_name = {
    "PDF_ENCRYPT_KEEP": 0,
    "PDF_ENCRYPT_NONE": 1,
    "PDF_ENCRYPT_RC4_40": 2,
    "PDF_ENCRYPT_RC4_128": 3,
    "PDF_ENCRYPT_AES_128": 4,
    "PDF_ENCRYPT_AES_256": 5,
    "PDF_ENCRYPT_UNKNOWN": 6,
}
str_enc_name = array_enc_name[num_enc_no]
num_set_enc_no = getattr(pymupdf, str_enc_name, None)
print(f"ENC: {num_set_enc_no}")

####################
# 許可番号
# array_perm_name = ["PDF_PERM_PRINT", "PDF_PERM_MODIFY", "PDF_PERM_COPY", "PDF_PERM_ANNOTATE", "PDF_PERM_FORM", "PDF_PERM_ACCESSIBILITY", "PDF_PERM_ASSEMBLE", "PDF_PERM_PRINT_HQ"]
# dict_perm_name = {"PDF_PERM_PRINT":4, "PDF_PERM_MODIFY":8, "PDF_PERM_COPY":16, "PDF_PERM_ANNOTATE":32, "PDF_PERM_FORM":256, "PDF_PERM_ACCESSIBILITY":512, "PDF_PERM_ASSEMBLE":1024, "PDF_PERM_PRINT_HQ":2048}
# num_perm_no = int( pymupdf.PDF_PERM_PRINT | pymupdf.PDF_PERM_ANNOTATE | pymupdf.PDF_PERM_FORM )
dict_perm_name = {
    4: "低解像度印刷",
    8: "修正・変更",
    16: "抽出・コピー",
    32: "注釈・署名",
    256: "フォーム入力",
    512: "アクセシビリティ",
    1024: "再構成・属性変更",
    2048: "高画質印刷"
}
print(f"PERM: {num_perm_no}")
array_matched_string = [
    value for key, value in dict_perm_name.items() if num_perm_no & key
]
str_perm_string = " ".join(array_matched_string)
print(f"PERM: {str_perm_string}")
#################
# パスワード生成
str_uuid = str(uuid.uuid4()).upper()
str_set_pw_own = str_uuid.replace("-", "")
str_uuid = str(uuid.uuid4()).upper()
str_set_pw_usr = str_uuid.replace("-", "")

if num_open_perm == 0:
    str_save_text = "所有者Pw（教えちゃダメなやつ↓）\n"
    str_save_text = str_save_text + str_set_pw_own + "\n\n"
    str_save_text = str_save_text + "利用者用Pw（他者に教える場合はこちら↓）\n"
    str_save_text = str_save_text + str_set_pw_usr + "\n\n"
    str_save_text = str_save_text + "別に送付しましたPDFの開封パスワードです。\n"
    str_save_text = str_save_text + "コピペ時には改行が入らないように留意ください\n"
    str_save_text = str_save_text + "-----\n"
    str_save_text = str_save_text + "暗号化情報: " + str_enc_name + "\n"
    str_save_text = str_save_text + "許可: " + str_perm_string + "\n"
elif num_open_perm == 1:
    str_save_text = "所有者Pw（教えちゃダメなやつ↓）\n"
    str_save_text = str_save_text + str_set_pw_own + "\n\n"
    str_save_text = str_save_text + "このパスワードは他者におしえてはダメなやつ\n"
    str_save_text = str_save_text + "所有者パスワードです。\n"
    str_save_text = str_save_text + "PDFはパスワード無しで閲覧する事ができます\n"
    str_save_text = str_save_text + "-----\n"
    str_save_text = str_save_text + "暗号化情報: " + str_enc_name + "\n"
    str_save_text = str_save_text + "許可: " + str_perm_string + "\n"
elif num_open_perm == 2:
    str_save_text = "パスワード設定無し\n"
    str_save_text = str_save_text + "パスワードは設定していません\n"

# パスワードの保存先
file_save_text_name = file_base_name + ".PW.txt"
path_save_text_file = os.path.join(path_save_dir, file_save_text_name)

with open(path_save_text_file, "w", encoding="utf-8") as file:
    file.write(str_save_text)

# PDFドキュメントを開く
pdf_activ_document = pymupdf.open(path_pdf_file)
###################
# レイアウト設定
pdf_activ_document.set_pagelayout(str_set_layout)
# モード設定
pdf_activ_document.set_pagemode(str_set_mode)

# PDFを別名保存する
# 開封パスワードありの場合
if num_open_perm == 0:
    pdf_activ_document.save(
        path_save_pdf_file,
        encryption=num_set_enc_no,
        owner_pw=str_set_pw_own,
        user_pw=str_set_pw_usr,
        permissions=num_perm_no,
    )
# 開封パスワード無しの場合
elif num_open_perm == 1:
    pdf_activ_document.save(
        path_save_pdf_file,
        encryption=num_set_enc_no,
        owner_pw=str_set_pw_own,
        permissions=num_perm_no,
    )
# パスワード設定をしない場合
elif num_open_perm == 2:
    pdf_activ_document.save(path_save_pdf_file)


# 開いていたPDFを閉じて
pdf_activ_document.close()
# 処理終了
sys.exit(0)

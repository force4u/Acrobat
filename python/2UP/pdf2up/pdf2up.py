#!/usr/bin/env python3
import sys
import math
from pypdf import PdfReader
from pypdf import PdfWriter
from pypdf import PageObject
from pypdf import Transformation
from pypdf.generic import RectangleObject

#########################################入力パスを受け取る
argGetData = sys.argv
strFilePath = str(argGetData[1])
strOutputPDFDocPath = strFilePath + ".2in1.pdf"
try:
	with open(strFilePath, 'rb') as objInputData:
#########################################ライター初期化
		objReader = PdfReader(objInputData)
		objWriter = PdfWriter()
#########################################ページ数調べる
		objAllPages = objReader.pages
		numAllPage = int(len(objAllPages))
		print(numAllPage)
#########################################奇数偶数判定使わないけど
		if numAllPage % 2 == 0:
			print("偶数")  
		else:
			print("奇数") 
		numRepeatTImes = math.ceil(numAllPage / 2 )
		print(numRepeatTImes)
#########################################ページ数➗２回数繰り返し
		numCntInPage = int(0)
		for numTimes in range(numRepeatTImes):
			objPageR = objReader.pages[numCntInPage]
			numWR = objPageR.mediabox.right
			numHR = objPageR.mediabox.top
			print("R :" , numWR , "x" , numHR)
#########################################奇数ページの場合
			if numCntInPage == (numAllPage - 1):
				objPageL = PageObject.create_blank_page(width=numWR, height=numHR)
				numWL = objPageR.mediabox.right
				numHL = objPageR.mediabox.top
			else:
				numCntInPage = numCntInPage + 1
				objPageL = objReader.pages[numCntInPage]
				numWL = objPageL.mediabox.right
				numHL = objPageL.mediabox.top
				print("L :" , numWL , "x" , numHL)
				numCntInPage = numCntInPage + 1
#########################################新規ページの高さは最大値
			if numHR >= numHL:
				numNewH = numHR
			else:
				numNewH = numHL
#########################################新規ページの幅
			numNewW = numWL + numWL
#########################################左右サイズで新規ページ
			print("2W:" , numNewW , "x" , numNewH)
			objNewPage =  PageObject.create_blank_page(None,numNewW,numNewH)
#########################################左側ページを新規ページに
			objNewPage.merge_page(objPageL,False)
#########################################右側ページのリサイズ
			objOption = Transformation().translate(tx=numWL)
			objPageR.add_transformation(objOption,True)
			objPageR.mediabox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.cropbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.trimbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.bleedbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.artbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.merge_page(objPageR,True)
#########################################新規ページのサイズ
			objNewPage.mediabox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.cropbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.trimbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.bleedbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.artbox = RectangleObject((0,0,numNewW,numNewH))
			objWriter.add_page(objNewPage)
except FileNotFoundError:
	print("ファイルのオープンに失敗しました")
	sys.exit(0)	
try:
#########################################
	with open(strOutputPDFDocPath, 'wb') as objOutPutData:
		objWriter.write(objOutPutData)
except FileNotFoundError:
    print("ファイルの保存に失敗しました")

sys.exit(0)	


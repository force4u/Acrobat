#!/usr/bin/env python3
import sys
import math
from pypdf import PdfReader
from pypdf import PdfWriter
from pypdf import PageObject
from pypdf import Transformation
from pypdf.generic import RectangleObject

#########################################入力ファイル受け取り
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
		numRepeatTImes = math.ceil(numAllPage / 2 )
		print(numRepeatTImes)
#########################################ページ数➗２回数繰り返し
		numCntInPage = int(0)
		for numTimes in range(numRepeatTImes):
			objPageR = objReader.pages[numCntInPage]
			numRotationR = objPageR.rotation
			print("Rotation:" , numRotationR)
			if (numRotationR == 0) | (numRotationR == 180) :
				numWR = objPageR.mediabox.right
				numHR = objPageR.mediabox.top
			elif (numRotationR == 90) | (numRotationR == 270) :
				numWR = objPageR.mediabox.top
				numHR = objPageR.mediabox.right
			print("R :" , numWR , "x" , numHR)
#########################################奇数ページの場合
			if numCntInPage == (numAllPage - 1):
				objPageL = PageObject.create_blank_page(width=numWR, height=numHR)
				numWL = numWR
				numHL = numHR
			else:
				numCntInPage = numCntInPage + 1
				objPageL = objReader.pages[numCntInPage]
				numRotationL = objPageL.rotation
				print("Rotation:" , numRotationL)
				if (numRotationL == 0) | (numRotationL == 180) :
					numWL = objPageL.mediabox.right
					numHL = objPageL.mediabox.top
				elif (numRotationL == 90) | (numRotationL == 270) :
					numWL = objPageL.mediabox.top
					numHL = objPageL.mediabox.right
				print("L :" , numWL , "x" , numHL)
				numCntInPage = numCntInPage + 1
			#sys.exit(0)	
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
			if (numRotationL == 0):
				numNewRotationL = 0
				numTXL=0
				numTYL=0
			elif (numRotationL == 90):
				numNewRotationL = 270
				numTXL=0
				numTYL=numHL
			elif (numRotationL == 180):
				numNewRotationL = 180
				numTXL=numWL
				numTYL=numHL
			elif (numRotationL == 270):
				numNewRotationL = 90
				numTXL=(numWL)
				numTYL=0
			objOption = Transformation().rotate(numNewRotationL).translate(tx=numTXL, ty=numTYL)
			objPageL.add_transformation(objOption,True)
			objNewPage.merge_page(objPageL,False)
#########################################右側ページのリサイズ
			if (numRotationR == 0):
				numNewRotationR = 0
				numTXR=(numWL)
				numTYR=0
			elif (numRotationR == 90):
				numNewRotationR = 270
				numTXR=numWL
				numTYR=numHR
			elif (numRotationR == 180):
				numNewRotationR = 180
				numTXR=(numWL + numWR)
				numTYR=numHR
			elif (numRotationR == 270):
				numNewRotationR = 90
				numTXR=(numWL + numWR)
				numTYR=0
			objOption = Transformation().rotate(numNewRotationR).translate(tx=numTXR, ty=numTYR)
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


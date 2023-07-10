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
###テスト用
##strFilePath = "/path/to/pdf.pdf"

strOutputPDFDocPath = strFilePath + ".2UP.pdf"
try:
	with open(strFilePath, 'rb') as objInputData:
#########################################ライター初期化
		objReader = PdfReader(objInputData)
		objWriter = PdfWriter()
#########################################ページ数調べる
		objAllPages = objReader.pages
		numAllPage = int(len(objAllPages))
		print("入力ページ：" , numAllPage)
		numRepeatTImes = math.ceil(numAllPage / 2 )
		print("出力ページ" , numRepeatTImes)
#########################################ページ数➗２回数繰り返し
		numCntInPage = int(0)
		for numTimes in range(numRepeatTImes):
########################################■P1ページ取り出し
			objPageP1 = objReader.pages[numCntInPage]
			numCropXP1 = objPageP1.cropbox.left
			numCropYP1 = objPageP1.cropbox.bottom
			numCropWP1 = objPageP1.cropbox.right
			numCropHP1 = objPageP1.cropbox.top
			rectCropBoxP1 = objPageP1.cropbox
			objPageP1.artbox = rectCropBoxP1
			numRotationP1 = objPageP1.rotation
			if (numRotationP1 == 0) | (numRotationP1 == 180) :
				numWP1 = numCropWP1 - numCropXP1
				numHP1 = numCropHP1 - numCropYP1
			elif (numRotationP1 == 90) | (numRotationP1 == 270) :
				numWP1 = numCropHP1 - numCropYP1
				numHP1 = numCropWP1 - numCropXP1

########################################■P2ページ取り出し
			if numCntInPage == (numAllPage - 1):
				objPageP2 = PageObject.create_blank_page(width=numWP1, height=numHP1)
				numWP2 = numWP1
				numHP2 = numHP1
			else:
				numCntInPage = numCntInPage + 1
				########################################■P2ページ取り出し
				objPageP2 = objReader.pages[numCntInPage]
				numCropXP2 = objPageP2.cropbox.left
				numCropYP2 = objPageP2.cropbox.bottom
				numCropWP2 = objPageP2.cropbox.right
				numCropHP2 = objPageP2.cropbox.top
				rectCropBoxP2 = objPageP2.cropbox
				objPageP2.artbox = rectCropBoxP2
				numRotationP2 = objPageP2.rotation
				if (numRotationP2 == 0) | (numRotationP2 == 180) :
					numWP2 = numCropWP2 - numCropXP2
					numHP2 = numCropHP2 - numCropYP2
				elif (numRotationP2 == 90) | (numRotationP2 == 270) :
					numWP2 = numCropHP2 - numCropYP2
					numHP2 = numCropWP2 - numCropXP2
				numCntInPage = numCntInPage + 1
			#sys.exit(0)	
#########################################■出力ページサイズ
			if numWP1 >= numHP1:
				numNewW = max(numWP1,numWP2)
				numNewH = numHP1 + numHP2
				boolH = True
			else:
				numNewW = numWP1 + numWP2
				numNewH = max(numHP1,numHP2)
				boolH = False
			print("ページ:" ,numTimes,"サイズ", numNewW , "x" , numNewH)
			objNewPage =  PageObject.create_blank_page(None,numNewW,numNewH)
			
#########################################■ポジション１
			if (numRotationP1 == 0):
				numNewRotationL = 0
				if (boolH == True):
					numTXP1 = 0 - numCropXP1
					numTYP1 = numHP1 - numCropYP1
				else:
					numTXP1 = 0 - numCropXP1
					numTYP1 = 0 - numCropYP1

			elif (numRotationP1 == 90):
				numNewRotationL = 270
				if (boolH == True):
					numTXP1 = 0 - numCropYP1
					numTYP1 = numNewH + numCropXP1
				else:
					numTXP1= 0 - numCropYP1
					numTYP1= numHP1 + numCropXP1

			elif (numRotationP1 == 180):
				numNewRotationL = 180
				if (boolH == True):
					numTXP1 = numNewW + numCropXP1
					numTYP1 = (numNewH) + numCropYP1
				else:
					numTXP1 = numWP1 + numCropXP1
					numTYP1 = numHP1 + numCropYP1

			elif (numRotationP1 == 270):
				numNewRotationL = 90
				if (boolH == True):
					numTXP1 = numWP1 + numCropYP1
					numTYP1 = numHP1 - numCropXP1
				else:
					numTXP1 = numWP1 + numCropYP1
					numTYP1 = 0 - numCropXP1

			objOption = Transformation().rotate(numNewRotationL).translate(tx=numTXP1, ty=numTYP1)
			objPageP1.add_transformation(objOption,True)
			if (boolH == True):
				numNewXP1 = 0
				numNewYP1 = numHP1
				numNewWP1 = numNewW
				numNewHP1 = numNewH
			else:
				numNewXP1 = 0
				numNewYP1 = 0
				numNewWP1 = numWP1
				numNewHP1 = numHP1
			objPageP1.mediabox = RectangleObject((numNewXP1,numNewYP1,numNewWP1,numNewHP1))
			objPageP1.cropbox = RectangleObject((numNewXP1,numNewYP1,numNewWP1,numNewHP1))
			objPageP1.trimbox = RectangleObject((numNewXP1,numNewYP1,numNewWP1,numNewHP1))
			objPageP1.bleedbox = RectangleObject((numNewXP1,numNewYP1,numNewWP1,numNewHP1))
			objPageP1.artbox = RectangleObject((numNewXP1,numNewYP1,numNewWP1,numNewHP1))

			objNewPage.merge_page(objPageP1,False)
#########################################■ポジション２
			if (numRotationP2 == 0):
				numNewRotationR = 0
				if (boolH == True):
					numTXP2 = 0 - numCropXP2
					numTYP2 = 0 - numCropYP2
				else:
					numTXP2 = numWP2 - numCropXP2
					numTYP2 = 0 - numCropYP2

			elif (numRotationP2 == 90):
				numNewRotationR = 270
				if (boolH == True):
					numTXP2 = 0 - numCropYP2
					numTYP2 = numHP2 + numCropXP2
				else:
					numTXP2= numWP2 - numCropYP2
					numTYP2= numHP2 + numCropXP2

			elif (numRotationP2 == 180):
				numNewRotationR = 180
				if (boolH == True):
					numTXP2 = numWP2 + numCropXP2
					numTYP2 = numHP2 + numCropYP2
				else:
					numTXP2 = numNewW + numCropXP2
					numTYP2 = numHP2 + numCropYP2

			elif (numRotationP2 == 270):
				numNewRotationR = 90
				if (boolH == True):
					numTXP2 = numWP2 + numCropYP2
					numTYP2 = 0 - numCropXP2
				else:
					numTXP2 = numNewW + numCropYP2
					numTYP2 = 0 - numCropXP2

			objOption = Transformation().rotate(numNewRotationR).translate(tx=numTXP2, ty=numTYP2)
			objPageP2.add_transformation(objOption,True)
			if (boolH == True):
				numNewXP2 = 0
				numNewYP2 = 0
				numNewWP2 = numWP2
				numNewHP2 = numHP2
			else:
				numNewXP2 = (numNewW - numWP2) 
				numNewYP2 = 0
				numNewWP2 = numNewW
				numNewHP2 = numNewH
				
			objPageP2.mediabox = RectangleObject((numNewXP2,numNewYP2,numNewWP2,numNewHP2))
			objPageP2.cropbox = RectangleObject((numNewXP2,numNewYP2,numNewWP2,numNewHP2))
			objPageP2.trimbox = RectangleObject((numNewXP2,numNewYP2,numNewWP2,numNewHP2))
			objPageP2.bleedbox = RectangleObject((numNewXP2,numNewYP2,numNewWP2,numNewHP2))
			objPageP2.artbox = RectangleObject((numNewXP2,numNewYP2,numNewWP2,numNewHP2))
			objNewPage.merge_page(objPageP2,False)
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


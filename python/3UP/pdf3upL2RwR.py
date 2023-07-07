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
#テスト用
#	strFilePath = "/path/to/pdf"

strOutputPDFDocPath = strFilePath + ".3in1.pdf"
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
		numRepeatTImes = math.ceil(numAllPage / 3 )
		print(numRepeatTImes)
#########################################ページ数
		numCntInPage = int(0)
		for numTimes in range(numRepeatTImes):
#########################################左側ページ
			objPageL = objReader.pages[numCntInPage]
			numCropXL = objPageL.cropbox.left
			numCropYL = objPageL.cropbox.bottom
			numCropWL = objPageL.cropbox.right
			numCropHL = objPageL.cropbox.top
			print("numCropXL:" , numCropXL)
			print("numCropYL:" , numCropYL)
			print("numCropWL:" , numCropWL)
			print("numCropHL:" , numCropHL)

			numRotationL = objPageL.rotation
			print("numRotationL:" , numRotationL)
			if (numRotationL == 0) | (numRotationL == 180) :
				numWL = numCropWL - numCropXL
				numHL = numCropHL - numCropYL
			elif (numRotationL == 90) | (numRotationL == 270) :
					numWL = numCropHL - numCropYL
					numHL = numCropWL - numCropXL
			print("L :" , numWL , "x" , numHL)
			numCntInPage = numCntInPage + 1
#########################################センターページ
			if numCntInPage >= (numAllPage):
				##ページがない場合は前のページのサイズでブランク作成
				objPageC = PageObject.create_blank_page(width=numWL, height=numHL)
				numWC = objPageC.mediabox.right
				numHC = objPageC.mediabox.top
			else:
				objPageC = objReader.pages[numCntInPage]
				numCropXC = objPageC.cropbox.left
				numCropYC = objPageC.cropbox.bottom
				numCropWC = objPageC.cropbox.right
				numCropHC = objPageC.cropbox.top
				print("numCropXC:" , numCropXC)
				print("numCropYC:" , numCropYC)
				print("numCropWC:" , numCropWC)
				print("numCropHC:" , numCropHC)

				numRotationC = objPageC.rotation
				print("numRotationC:" , numRotationC)

				if (numRotationC == 0) | (numRotationC == 180) :
					numWC = numCropWC - numCropXC
					numHC = numCropHC - numCropYC
				elif (numRotationC == 90) | (numRotationC == 270) :
					numWC = numCropHC - numCropYC
					numHC = numCropWC - numCropXC
				print("C :" , numWC , "x" , numHC)
				numCntInPage = numCntInPage + 1

#########################################右ページ
			if numCntInPage >= (numAllPage):
				objPageR = PageObject.create_blank_page(width=numWC, height=numHC)
				numWR = objPageL.mediabox.right
				numHR = objPageL.mediabox.top
			else:
				objPageR = objReader.pages[numCntInPage]
				numCropXR = objPageR.cropbox.left
				numCropYR = objPageR.cropbox.bottom
				numCropWR = objPageR.cropbox.right
				numCropHR = objPageR.cropbox.top
				print("numCropXR:" , numCropXR)
				print("numCropYR:" , numCropYR)
				print("numCropWR:" , numCropWR)
				print("numCropHR:" , numCropHR)

				numRotationR = objPageR.rotation
				print("numRotationR:" , numRotationR)

			if (numRotationR == 0) | (numRotationR == 180) :
				numWR = numCropWR - numCropXR
				numHR = numCropHR - numCropYR
			elif (numRotationR == 90) | (numRotationR == 270) :
				numWR = numCropHR - numCropYR
				numHR = numCropWR - numCropXR
			print("R :" , numWR , "x" , numHR)
			numCntInPage = numCntInPage + 1
#########################################新規ページの高さは最大値
			if numHR >= numHL:
				numNewH = numHR
			else:
				numNewH = numHL
#########################################新規ページの幅
			numNewW = numWL + numWL + numWC
#########################################3Wサイズで新規ページ
			print("3W:" , numNewW , "x" , numNewH)
			objNewPage =  PageObject.create_blank_page(None,numNewW,numNewH)
#############左側ページのリサイズと回転
			if (numRotationL == 0):
				numNewRotationL = 0
				numTXL = 0 
				numTYL = 0 
			elif (numRotationL == 90):
				numNewRotationL = 270
				numTXL = 0 - numCropYL
				numTYL = numHL + numCropXL
			elif (numRotationL == 180):
				numNewRotationL = 180
				numTXL = numWL + numCropXL
				numTYL = numHL + numCropYL
			elif (numRotationL == 270):
				numNewRotationL = 90
				numTXL = numWL + numCropYL
				numTYL = 0 - numCropXL
			print("numTXL :" , numTXL , "numTYL :" , numTYL)
			print("############")
			objOption = Transformation().rotate(numNewRotationL).translate(tx=numTXL, ty=numTYL)
			objPageL.add_transformation(objOption,True)
			objPageL.mediabox = RectangleObject((0,0,numNewW,numNewH))
			objPageL.cropbox = RectangleObject((0,0,numNewW,numNewH))
			objPageL.trimbox = RectangleObject((0,0,numNewW,numNewH))
			objPageL.bleedbox = RectangleObject((0,0,numNewW,numNewH))
			objPageL.artbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.merge_page(objPageL,False)
#############中央ページのリサイズと回転
			if (numRotationC == 0):
				numNewRotationC = 0
				numTXC = numWL
				numTYC = 0 
			elif (numRotationC == 90):
				numNewRotationC = 270
				numTXC = numWL
				numTYC = numHC + numCropXC
			elif (numRotationC == 180):
				numNewRotationC = 180
				numTXC = numWL + numWC
				numTYC = numHC + numCropYC
			elif (numRotationC == 270):
				numNewRotationC = 90
				numTXC = numWL + numWC
				numTYC = 0 - numCropXC
			print("numTXL:" , numTXL , "numTXC:" , numTXC)
			objOption = Transformation().rotate(numNewRotationC).translate(tx=(numTXC), ty=numTYC)
			objPageC.add_transformation(objOption,True)
			objPageC.mediabox = RectangleObject((0,0,numNewW,numNewH))
			objPageC.cropbox = RectangleObject((0,0,numNewW,numNewH))
			objPageC.trimbox = RectangleObject((0,0,numNewW,numNewH))
			objPageC.bleedbox = RectangleObject((0,0,numNewW,numNewH))
			objPageC.artbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.merge_page(objPageC,False)
#############右側ページのリサイズと回転
			if (numRotationR == 0):
				numNewRotationR = 0
				numTXR = numWL + numWC
				numTYR = 0
			elif (numRotationR == 90):
				numNewRotationR = 270
				numTXR = numWL + numWC
				numTYR = numHR + numCropXR
			elif (numRotationR == 180):
				numNewRotationR = 180
				numTXR = numWL + numWC + numWR
				numTYR = numHR + numCropYR
			elif (numRotationR == 270):
				numNewRotationR = 90
				numTXR = numWL + numWC + numWR
				numTYR = 0 - numCropXR
			print("numTXR:" , numTXR , "numTYR:" , numTYR)
			objOption = Transformation().rotate(numNewRotationR).translate(tx=numTXR, ty=numTYR)
			objPageR.add_transformation(objOption,True)
			objPageR.mediabox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.cropbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.trimbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.bleedbox = RectangleObject((0,0,numNewW,numNewH))
			objPageR.artbox = RectangleObject((0,0,numNewW,numNewH))
			objNewPage.merge_page(objPageR,True)
#########################################新規ページのサイズ確定
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


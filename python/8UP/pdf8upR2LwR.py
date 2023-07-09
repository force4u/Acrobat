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
#############奇数偶数判定使わないけど
		if numAllPage % 2 == 0:
			print("偶数")  
		else:
			print("奇数") 
		numRepeatTImes = math.ceil(numAllPage / 8 )
		print(numRepeatTImes)
#########################################ページ数
		numCntInPage = int(0)
		for numTimes in range(numRepeatTImes):
##########################################
########################################## １／８
			objPageURR = objReader.pages[numCntInPage]
			numCropXURR = objPageURR.cropbox.left
			numCropYURR = objPageURR.cropbox.bottom
			numCropWURR = objPageURR.cropbox.right
			numCropHURR = objPageURR.cropbox.top
			numRotationURR = objPageURR.rotation
			if (numRotationURR == 0) | (numRotationURR == 180) :
				numWURR = numCropWURR - numCropXURR
				numHURR = numCropHURR - numCropYURR
			elif (numRotationURR == 90) | (numRotationURR == 270) :
				numWURR = numCropHURR - numCropYURR
				numHURR = numCropWURR - numCropXURR
			numCntInPage = numCntInPage + 1
######################################### ２／８
			if numCntInPage >= (numAllPage):
				if (numRotationURR == 0) | (numRotationURR == 180) :
						objPageUCR = PageObject.create_blank_page(width=numWURR, height=numHURR)
				elif (numRotationURR == 90) | (numRotationURR == 270) :
						objPageUCR = PageObject.create_blank_page(width=numHURR, height=numWURR)
				numCropWUCR = objPageUCR.mediabox.right
				numCropHUCR = objPageUCR.mediabox.top
				numRotationUCR = numRotationURR
				numCropXUCR = 0
				numCropYUCR = 0
			else:
				objPageUCR = objReader.pages[numCntInPage]
				numCropXUCR = objPageUCR.cropbox.left
				numCropYUCR = objPageUCR.cropbox.bottom
				numCropWUCR = objPageUCR.cropbox.right
				numCropHUCR = objPageUCR.cropbox.top
				numRotationUCR = objPageUCR.rotation
			if (numRotationUCR == 0) | (numRotationUCR == 180) :
				numWUCR = numCropWUCR - numCropXUCR
				numHUCR = numCropHUCR - numCropYUCR
			elif (numRotationUCR == 90) | (numRotationUCR == 270) :
				numWUCR = numCropHUCR - numCropYUCR
				numHUCR = numCropWUCR - numCropXUCR
			numCntInPage = numCntInPage + 1
######################################### ３／８
			if numCntInPage >= (numAllPage):
				if (numRotationUCR == 0) | (numRotationUCR == 180) :
						objPageUCL = PageObject.create_blank_page(width=numWUCR, height=numHUCR)
				elif (numRotationUCR == 90) | (numRotationUCR == 270) :
						objPageUCL = PageObject.create_blank_page(width=numHUCR, height=numWUCR)
				numCropWUCL = objPageUCL.mediabox.right
				numCropHUCL = objPageUCL.mediabox.top
				numRotationUCL = numRotationUCL
				numCropXUCL = 0
				numCropYUCL = 0
			else:
				objPageUCL = objReader.pages[numCntInPage]
				numCropXUCL = objPageUCL.cropbox.left
				numCropYUCL = objPageUCL.cropbox.bottom
				numCropWUCL = objPageUCL.cropbox.right
				numCropHUCL = objPageUCL.cropbox.top
				numRotationUCL = objPageUCL.rotation
			if (numRotationUCL == 0) | (numRotationUCL == 180) :
				numWUCL = numCropWUCL - numCropXUCL
				numHUCL = numCropHUCL - numCropYUCL
			elif (numRotationUCL == 90) | (numRotationUCL == 270) :
				numWUCL = numCropHUCL - numCropYUCL
				numHUCL = numCropWUCL - numCropXUCL
			numCntInPage = numCntInPage + 1
######################################### ４／８
			if numCntInPage >= (numAllPage):
				if (numRotationUCL == 0) | (numRotationUCL == 180) :
						objPageULL = PageObject.create_blank_page(width=numWUCL, height=numHUCL)
				elif (numRotationUCL == 90) | (numRotationUCL == 270) :
						objPageULL = PageObject.create_blank_page(width=numHUCL, height=numWUCL)
				numCropWULL = objPageULL.mediabox.right
				numCropHULL = objPageULL.mediabox.top
				numRotationULL = numRotationUCL
				numCropXULL = 0
				numCropYULL = 0
			else:
				objPageULL = objReader.pages[numCntInPage]
				numCropXULL = objPageULL.cropbox.left
				numCropYULL = objPageULL.cropbox.bottom
				numCropWULL = objPageULL.cropbox.right
				numCropHULL = objPageULL.cropbox.top
				numRotationULL = objPageULL.rotation
			if (numRotationULL == 0) | (numRotationULL == 180) :
				numWULL = numCropWULL - numCropXULL
				numHULL = numCropHULL - numCropYULL
			elif (numRotationULL == 90) | (numRotationULL == 270) :
				numWULL = numCropHULL - numCropYULL
				numHULL = numCropWULL - numCropXULL
			numCntInPage = numCntInPage + 1
#########################################
#########################################　 ５／８
			if numCntInPage >= (numAllPage):
				if (numRotationULL == 0) | (numRotationULL == 180) :
						objPageBRR = PageObject.create_blank_page(width=numWULL, height=numHULL)
				elif (numRotationULL == 90) | (numRotationULL == 270) :
						objPageBRR = PageObject.create_blank_page(width=numHULL, height=numWULL)
				numCropWBRR = objPageBRR.mediabox.right
				numCropHBRR = objPageBRR.mediabox.top
				numRotationBRR = numRotationULL
				numCropXBRR = 0
				numCropYBRR = 0
			else:
				objPageBRR = objReader.pages[numCntInPage]
				numCropXBRR = objPageBRR.cropbox.left
				numCropYBRR = objPageBRR.cropbox.bottom
				numCropWBRR = objPageBRR.cropbox.right
				numCropHBRR = objPageBRR.cropbox.top
				numRotationBRR = objPageBRR.rotation
			if (numRotationBRR == 0) | (numRotationBRR == 180) :
				numWBRR = numCropWBRR - numCropXBRR
				numHBRR = numCropHBRR - numCropYBRR
			elif (numRotationBRR == 90) | (numRotationBRR == 270) :
				numWBRR = numCropHBRR - numCropYBRR
				numHBRR = numCropWBRR - numCropXBRR
			numCntInPage = numCntInPage + 1
#########################################　 ６／８
			if numCntInPage >= (numAllPage):
				if (numRotationBRR == 0) | (numRotationBRR == 180) :
						objPageBCR = PageObject.create_blank_page(width=numWBRR, height=numHBRR)
				elif (numRotationBRR == 90) | (numRotationBRR == 270) :
						objPageBCR = PageObject.create_blank_page(width=numHBRR, height=numWBRR)
				numCropWBCR = objPageBCR.mediabox.right
				numCropHBCR = objPageBCR.mediabox.top
				numRotationBCR = numRotationBRR
				numCropXBCR = 0
				numCropYBCR = 0
			else:
				objPageBCR = objReader.pages[numCntInPage]
				numCropXBCR = objPageBCR.cropbox.left
				numCropYBCR = objPageBCR.cropbox.bottom
				numCropWBCR = objPageBCR.cropbox.right
				numCropHBCR = objPageBCR.cropbox.top
				numRotationBCR = objPageBCR.rotation
			if (numRotationBCR == 0) | (numRotationBCR == 180) :
				numWBCR = numCropWBCR - numCropXBCR
				numHBCR = numCropHBCR - numCropYBCR
			elif (numRotationBCR == 90) | (numRotationBCR == 270) :
				numWBCR = numCropHBCR - numCropYBCR
				numHBCR = numCropWBCR - numCropXBCR
			numCntInPage = numCntInPage + 1
#########################################　 ７／８
			if numCntInPage >= (numAllPage):
				if (numRotationBCR == 0) | (numRotationBCR == 180) :
						objPageBCL = PageObject.create_blank_page(width=numWBCR, height=numHBCR)
				elif (numRotationBCR == 90) | (numRotationBCR == 270) :
						objPageBCL = PageObject.create_blank_page(width=numHBCR, height=numWBCR)
				numCropWBCL = objPageBCL.mediabox.right
				numCropHBCL = objPageBCL.mediabox.top
				numRotationBCL = numRotationBCR
				numCropXBCL = 0
				numCropYBCL = 0
			else:
				objPageBCL = objReader.pages[numCntInPage]
				numCropXBCL = objPageBCL.cropbox.left
				numCropYBCL = objPageBCL.cropbox.bottom
				numCropWBCL = objPageBCL.cropbox.right
				numCropHBCL = objPageBCL.cropbox.top
				numRotationBCL = objPageBCL.rotation
			if (numRotationBCL == 0) | (numRotationBCL == 180) :
				numWBCL = numCropWBCL - numCropXBCL
				numHBCL = numCropHBCL - numCropYBCL
			elif (numRotationBCL == 90) | (numRotationBCL == 270) :
				numWBCL = numCropHBCL - numCropYBCL
				numHBCL = numCropWBCL - numCropXBCL
			numCntInPage = numCntInPage + 1
#########################################　 ８／８
			if numCntInPage >= (numAllPage):
				if (numRotationBCL == 0) | (numRotationBCL == 180) :
						objPageBLL = PageObject.create_blank_page(width=numWBCL, height=numHBCL)
				elif (numRotationBCL == 90) | (numRotationBCL == 270) :
						objPageBLL = PageObject.create_blank_page(width=numHBCL, height=numWBCL)
				numCropWBLL = objPageBLL.mediabox.right
				numCropHBLL = objPageBLL.mediabox.top
				numRotationBLL = numRotationBCL
				numCropXBLL = 0
				numCropYBLL = 0
			else:
				objPageBLL = objReader.pages[numCntInPage]
				numCropXBLL = objPageBLL.cropbox.left
				numCropYBLL = objPageBLL.cropbox.bottom
				numCropWBLL = objPageBLL.cropbox.right
				numCropHBLL = objPageBLL.cropbox.top
				numRotationBLL = objPageBLL.rotation
			if (numRotationBLL == 0) | (numRotationBLL == 180) :
				numWBLL = numCropWBLL - numCropXBLL
				numHBLL = numCropHBLL - numCropYBLL
			elif (numRotationBLL == 90) | (numRotationBLL == 270) :
				numWBLL = numCropHBLL - numCropYBLL
				numHBLL = numCropWBLL - numCropXBLL
			numCntInPage = numCntInPage + 1
#########################################
#########################################
#############高さは最大値
#			print(numHULL, numHUCL, numHUCR, numHURR, numHBLL, numHBCL, numHBCR, numHBRR)
#			print(numWULL , numWUCL , numWUCR , numWURR)
#			print(numWBLL , numWBCL , numWBCR , numWBRR)
			numH = max(numHULL, numHUCL, numHUCR, numHURR, numHBLL, numHBCL, numHBCR, numHBRR)
			numNewH = numH * 2
#############新規ページの幅 上段と下段で大きい方
			numWU = numWULL + numWUCL + numWUCR + numWURR
			numWB = numWBLL + numWBCL + numWBCR + numWBRR
			if numWU > numWB :
				numNewW = numWU
			else:
				numNewW = numWB
#############
			print("Page-" ,numCntInPage ,"Size:" , numNewW , "x" , numNewH)
			objNewPage =  PageObject.create_blank_page(None,numNewW,numNewH)
#########################################
#########################################
#########################################上段 左　左
			if (numRotationULL == 0):
				numSetRotation = 0
				numTXL = 0 - numCropXULL
				numTYL = numHULL - numCropYULL
			elif (numRotationULL == 90):
				numSetRotation = 270
				numTXL = 0 - numCropYULL
				numTYL = numNewH + numCropXULL
			elif (numRotationULL == 180):
				numSetRotation = 180
				numTXL = numWULL + numCropXULL
				numTYL = numNewH + numCropYULL
			elif (numRotationULL == 270):
				numSetRotation = 90
				numTXL = numWULL + numCropYULL
				numTYL = numHULL - numCropXULL
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageULL.add_transformation(objOption,True)
			objPageULL.mediabox = RectangleObject((0,numHULL,numWULL,numNewH))
			objPageULL.cropbox = RectangleObject((0,numHULL,numWULL,numNewH))
			objPageULL.trimbox = RectangleObject((0,numHULL,numWULL,numNewH))
			objPageULL.bleedbox = RectangleObject((0,numHULL,numWULL,numNewH))
			objPageULL.artbox = RectangleObject((0,numHULL,numWULL,numNewH))
			objNewPage.merge_page(objPageULL,False)
#########################################上段 左
			if (numRotationUCL == 0):
				numSetRotation = 0
				numTXL = numWULL - numCropXUCL
				numTYL = numHUCL - numCropYUCL
			elif (numRotationUCL == 90):
				numSetRotation = 270
				numTXL = numWULL  - numCropYUCL
				numTYL = numNewH + numCropXUCL
			elif (numRotationUCL == 180):
				numSetRotation = 180
				numTXL = numWULL + numWUCL + numCropXUCL
				numTYL = numNewH + numCropYUCL
			elif (numRotationUCL == 270):
				numSetRotation = 90
				numTXL = numWULL + numWUCL  + numCropYUCL
				numTYL = numHUCL - numCropXUCL
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageUCL.add_transformation(objOption,True)
			objPageUCL.mediabox = RectangleObject((0,numHUCL,numWUCL + numWUCL,numNewH))
			objPageUCL.cropbox = RectangleObject((numWUCL,numHUCL,numWUCL + numWUCL,numNewH))
			objPageUCL.trimbox = RectangleObject((0,numHUCL,numWUCL + numWUCL,numNewH))
			objPageUCL.bleedbox = RectangleObject((0,numHUCL,numWUCL + numWUCL,numNewH))
			objPageUCL.artbox = RectangleObject((0,numHUCL,numWUCL + numWUCL,numNewH))
			objNewPage.merge_page(objPageUCL,False)
#########################################上段 右
			if (numRotationUCR == 0):
				numSetRotation = 0
				numTXL = numWUCL + numWUCL - numCropXUCR
				numTYL = numHUCR - numCropYUCR
			elif (numRotationUCR == 90):
				numSetRotation = 270
				numTXL = numWULL + numWUCL   - numCropYUCR
				numTYL = numNewH + numCropXUCR
			elif (numRotationUCR == 180):
				numSetRotation = 180
				numTXL = numWULL + numWUCL + numWUCR + numCropXUCR
				numTYL = numNewH + numCropYUCR
			elif (numRotationUCR == 270):
				numSetRotation = 90
				numTXL = numWULL + numWUCL + numWUCR  + numCropYUCR
				numTYL = numHUCR - numCropXUCR
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageUCR.add_transformation(objOption,True)
			objPageUCR.mediabox = RectangleObject((0,numHUCR,numWULL + numWUCL + numWUCR,numNewH))
			objPageUCR.cropbox = RectangleObject((numWULL + numWUCL,numHUCR,numWULL + numWUCL + numWUCR,numNewH))
			objPageUCR.trimbox = RectangleObject((0,numHUCR,numWULL + numWUCL + numWUCR,numNewH))
			objPageUCR.bleedbox = RectangleObject((0,numHUCR,numWULL + numWUCL + numWUCR,numNewH))
			objPageUCR.artbox = RectangleObject((0,numHUCR,numWULL + numWUCL + numWUCR,numNewH))
			objNewPage.merge_page(objPageUCR,False)
#########################################上段 右 右
			if (numRotationURR == 0):
				numSetRotation = 0
				numTXL = numWULL + numWUCL  + numWUCR - numCropXURR
				numTYL = numHURR - numCropYURR
			elif (numRotationURR == 90):
				numSetRotation = 270
				numTXL = numWULL + numWUCL  + numWUCR  - numCropYURR
				numTYL = numNewH + numCropXURR
			elif (numRotationURR == 180):
				numSetRotation = 180
				numTXL = numWULL + numWUCL + numWUCR + numWURR + numCropXURR
				numTYL = numNewH + numCropYURR
			elif (numRotationURR == 270):
				numSetRotation = 90
				numTXL = numWULL + numWUCL + numWUCR + numWURR + numCropYURR
				numTYL = numHURR  - numCropXURR
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageURR.add_transformation(objOption,True)
			objPageURR.mediabox = RectangleObject((0,numHURR,numWULL + numWUCL + numWUCR + numWURR,numNewH))
			objPageURR.cropbox = RectangleObject((numWULL + numWUCL + numWUCR ,numHURR,numWULL + numWUCL + numWUCR  + numWURR,numNewH))
			objPageURR.trimbox = RectangleObject((0,numHURR,numWULL + numWUCL + numWUCR  + numWURR,numNewH))
			objPageURR.bleedbox = RectangleObject((0,numHURR,numWULL + numWUCL + numWUCR  + numWURR,numNewH))
			objPageURR.artbox = RectangleObject((0,numHURR,numWULL + numWUCL + numWUCR  + numWURR,numNewH))
			objNewPage.merge_page(objPageURR,False)
#########################################
#########################################
#########################################下段 左　左
			if (numRotationBLL == 0):
				numSetRotation = 0
				numTXL = 0 - numCropXBLL
				numTYL = 0 - numCropYBLL
			elif (numRotationBLL == 90):
				numSetRotation = 270
				numTXL = 0 - numCropYBLL
				numTYL = numHBLL + numCropXBLL
			elif (numRotationBLL == 180):
				numSetRotation = 180
				numTXL = numWBLL + numCropXBLL
				numTYL = numHBLL + numCropYBLL
			elif (numRotationBLL == 270):
				numSetRotation = 90
				numTXL = numWBLL + numCropYBLL
				numTYL = 0 - numCropXBLL
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageBLL.add_transformation(objOption,True)
			objPageBLL.mediabox = RectangleObject((0,0,numWBLL,numHBLL))
			objPageBLL.cropbox = RectangleObject((0,0,numWBLL,numHBLL))
			objPageBLL.trimbox = RectangleObject((0,0,numWBLL,numHBLL))
			objPageBLL.bleedbox = RectangleObject((0,0,numWBLL,numHBLL))
			objPageBLL.artbox = RectangleObject((0,0,numWBLL,numHBLL))
			objNewPage.merge_page(objPageBLL,False)
#########################################下段 左
			if (numRotationBCL == 0):
				numSetRotation = 0
				numTXL = numWBLL - numCropXBCL
				numTYL = 0 - numCropYBCL
			elif (numRotationBCL == 90):
				numSetRotation = 270
				numTXL = numWBLL - numCropYBCL
				numTYL = numHBCL + numCropXBCL
			elif (numRotationBCL == 180):
				numSetRotation = 180
				numTXL = numWBLL + numWBCL + numCropXBCL
				numTYL = numHBCL + numCropYBCL
			elif (numRotationBCL == 270):
				numSetRotation = 90
				numTXL = numWBLL + numWBCL + numCropYBCL
				numTYL = 0 - numCropXBCL
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageBCL.add_transformation(objOption,True)
			objPageBCL.mediabox = RectangleObject((0,0,numWBCL + numWBCL,numHBCL))
			objPageBCL.cropbox = RectangleObject((numWBCL,0,numWBCL + numWBCL,numHBCL))
			objPageBCL.trimbox = RectangleObject((0,0,numWBCL + numWBCL,numHBCL))
			objPageBCL.bleedbox = RectangleObject((0,0,numWBCL + numWBCL,numHBCL))
			objPageBCL.artbox = RectangleObject((0,0,numWBCL + numWBCL,numHBCL))
			objNewPage.merge_page(objPageBCL,False)
#########################################下段 右
			if (numRotationBCR == 0):
				numSetRotation = 0
				numTXL = numWBCL + numWBCL - numCropXBCR
				numTYL = 0 - numCropYBCR
			elif (numRotationBCR == 90):
				numSetRotation = 270
				numTXL = numWBLL + numWBCL  - numCropYBCR
				numTYL = numHBCR + numCropXBCR
			elif (numRotationBCR == 180):
				numSetRotation = 180
				numTXL = numWBLL + numWBCR + numWBCL + numCropXBCR
				numTYL = numHBCR + numCropYBCR
			elif (numRotationBCR == 270):
				numSetRotation = 90
				numTXL = numWBLL + numWBCL + numWBCR + numCropYBCR
				numTYL = 0 - numCropXBCR
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageBCR.add_transformation(objOption,True)
			objPageBCR.mediabox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR,numHBCR))
			objPageBCR.cropbox = RectangleObject((numWBLL + numWBCL ,0,numWBLL + numWBCL + numWBCR,numHBCR))
			objPageBCR.trimbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR,numHBCR))
			objPageBCR.bleedbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR,numHBCR))
			objPageBCR.artbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR,numHBCR))
			objNewPage.merge_page(objPageBCR,False)
#########################################下段 右 右
			if (numRotationBRR == 0):
				numSetRotation = 0
				numTXL = numWBLL + numWBCL  + numWBCR - numCropXBRR
				numTYL = 0 - numCropYBRR
			elif (numRotationBRR == 90):
				numSetRotation = 270
				numTXL = numWBLL + numWBCL + numWBCR - numCropYBRR
				numTYL = numHBRR + numCropXBRR
			elif (numRotationBRR == 180):
				numSetRotation = 180
				numTXL = numWBLL + numWBCR + numWBCL + numWBLL + numCropXBRR
				numTYL = numHBRR + numCropYBRR
			elif (numRotationBRR == 270):
				numSetRotation = 90
				numTXL = numWBLL + numWBCL + numWBCR + numWBRR + numCropYBRR
				numTYL = 0 - numCropXBRR
			objOption = Transformation().rotate(numSetRotation).translate(tx=numTXL, ty=numTYL)
			objPageBRR.add_transformation(objOption,True)
			objPageBRR.mediabox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR + numWBRR,numHBRR))
			objPageBRR.cropbox = RectangleObject((numWBLL + numWBCL + numWBCR ,0,numWBLL + numWBCL + numWBCR  + numWBRR,numHBRR))
			objPageBRR.trimbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR  + numWBRR,numHBRR))
			objPageBRR.bleedbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR  + numWBRR,numHBRR))
			objPageBRR.artbox = RectangleObject((0,0,numWBLL + numWBCL + numWBCR  + numWBRR,numHBRR))
			objNewPage.merge_page(objPageBRR,False)
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


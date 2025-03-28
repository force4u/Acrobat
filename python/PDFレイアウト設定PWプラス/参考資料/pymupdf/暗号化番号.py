#!/usr/bin/env python3
#coding: utf-8
import pymupdf
import sys


array_enc_name = [
    "PDF_ENCRYPT_KEEP",
    "PDF_ENCRYPT_NONE",
    "PDF_ENCRYPT_RC4_40",
    "PDF_ENCRYPT_RC4_128",
    "PDF_ENCRYPT_AES_128",
    "PDF_ENCRYPT_AES_256",
    "PDF_ENCRYPT_UNKNOWN",
]

for itemNAME in array_enc_name:
    str_set_enc = getattr(pymupdf, itemNAME, None)
    print(f"{itemNAME}: {str_set_enc}")

sys.exit(0)


PDF_ENCRYPT_KEEP: 0
PDF_ENCRYPT_NONE: 1
PDF_ENCRYPT_RC4_40: 2
PDF_ENCRYPT_RC4_128: 3
PDF_ENCRYPT_AES_128: 4
PDF_ENCRYPT_AES_256: 5
PDF_ENCRYPT_UNKNOWN: 6
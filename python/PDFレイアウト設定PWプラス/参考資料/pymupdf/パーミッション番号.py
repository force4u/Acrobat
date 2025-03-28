#!/usr/bin/env python3
#coding: utf-8
import pymupdf
import sys
array_perm_name = ["PDF_PERM_PRINT", "PDF_PERM_MODIFY", "PDF_PERM_COPY", "PDF_PERM_ANNOTATE", "PDF_PERM_FORM", "PDF_PERM_ACCESSIBILITY", "PDF_PERM_ASSEMBLE", "PDF_PERM_PRINT_HQ"]

for itemNAME in array_perm_name:
    str_set_enc = getattr(pymupdf, itemNAME, None)
    print(f"{itemNAME}: {str_set_enc}")

sys.exit(0)

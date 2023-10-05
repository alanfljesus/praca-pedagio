*&---------------------------------------------------------------------*
*& Include z_exibircobranca_abap26_s01
*&---------------------------------------------------------------------*
TABLES: ztabela_abap26.

DATA: gt_pedagio TYPE STANDARD TABLE OF ztabela_abap26,
      go_alv     TYPE REF TO cl_salv_table. " OBJETO ALV

SELECTION-SCREEN BEGIN OF BLOCK b1.
  SELECT-OPTIONS:
  s_dat FOR ztabela_abap26-data_criacao,
  s_ope FOR ztabela_abap26-operador,
  s_cat FOR ztabela_abap26-categoria,
  s_for FOR ztabela_abap26-forma_pagto.
SELECTION-SCREEN END OF BLOCK b1.

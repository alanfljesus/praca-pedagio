*&---------------------------------------------------------------------*
*& Include zcobra_pedagio_abap26_s01
*&---------------------------------------------------------------------*

TABLES: ztabela_abap26, sscrfields.

" DEFINIÇÃO DE DADOS

DATA: s_pedagio TYPE ztabela_abap26.

DATA: gv_categoria TYPE zcategoria_abap26,
      gv_placa     TYPE zplaca_abap26.

SELECTION-SCREEN BEGIN OF BLOCK b1.
  PARAMETERS: p_ope TYPE zoperador_abap26,
              p_cat TYPE zcategoria_abap26,
              p_for TYPE zformapagamento_abap26,
              p_pla TYPE zplaca_abap26.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN FUNCTION KEY 1.

*&---------------------------------------------------------------------*
*& Include z_exibircobranca_abap26_f01
*&---------------------------------------------------------------------*


TYPES: BEGIN OF ty_relatorio.
         INCLUDE STRUCTURE ztabela_abap26.
TYPES:   nome         TYPE ad_namtext,
         desc_cat(30) TYPE c,
       END OF ty_relatorio.

DATA: gt_relatorio TYPE TABLE OF ty_relatorio.

*&---------------------------------------------------------------------*
*& Form f_leitura_de_dados
*&---------------------------------------------------------------------*
FORM f_leitura_de_dados.
  DATA: ls_relatorio TYPE ty_relatorio.

  SELECT * FROM ztabela_abap26 INTO TABLE gt_pedagio
  WHERE data_criacao IN s_dat
  AND operador IN s_ope
  AND categoria IN s_cat
  AND forma_pagto IN s_for.

  IF sy-subrc NE 0.
    MESSAGE 'Sem dados para os parâmetros informados.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  SORT gt_pedagio BY data_criacao DESCENDING hora_criacao ASCENDING.
*  MOVE-CORRESPONDING gt_pedagio TO gt_relatorio.

  " SELECIONAR O NOME COMPLETO DOS USUÁRIOS
  SORT gt_pedagio BY operador.
*  DELETE ADJACENT DUPLICATES FROM gt_pedagio COMPARING operador.

  SELECT bname, name_textc
  FROM user_addr
  INTO TABLE @DATA(lt_user)
  FOR ALL ENTRIES IN @gt_pedagio
  WHERE bname EQ @gt_pedagio-operador.

*  LOOP AT gt_relatorio INTO DATA(ls_relatorio).
*    READ TABLE lt_user INTO DATA(ls_user)
*    WITH KEY bname = ls_relatorio-operador.
*
*    IF sy-subrc EQ 0.
*      ls_relatorio-nome = ls_user-name_textc.
*
*      MODIFY gt_relatorio FROM ls_relatorio.
*    ENDIF.
*  ENDLOOP.

  LOOP AT gt_pedagio INTO DATA(ls_pedagio).

    CLEAR ls_relatorio.
    MOVE-CORRESPONDING ls_pedagio TO ls_relatorio.

    READ TABLE lt_user INTO DATA(ls_user)
    WITH KEY bname = ls_relatorio-operador.

    IF sy-subrc EQ 0.
      ls_relatorio-nome = ls_user-name_textc.

      APPEND ls_relatorio TO gt_relatorio.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_exibir_dados
*&---------------------------------------------------------------------*
FORM f_exibir_dados.
  cl_salv_table=>factory(
  IMPORTING
  r_salv_table = go_alv
  CHANGING
  t_table = gt_relatorio
 ).
  go_alv->display( ).
ENDFORM.

*&---------------------------------------------------------------------*
*& Include zcobra_pedagio_abap26_f01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form f_grava_cobranca
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_grava_cobranca .

  s_pedagio-data_criacao = sy-datum.
  s_pedagio-hora_criacao = sy-uzeit.
*  s_pedagio-RECIBO
  s_pedagio-operador = p_ope.
  s_pedagio-categoria = gv_categoria.
  s_pedagio-forma_pagto = p_for.
  s_pedagio-placa = gv_placa.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '01'
      object                  = 'ZRECPEDA26'
    IMPORTING
      number                  = s_pedagio-recibo
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION 'ZBUSCARTARIFA_ABAP26'
    EXPORTING
      iv_categoria   = gv_categoria
    IMPORTING
      ev_valor       = s_pedagio-valor
    EXCEPTIONS
      nao_encontrado = 1.

  SELECT SINGLE valor FROM ztarifa_abap26
    INTO s_pedagio-valor
    WHERE categoria = gv_categoria.

  INSERT ztabela_abap26 FROM s_pedagio.

  IF sy-subrc EQ 0.
    MESSAGE 'Registro inserido.' TYPE 'S'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_exibe_cobranca
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_exibe_cobranca .

  WRITE:
   'DOC. FISCAL EQUIVALENTE IN1731/17 Art.2',
   / 'AUTOPISTA LITORAL SUL',
   / '09.313.969/0001-97',
   / 'SÃO PAULO', 'KM365',
   / s_pedagio-data_criacao, s_pedagio-hora_criacao, 'Recibo:', s_pedagio-recibo,
   / 'Operador:', s_pedagio-operador, 'Categoria:', s_pedagio-categoria,
   / 'Valor pago:' , s_pedagio-valor, 'F.Pagto:' , s_pedagio-forma_pagto,
   / 'PLACA:', s_pedagio-placa.
ENDFORM.

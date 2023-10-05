*&---------------------------------------------------------------------*
*& Report ZCOBRA_PEDAGIO_ABAP26
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcobra_pedagio_abap26.

" DEFINIÇÃO DE DADOS
INCLUDE zcobra_pedagio_abap26_s01.

" PROCESSAMENTO DE DADOS
INCLUDE zcobra_pedagio_abap26_f01.

INITIALIZATION.
  p_ope = sy-uname.
  p_for = '01'.


  MOVE 'Relatório' TO sscrfields-functxt_01.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'FC01'.
    SUBMIT z_exibircobranca_abap26 VIA SELECTION-SCREEN.
  ENDIF.

  gv_categoria = p_cat.
  CLEAR p_cat.
  gv_placa = p_pla.
  CLEAR p_pla.

START-OF-SELECTION.

  " MENSAGEM DE ERRO
  IF gv_categoria IS INITIAL. " Initial = 0
    MESSAGE 'Preencher categoria.' TYPE 'S' DISPLAY LIKE 'E'. " DESSA MANEIRA A TELA PERMANECE PARADA E A MENSAGEM DE ERRO APARECE SEM CAUSAR ALTERAÇÕES
    EXIT.
  ENDIF.

  PERFORM f_grava_cobranca.

  PERFORM f_exibe_cobranca.

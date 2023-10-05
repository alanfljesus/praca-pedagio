*&---------------------------------------------------------------------*
*& Report z_exibircobranca_abap26
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_exibircobranca_abap26.

INCLUDE z_exibircobranca_abap26_s01.

INCLUDE z_exibircobranca_abap26_f01.

START-OF-SELECTION.

PERFORM f_leitura_de_dados.

PERFORM f_exibir_dados.

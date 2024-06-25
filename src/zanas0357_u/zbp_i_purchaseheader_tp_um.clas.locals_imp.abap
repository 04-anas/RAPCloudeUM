CLASS lhc_ZI_PURCHASEHEADER_TP_UM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_purchaseheader_tp_um RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zi_purchaseheader_tp_um.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_purchaseheader_tp_um.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_purchaseheader_tp_um.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchaseheader_tp_um RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_purchaseheader_tp_um.

    METHODS rba_Purchaseitem FOR READ
      IMPORTING keys_rba FOR READ zi_purchaseheader_tp_um\_Purchaseitem FULL result_requested RESULT result LINK association_links.

    METHODS cba_Purchaseitem FOR MODIFY
      IMPORTING entities_cba FOR CREATE zi_purchaseheader_tp_um\_Purchaseitem.

ENDCLASS.

CLASS lhc_ZI_PURCHASEHEADER_TP_UM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Purchaseitem.
  ENDMETHOD.

  METHOD cba_Purchaseitem.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_PURCHASE_ITEAM_TP_UM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_purchase_iteam_tp_um.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_purchase_iteam_tp_um.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchase_iteam_tp_um RESULT result.

    METHODS rba_Purchaseheader FOR READ
      IMPORTING keys_rba FOR READ zi_purchase_iteam_tp_um\_Purchaseheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_PURCHASE_ITEAM_TP_UM IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Purchaseheader.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_PURCHASEHEADER_TP_UM DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_PURCHASEHEADER_TP_UM IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

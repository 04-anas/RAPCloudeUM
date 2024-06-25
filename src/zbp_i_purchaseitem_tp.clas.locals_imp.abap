CLASS lhc_zi_purchase_iteam_tp DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS SetPurchaseStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZI_PURCHASE_ITEAM_TP~SetPurchaseStatus.

ENDCLASS.

CLASS lhc_zi_purchase_iteam_tp IMPLEMENTATION.

  METHOD SetPurchaseStatus.
 data: lv_total_price type p LENGTH 10 DECIMALS 2.
* first read the data
  READ ENTIty IN LOCAL MODE
  zi_purchase_iteam_tp
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT data(lt_item).
  LOOP at lt_item into data(ls_item).

  lv_total_price = (  ls_item-ProductPrice * ls_item-OrderQunty ) + lv_total_price.

  ENDLOOP.

  data(lv_po_number) = keys[ 1 ]-PurchaseOrderNumber.
  if lv_total_price > 1000.

  MODIFY entity IN LOCAL MODE
  ZI_PurchaseHeader_TP
  UPDATE FIELDS ( po_status )
  with VALUE #( ( PurchaseOrderNumber = lv_po_number po_status = '01' )  )
  REPORTED data(lt_reported).
  ENDIF.


  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

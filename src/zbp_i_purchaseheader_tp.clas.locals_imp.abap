CLASS lhc_ZI_PurchaseHeader_TP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZI_PurchaseHeader_TP RESULT result.
    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION zi_purchaseheader_tp~copy RESULT result.

    METHODS withdrawapproval FOR MODIFY
      IMPORTING keys FOR ACTION zi_purchaseheader_tp~withdrawapproval RESULT result.
    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_purchaseheader_tp~validatestatus.
    METHODS earlynumbering_cba_purchaseite FOR NUMBERING
      IMPORTING entities FOR CREATE zi_purchaseheader_tp\_purchaseitem.
    METHODS earlynumbering_cba_attachite FOR NUMBERING
      IMPORTING entities FOR CREATE zi_purchaseheader_tp\_Po_attachment.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_purchaseheader_tp.

ENDCLASS.

CLASS lhc_ZI_PurchaseHeader_TP IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA: lv_max_po TYPE c LENGTH 10.
    SELECT MAX( PurchaseOrderNumber )
    FROM zc_purchaseheader_tp INTO @lv_max_po.
    DATA(lt_entities) = entities. "assigning entity data into local internal table to do operation
    LOOP AT lt_entities INTO DATA(ls_entities).

      lv_max_po = lv_max_po + 1.
      ls_entities-PurchaseOrderNumber = lv_max_po .
      APPEND VALUE #( %cid = ls_entities-%cid
*      // when enable draft feature need to specify that it is draft instance or active instance
                       %is_draft =  ls_entities-%is_draft
                       PurchaseOrderNumber  = ls_entities-PurchaseOrderNumber )
                       TO mapped-zi_purchaseheader_tp.
      CLEAR lv_max_po.
      CLEAR ls_entities.
    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Purchaseite.

*** it will read the data from draft table
    READ ENTITY
    IN LOCAL MODE
    zi_purchaseheader_tp
    BY \_PurchaseItem
    ALL FIELDS WITH CORRESPONDING #( entities )
    RESULT DATA(lt_itemno).


**** it read the data from data base table so when we will create two item at a time it will give error
***  that duplicate key issue
*    SELECT  po_order, po_item AS itemno
*    FROM zpo_iteam_db
*    FOR ALL ENTRIES IN @entities
*    WHERE po_order = @entities-PurchaseOrderNumber INTO TABLE @DATA(lt_itemno).

    DATA(lt_final_key) = entities.
    LOOP AT lt_final_key INTO DATA(ls_final_key).

      SELECT MAX( PurchaseIteam ) FROM @lt_itemno AS itemkeys
      WHERE PurchaseOrderNumber = @ls_final_key-PurchaseOrderNumber
      INTO @DATA(lv_itemno).
      LOOP AT ls_final_key-%target INTO DATA(ls_item).

        IF ls_item-%is_draft = 01.
          lv_itemno += 1 .
        ELSE.
          lv_itemno = ls_item-PurchaseIteam.
        ENDIF.
        ls_item-PurchaseIteam = |{ lv_itemno ALPHA = IN }|.

        APPEND VALUE #( %cid = ls_item-%cid
**        passing %tky because for draft enable we need to pass %is _draft value so %tky all ready having
******** %is_draft value so directly passing %is_Draft.
                       %tky = ls_final_key-%tky
                       %key = ls_item-%key ) TO mapped-zi_purchase_iteam_tp.
      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

  METHOD copy.
    DATA: lt_keys TYPE TABLE FOR READ IMPORT ZI_PurchaseHeader_TP.
*          IF MULTIPLE PO SELECTED ON UI SIDE SO LOOPING REQUIRED HERE
    LOOP AT keys INTO DATA(ls_keys).
      APPEND VALUE #( %key = ls_keys-%key
                        %control-Description = 01 " indicate that read description field
                        %control-CompnyCode = 01
                        %control-OrderType = 01
                        %control-Supplier_id = 01
                        %control-po_status = 01 ) TO lt_keys.

    ENDLOOP.
***step 1  read the purchase order which to be copied
    READ ENTITY IN LOCAL MODE
    ZI_PurchaseHeader_TP
    FROM lt_keys
    RESULT DATA(lt_purchase_data).

**2 create A NEW ENTRY FROM COPY BO

    MODIFY ENTITY IN LOCAL MODE ZI_PurchaseHeader_TP
    CREATE AUTO FILL CID
    FIELDS ( Description CompnyCode OrderType Organization po_status  )
    WITH CORRESPONDING #( lt_purchase_data )
    MAPPED DATA(mapped_create).
*  3 READE THE NEWLY CREATED RECORD
    READ ENTITY IN LOCAL MODE ZI_PurchaseHeader_TP
    ALL FIELDS WITH CORRESPONDING #( mapped_create-ZI_PurchaseHeader_TP )
    RESULT DATA(lt_new_po).

*4 SED BACK TO UI

    DATA:ls_result TYPE TABLE FOR READ RESULT ZI_PurchaseHeader_TP  .

*     result  IS RETURNIG PARAMITER

    result  = VALUE #(  FOR ls_new_po IN lt_new_po INDEX INTO lv_index
                           ( %cid_ref = keys[ lv_index ]-%cid_ref
                             %key = keys[ lv_index ]-%key
                             %param = CORRESPONDING #( ls_new_po )

                            ) ).


  ENDMETHOD.

  METHOD withdrawApproval.

*  Modify approval status
    MODIFY ENTITY IN LOCAL MODE zi_purchaseheader_tp
    UPDATE FIELDS ( po_status Organization )
    WITH VALUE #( FOR ls_key IN keys ( %key = ls_key-%key
                                     po_status = '03'
                                     Organization = '11' ) )
                                     REPORTED DATA(REPORTED_update).
*   Read the record after modifying the status

    READ ENTITY IN LOCAL MODE ZI_PurchaseHeader_TP
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_new_po).

*    *     result is returning parameter .here we passing the data after modifying
    result  = VALUE #(  FOR ls_new_po IN lt_new_po INDEX INTO lv_index
                           ( %cid_ref = keys[ lv_index ]-%cid_ref
                             %key = keys[ lv_index ]-%key
                             %param = CORRESPONDING #( ls_new_po )

                            ) ).

  ENDMETHOD.

  METHOD validateStatus.
    DATA(lo_ref) = NEW cl_abap_behv( ).
*   Read the record
    READ ENTITY IN LOCAL MODE ZI_PurchaseHeader_TP
    FIELDS ( po_status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_new_po).
    LOOP AT lt_new_po INTO DATA(ls_new_po).
      CASE ls_new_po-po_status.
        WHEN '01'.

        WHEN '02'.

        WHEN '03'.

        WHEN OTHERS.
          APPEND VALUE #( %key = ls_new_po-%key ) TO failed-zi_purchaseheader_tp.
          APPEND VALUE #( %key = ls_new_po-%key
                          %msg = lo_ref->new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     =  'Purchase Status is invalid'  )
*                       ASSIGN THE CONSTENT VALUE 01 TO PO_SATUS BY USING CLASS
                          %element-po_status   = if_abap_behV=>mk-on
                                 ) TO reported-zi_purchaseheader_tp.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_attachite.

  READ ENTITY
    IN LOCAL MODE
    zi_purchaseheader_tp
    BY \_Po_attachment
    ALL FIELDS WITH CORRESPONDING #( entities )
    RESULT DATA(lt_itemno).


    DATA(lt_final_key) = entities.
    LOOP AT lt_final_key INTO DATA(ls_final_key).

      SELECT MAX( AttachId ) FROM @lt_itemno AS itemkeys
      WHERE PurchaseOrderNumber = @ls_final_key-PurchaseOrderNumber
      INTO @DATA(lv_itemno).
      LOOP AT ls_final_key-%target INTO DATA(ls_item).

        IF ls_item-%is_draft = 01.
          lv_itemno += 1 .
        ELSE.
          lv_itemno = ls_item-AttachId.
        ENDIF.
        ls_item-AttachId = |{ lv_itemno ALPHA = IN }|.

        APPEND VALUE #( %cid = ls_item-%cid
                       %tky-%is_draft = ls_final_key-%is_draft
                       %key = ls_item-%key ) TO mapped-zi_po_attachment1.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

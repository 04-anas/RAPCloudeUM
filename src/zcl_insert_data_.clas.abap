CLASS zcl_insert_data_ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_INSERT_DATA_ IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



  INSERT ZPOSTATUS2    FROM TABLE @( VALUE #(
       (
       client = '100'
       postatus = '01'
      stdescription = 'in process'
       )
              (
       client = '100'
       postatus = '02'
       stdescription = 'completed'
       )
              (
       client = '100'
       postatus = '03'
       stdescription = 'Rejected'
       )
       ) ).

    SELECT * FROM ZPOSTATUS2 INTO TABLE @DATA(lt_sql_entries).
    IF sy-subrc = 0.
      DATA(numberofrecords) = lines( lt_sql_entries ).
      out->write( numberofrecords && ' entries inserted successfully ' ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.

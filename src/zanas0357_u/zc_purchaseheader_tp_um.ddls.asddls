@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header consumption'
@Metadata.allowExtensions: true
define root view entity ZC_PURCHASEHEADER_TP_UM
 provider contract transactional_query 
 as projection on
ZI_PURCHASEHEADER_TP_UM

{
    key PurchaseOrderNumber,
    Description,
    PurchaseTotalPrice,
    OrderType,
    CompnyCode,
    Organization,
    Supplier_id,
    criticalvalue,
    Imageurl,
    po_status,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    LocalLastChangedBy,
    last_change_at,
    /* Associations */
    _OrderType,
    _PurchaseIteam,
    _PurchaseItem : redirected to composition child ZC_PURCHASE_ITEAM_TP_UM ,
    _status,
    _suplier
   
}

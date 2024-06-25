@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po header  consumption view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_PO_HEADER1 as select from ZI_PO_HEADER1
{
    key PurchaseOrderNumber,
    Description,
    OrderType,
    CompnyCode,
    Organization,
    Supplier_id,
    po_status,
    Imageurl,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    LocalLastChangedBy,
    /* Associations */
    _OrderType,
    _PurchaseIteam,
    _suplier
}

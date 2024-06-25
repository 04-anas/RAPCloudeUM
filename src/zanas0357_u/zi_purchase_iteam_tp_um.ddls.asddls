@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'item cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PURCHASE_ITEAM_TP_UM as select from ZI_PURCHASE_ITEAM
association to parent ZI_PurchaseHeader_TP_UM as _PurchaseHeader 
on $projection.PurchaseOrderNumber = _PurchaseHeader.PurchaseOrderNumber
{
    key PurchaseOrderNumber,
    key PurchaseIteam,
    ShortText,
    Material,
    Plant,
    MaterialGroup,
    @Semantics.quantity.unitOfMeasure: 'OrderUnit'
    OrderQunty,
    OrderUnit,
    @Semantics.amount.currencyCode: 'PriceUnit'
    ProductPrice,
    PriceUnit,
    IteamPrice,
    LocalLastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _Currency,
    _PurchaseHeader 
}

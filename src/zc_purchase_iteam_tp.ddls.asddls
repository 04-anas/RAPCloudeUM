@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PURCHASE_ITEAM_TP as projection on ZI_PURCHASE_ITEAM_TP
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
    _PurchaseHeader :redirected to parent ZC_PURCHASEHEADER_TP,
     _Currency
}

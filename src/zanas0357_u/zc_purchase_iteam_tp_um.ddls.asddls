@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'item consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PURCHASE_ITEAM_TP_UM as projection on ZI_PURCHASE_ITEAM_TP_UM
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
    _PurchaseHeader :redirected to parent ZC_PURCHASEHEADER_TP_UM,
    _Currency
    
}

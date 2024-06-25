@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po iteam consumptionview'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_PURCHASEITEAM
  as select from ZI_PURCHASE_ITEAM
{
  key PurchaseOrderNumber,
  key PurchaseIteam,
      ShortText,
      Material,
      Plant,
      //    OrderType,
      //    Supplier_id,
      MaterialGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      OrderQunty,
      OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      ProductPrice,
      PriceUnit,
      IteamPrice,
      LocalLastChangedBy,
      /* Associations */
      _Currency,
      //    _OrderType,
      _PurchaseHeader
      //    _status,
      //    _suplier

}

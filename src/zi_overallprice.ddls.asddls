@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'overeall price'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_OVERALLPRICE
  as select from ZI_PO_HEADER1
{
  key PurchaseOrderNumber,
      Description,
      sum( _PurchaseIteam.IteamPrice ) as PurchaseTotalPrice,
//      PriceUnit,
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
      _suplier,
       last_change_at
}
group by
  PurchaseOrderNumber,
  Description,
  OrderType,
  CompnyCode,
  Organization,
  Supplier_id,
  Imageurl,
  CreateBy,
  CreatedDateTime,
  ChangedDateTime,
  LocalLastChangedBy,
//  _PurchaseIteam.PriceUnit,
  po_status,
    last_change_at
//    PriceUnit

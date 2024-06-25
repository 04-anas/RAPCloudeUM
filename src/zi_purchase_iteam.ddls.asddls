@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po iteam'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PURCHASE_ITEAM
  as select from zpo_iteam_db
  association [1] to ZI_PO_HEADER1 as _PurchaseHeader on $projection.PurchaseOrderNumber = _PurchaseHeader.PurchaseOrderNumber
  association [1] to I_Currency    as _Currency       on $projection.PriceUnit = _Currency.Currency
  //  association [1]    to ZI_PO_Type       as _OrderType     on $projection.ordertype = _OrderType.PoType
  //  association [1]    to ZI_SUPPLIER      as _suplier       on $projection.supplier_id = _suplier.SupplierId
  //  association[1] to ZI_PO_Status           as _status         on $projection.ordertype = _status.Postatus

{
  key po_order                                                                                                  as PurchaseOrderNumber,
  key po_item                                                                                                   as PurchaseIteam,
      short_text                                                                                                as ShortText,
      material                                                                                                  as Material,
      plant                                                                                                     as Plant,
      //    _PurchaseHeader.OrderType ,
      //    _PurchaseHeader.Supplier_id,
      mat_group                                                                                                 as MaterialGroup,
      @Semantics.quantity.unitOfMeasure: 'OrderUnit'
      order_qunty                                                                                               as OrderQunty,
      order_unit                                                                                                as OrderUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
      product_price                                                                                             as ProductPrice,
      price_unit                                                                                                as PriceUnit,
      cast( cast ( order_qunty as abap.dec(10,2)) * cast(product_price as abap.dec(10,2) )  as abap.dec(10,2) ) as IteamPrice,
      local_last_changed_by                                                                                     as LocalLastChangedBy,
      local_last_changed_at                                                                                     as LocalLastChangedAt,
      //       // Exposing Association
      _PurchaseHeader,

      _Currency
      //     _OrderType,
      //     _suplier,
      //     _status


}

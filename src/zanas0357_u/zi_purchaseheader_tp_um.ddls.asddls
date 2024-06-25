@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header'
define root view entity ZI_PURCHASEHEADER_TP_UM
  as select from ZI_OVERALLPRICE
  composition [1..*] of ZI_PURCHASE_ITEAM_TP_UM as _PurchaseItem
//  composition [1..*] of ZI_PO_ATTACHMENT1 as _Po_attachment
  association [0..1] to ZC__SUPPLIER         as _suplier on $projection.Supplier_id = _suplier.Suuplierid
  association [0..1] to ZC_PO_STATUS         as _status  on $projection.po_status = _status.Postatus
//  association [1] to ZI_PurchasePriority  as _Priority on $projection.Priority = _Priority.Priority
  
{
  key PurchaseOrderNumber,
      Description,
      PurchaseTotalPrice,
      OrderType,
      CompnyCode,
      Organization,
      Supplier_id,
//      PriceUnit,
      case
      when po_status = '01' then 1
      when po_status = '02' then 2
      when po_status = '03' then 3
      else 0
      end as criticalvalue, 
//      case
//       when PurchaseTotalPrice < 500 then '03'
//       when PurchaseTotalPrice > 500 and PurchaseTotalPrice < 1000 then '02'
//       when PurchaseTotalPrice > 1000 then '01'
//      else '00' 
//      end as Priority,
//      
      @Semantics.imageUrl: true
      Imageurl,
      po_status,
      @Semantics.user.createdBy: true
      CreateBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedDateTime,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ChangedDateTime,
      @Semantics.user.localInstanceLastChangedBy:true
      LocalLastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
       last_change_at,
       
      /* Associations */
      _OrderType,
      _PurchaseIteam,
      _suplier,
      _status,
//      _Priority,
      _PurchaseItem
//      _Po_attachment  
}

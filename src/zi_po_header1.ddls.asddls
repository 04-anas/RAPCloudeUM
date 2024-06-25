@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PO_HEADER1
  as select from zpo_header_db2
  association [1..*] to ZI_PURCHASE_ITEAM as _PurchaseIteam on $projection.PurchaseOrderNumber = _PurchaseIteam.PurchaseOrderNumber
  association [1]    to zi_PO_TYPE        as _OrderType     on $projection.OrderType = _OrderType.PoTyppe
  association [0..1]    to ZI_SUPLLIER_DET   as _suplier       on $projection.Supplier_id = _suplier.Suuplierid
{
  key po_order              as PurchaseOrderNumber,
      po_desc               as Description,
      po_type               as OrderType,
      comp_code             as CompnyCode,
      po_org                as Organization,
      supplier              as Supplier_id,
      po_status             as po_status,
      imageurl              as Imageurl,
      create_by             as CreateBy,
      created_date_time     as CreatedDateTime,
      changed_date_time     as ChangedDateTime,
      local_last_changed_by as LocalLastChangedBy,
       last_change_at,
//      _PurchaseIteam.PriceUnit,
      // exposing Association
      _PurchaseIteam,
      _OrderType,
      _suplier
}

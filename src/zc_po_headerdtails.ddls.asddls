@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po header  consumption view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true // to allow metadata extention
@ObjectModel.semanticKey: ['PurchaseOrderNumber'] // Aperiance would change
@Search.searchable: true // to  enable search help on gui screen

define view entity ZC_PO_HEADERDTAILS
  as select from ZI_OVERALLPRICE
  association [*] to ZC_PURCHASEITEAM as _PurchaseIteam on $projection.PurchaseOrderNumber = _PurchaseIteam.PurchaseOrderNumber
  association [1] to ZC_PO_TYPE       as _OrderType     on $projection.OrderType = _OrderType.PoTyppe
  association [1] to ZC__SUPPLIER     as _suplier       on $projection.Supplier_id = _suplier.Suuplierid
  association [1] to ZC_PO_STATUS     as _status        on $projection.po_status = _status.Postatus

{

      @ObjectModel.text.element: ['Description'] // to add the description with PO Number
  key PurchaseOrderNumber,
      @Search.defaultSearchElement: true // enable default search
      @Search.fuzzinessThreshold: 0.5   // show the in result if 50% match
      @Search.ranking: #HIGH
      Description,
      _PurchaseIteam.PriceUnit as priceUnit,
      PurchaseTotalPrice,
      @ObjectModel.text.element: ['StatusDescription']
      po_status,
      OrderType,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      CompnyCode,
      Organization,
      //      // use to serach help to a difrent entity at parcular field
      //  @Consumption.valueHelpDefinition: [{entity: { name: 'ZC_PO_Status',  element: 'Status' } }]
      _status.Stdescription    as StatusDescription,
      //      // use to f4  serach help to a difrent entity at parcular field
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZC__Supplier' ,element: 'Supplierid'} }]
      @ObjectModel.text.element: ['SuplierName'] // it display suplier name with suplier id
      Supplier_id,
      _suplier.SuplierName     as SuplierName,
      case
          when po_status = '01' then 1
          when po_status = '02' then 2
          when po_status = '03' then 3
          else 0
      end                      as criticalvalue,
      @Semantics.imageUrl: true
      Imageurl,
      CreateBy,
      CreatedDateTime,
      ChangedDateTime,
      LocalLastChangedBy,
      /* Associations */
      _OrderType,
      _PurchaseIteam,
      _suplier,
      _status

}

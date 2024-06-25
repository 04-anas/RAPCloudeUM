@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true // to allow metadata extention
@ObjectModel.semanticKey: ['PurchaseOrderNumber'] // Aperiance would change
@Search.searchable: true // to  enable search help on gui screen

define root view entity ZC_PURCHASEHEADER_TP
  provider contract transactional_query
  as projection on ZI_PurchaseHeader_TP

{

      @ObjectModel.text.element: ['Description'] // to add the description with PO Number
  key PurchaseOrderNumber,
      @Search.defaultSearchElement: true // enable default search
      @Search.fuzzinessThreshold: 0.5   // show the in result if 50% match
      @Search.ranking: #HIGH
      Description,
//      @Semantics.amount.currencyCode: 'priceUnit'
      PurchaseTotalPrice,
//     @UI.hidden: true
//      PriceUnit,
      @Consumption.valueHelpDefinition: [{entity: { name: 'ZC_PO_Status',  element: 'Postatus' } }]
      @ObjectModel.text.element: ['StatusDescription']
      po_status,
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZC_PO_TYPE' ,element: 'PoTyppe'} }]
      OrderType,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      CompnyCode,
      Organization,
      //// use to serach help to a difrent entity at parcular field
      _status.Stdescription as StatusDescription,
      //use to f4  serach help to a difrent entity at parcular field
      @Consumption.valueHelpDefinition: [{entity: {name: 'ZC__SUPPLIER' ,element: 'Suuplierid'} }]
//       @ObjectModel.text.element: ['SuplierName'] // it display suplier name with suplier id
      Supplier_id,
      _suplier.SuplierName  as SuplierName,
      @Semantics.imageUrl: true
      Imageurl,
      @UI.hidden: true
      criticalvalue,
      CreateBy,
      CreatedDateTime,
      ChangedDateTime,
      LocalLastChangedBy,
       last_change_at,
      /* Associations */

      /* Associations */
      _OrderType,
      _PurchaseIteam,
      _PurchaseItem : redirected to composition child ZC_PURCHASE_ITEAM_TP,
      _Po_attachment : redirected to composition child ZC_PO_ATTACHMENT1_TP,
      _suplier
}

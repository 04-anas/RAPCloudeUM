@EndUserText.label: 'projection consumption view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI:{
headerInfo: {
    typeName: 'Attachment',
    typeNamePlural: 'Attachments',

    title:       {type: #STANDARD,value: 'Purchaseordernumber'},
    description: {type: #STANDARD,value: 'Purchaseordernumber'}
},

presentationVariant: [{

    sortOrder: [{by: 'Purchaseordernumber', direction: #ASC }],
    visualizations: [{ type: #AS_LINEITEM }]
}]
}
view entity ZC_PO_ATTACHMENT1_TP
  as projection on ZI_PO_ATTACHMENT1

{

      @UI.facet: [
      {
      id: 'Collectionid',
      type: #COLLECTION, //collection
      label: 'Gernal Information',
      position: 10
       },
        {
      id: 'Invoicedet',
      purpose:#STANDARD,
      parentId: 'Collectionid',
      position: 10 ,
      type: #IDENTIFICATION_REFERENCE ,
      label: 'Purchase Order'
       },
      {
      id: 'Upload',
      purpose:#STANDARD,
      parentId: 'Collectionid',
      position: 20 ,
      type: #FIELDGROUP_REFERENCE ,
      label: 'Uploade Attachment',
      targetQualifier: 'upload'
       }]

      @UI.lineItem: [{ position: 10 ,label: 'Purchase Order Number' }]
      @UI.identification: [{ position: 10 ,label: 'Purchase Order' }]
  key Purchaseordernumber,
      @UI.lineItem: [{ position: 20 ,label: 'Attachment Id' }]
      @UI.identification: [{ position: 20 ,label: 'Attachment Id' }]
  key AttachId,
      @UI.lineItem: [{ position: 30 ,label: 'Attachment ' }]
      @UI.fieldGroup:[{ position: 30 ,label: 'Attachment',qualifier: 'upload' }]
      Attachment,
      @UI.hidden: true
      Mimetype,
      @UI.hidden: true
      Filename,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangeAt,
      /* Associations */
      _PurchaseHeader : redirected to parent ZC_PURCHASEHEADER_TP
}

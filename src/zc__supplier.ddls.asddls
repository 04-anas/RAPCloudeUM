@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'po supllier consumption view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZC__SUPPLIER
  as select from ZI_SUPLLIER_DET
{
      @ObjectModel.text.element: [ 'SuplierName' ]
      key Suuplierid,
      @EndUserText.label: 'Supplier Name'
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold: 0.7
      @Semantics.text: true
      @Semantics.name.fullName: true
      SuplierName,
      @EndUserText.label: 'Email Address'
      @Semantics.eMail.type: [ #WORK ]
      EmailAddress,
      @EndUserText.label: 'Phone Number'
      @Semantics.telephone.type: [ #HOME ]
      PhoneNumbber,
      @EndUserText.label: 'Fax Number'
      @Semantics.telephone.type: [ #FAX]
      FaxNumber,
      @EndUserText.label: 'Web Address'
      WebAddress

}

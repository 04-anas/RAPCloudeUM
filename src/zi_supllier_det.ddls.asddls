@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'suplier interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SUPLLIER_DET
  as select from zsuplier_db
{
  key suuplierid    as Suuplierid,
      suplier_name  as SuplierName,
      email_address as EmailAddress,
      phone_numbber as PhoneNumbber,
      fax_number    as FaxNumber,
      web_address   as WebAddress
}

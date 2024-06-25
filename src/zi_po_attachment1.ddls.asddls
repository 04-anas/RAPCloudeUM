@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'for attachment'
define view entity ZI_PO_ATTACHMENT1 as select from zpo_attachment1
association to parent ZI_PurchaseHeader_TP as _PurchaseHeader 
on $projection.Purchaseordernumber = _PurchaseHeader.PurchaseOrderNumber
{
    key purchaseordernumber as Purchaseordernumber,
    key attach_id as AttachId,
    @Semantics.largeObject: {
        mimeType: 'Mimetype',
        fileName: 'Filename',
        contentDispositionPreference: #INLINE 
        }
    attachment as Attachment,
    @Semantics.mimeType: true
    mimetype as Mimetype,
    filename as Filename,
    last_change_at as LastChangeAt,
    _PurchaseHeader // Make association public
}

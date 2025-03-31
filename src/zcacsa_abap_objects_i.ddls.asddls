//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Custom ABAP Objects'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//define view entity ZCACSA_ABAPOBJECTS_I
//  as select from I_ABAPObjectDirectoryEntry as Object
//
//  association [0..1] to I_UserContactCard as _UserInfo on $projection.ABAPObjectResponsibleUser = _UserInfo.ContactCardID
//{
//  key Object.ABAPObjectCategory,
//  key Object.ABAPObjectType,
//  key Object.ABAPObject,
//      Object.ABAPSourceSystem,
//      Object.ABAPObjectResponsibleUser,
//      Object.ABAPPackage,
//      Object.ABAPObjectGenerationCode,
//      Object.ABAPObjectMasterLanguage,
//      Object.ABAPObjectDeploymentTarget,
//      Object.ABAPObjectIsDeleted,
//      Object.CreationDate,
//      
//      _UserInfo.FullName as CreatedByFullName
//} where ABAPObjectIsDeleted <> 'X'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom ABAP Objects'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCACSA_ABAP_OBJECTS_I
  as select from I_ABAPObjectDirectoryEntry as Object

  association [0..1] to I_UserContactCard as _UserInfo on $projection.ABAPObjectResponsibleUser = _UserInfo.ContactCardID
  association to I_TransportObjectsDescription as _ObjectTypeDescription on $projection.ABAPObjectType = _ObjectTypeDescription.TransportRequestObjectType
                                                                        and $projection.ABAPObjectCategory = _ObjectTypeDescription.TransportRequestObjectPgmID
{
  key Object.ABAPObjectCategory,
  key Object.ABAPObjectType,
  key Object.ABAPObject,
      Object.ABAPSourceSystem,
      Object.ABAPObjectResponsibleUser,
      Object.ABAPPackage,
      Object.ABAPObjectGenerationCode,
      Object.ABAPObjectMasterLanguage,
      Object.ABAPObjectDeploymentTarget,
      Object.ABAPObjectIsDeleted,
      Object.CreationDate,
      
      _UserInfo.FullName as CreatedByFullName,
      _ObjectTypeDescription.TransportRequestObjectTypeDesc as ObjectDescription
} where ABAPObjectIsDeleted <> 'X'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ABAP Object Types'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCACSA_ABAP_OBJECT_TYPES_I
  as select from I_TransportObjectsDescription
{
  key TransportRequestObjectPgmID    as ObjectCategory,
  key TransportRequestObjectType     as ObjectType,
      TransportRequestObjectTypeDesc as ObjectDescription
}

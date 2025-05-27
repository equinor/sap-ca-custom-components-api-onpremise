@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ABAP packages'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCACSA_ABAP_PACKAGES_I
  as select from I_ABAPPackage as Package
  association [1..1] to tdevc                      as PackageAdditionalInfo on  $projection.ABAPPackage = PackageAdditionalInfo.devclass
  association [0..1] to I_ABAPPackageText          as PackageText           on  $projection.ABAPPackage = PackageText.ABAPPackage
                                                                            and PackageText.Language    = $session.system_language
  association [0..*] to ZCACSA_ABAP_OBJECTS_I      as _Objects              on  $projection.ABAPPackage = _Objects.ABAPPackage
  association [0..1] to I_UserContactCard          as _UserContact          on  $projection.CreatedByUser = _UserContact.ContactCardID
  association        to I_ABAPObjectDirectoryEntry as _SystemInfo           on  _SystemInfo.ABAPObjectCategory = 'HEAD'
                                                                            and _SystemInfo.ABAPObjectType     = 'SYST'
{
  key Package.ABAPPackage,
      Package.ABAPPackageResponsibleUser,
      Package.ABAPSoftwareComponent,
      Package.ABAPApplicationComponent,
      Package.ABAPNamespace,
      Package.ABAPPackageTargetEnvironment,
      Package.CreatedByUser,
      Package.CreationDate,
      Package.LastChangedByUser,
      Package.LastChangeDate,
      Package.ABAPLanguageVersion,
      PackageText.ABAPPackageName,
      PackageAdditionalInfo.parentcl                                                                                as ABAPSuperpackage,
      count( distinct concat( _Objects.ABAPObjectCategory, concat( _Objects.ABAPObject, _Objects.ABAPObjectType)) ) as ObjectCount,
      _UserContact.FullName                                                                                         as CreatorFullName,
      _SystemInfo.ABAPSourceSystem                                                                                  as SystemName,

      /*  Associations  */
      _Objects,
      _UserContact

}
where
  ABAPNamespace = '/0CUST/'

group by
  Package.ABAPPackage,
  Package.ABAPPackageResponsibleUser,
  Package.ABAPSoftwareComponent,
  Package.ABAPApplicationComponent,
  Package.ABAPNamespace,
  Package.ABAPPackageTargetEnvironment,
  Package.CreatedByUser,
  Package.CreationDate,
  Package.LastChangedByUser,
  Package.LastChangeDate,
  Package.ABAPLanguageVersion,
  PackageText.ABAPPackageName,
  PackageAdditionalInfo.parentcl,
  _UserContact.FullName,
  _SystemInfo.ABAPSourceSystem

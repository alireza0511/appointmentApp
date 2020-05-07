// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appt-company-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptCompanyStruct _$ApptCompanyStructFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'companyId',
    'companyName',
    'companyLogo',
    'companyBanner',
    'apptBranches',
    'apptCurrentBranch'
  ]);
  return ApptCompanyStruct(
    json['companyId'] as int,
    json['companyName'] as String,
    json['companyWeb'] as String,
    json['companyLogo'] as String,
    json['companyBanner'] as String,
    (json['apptBranches'] as List)
        ?.map((e) => e == null
            ? null
            : ApptBranchStruct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['apptCurrentBranch'] == null
        ? null
        : ApptBranchStruct.fromJson(
            json['apptCurrentBranch'] as Map<String, dynamic>),
    (json['services'] as List)
        ?.map((e) => e == null
            ? null
            : ApptServiceStruct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ApptCompanyStructToJson(ApptCompanyStruct instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'companyWeb': instance.companyWeb,
      'companyLogo': instance.companyLogo,
      'companyBanner': instance.companyBanner,
      'apptBranches': instance.apptBranches?.map((e) => e?.toJson())?.toList(),
      'apptCurrentBranch': instance.apptCurrentBranch?.toJson(),
      'services': instance.services?.map((e) => e?.toJson())?.toList(),
    };

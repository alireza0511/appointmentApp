// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptServiceStruct _$ApptServiceStructFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['serviceId', 'serviceName']);
  return ApptServiceStruct(
    json['serviceId'] as int,
    json['serviceName'] as String,
    json['slotCoefficient'] as int,
  );
}

Map<String, dynamic> _$ApptServiceStructToJson(ApptServiceStruct instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'slotCoefficient': instance.slotCoefficient,
    };

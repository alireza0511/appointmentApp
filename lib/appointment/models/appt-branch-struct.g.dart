// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appt-branch-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptBranchStruct _$ApptBranchStructFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'locationId',
    'locationSlotTime',
    'locationLng',
    'locationLat',
    'locationAddress',
    'userAppointment',
    'employees',
    'dist'
  ]);
  return ApptBranchStruct(
    json['locationId'] as int,
    json['locationOpeningTime'] == null
        ? null
        : DateTime.parse(json['locationOpeningTime'] as String),
    json['locationClosingTime'] == null
        ? null
        : DateTime.parse(json['locationClosingTime'] as String),
    json['locationSlotTime'] as int,
    (json['locationLng'] as num)?.toDouble(),
    (json['locationLat'] as num)?.toDouble(),
    json['locationAddress'] as String,
    json['locationPhone'] as String,
    json['userAppointment'] == null
        ? null
        : AppointmentStruct.fromJson(
            json['userAppointment'] as Map<String, dynamic>),
    (json['employees'] as List)
        ?.map((e) => e == null
            ? null
            : ApptEmployeeStruct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['dist'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ApptBranchStructToJson(ApptBranchStruct instance) =>
    <String, dynamic>{
      'locationId': instance.locationId,
      'locationOpeningTime': instance.locationOpeningTime?.toIso8601String(),
      'locationClosingTime': instance.locationClosingTime?.toIso8601String(),
      'locationSlotTime': instance.locationSlotTime,
      'locationLng': instance.locationLng,
      'locationLat': instance.locationLat,
      'locationAddress': instance.locationAddress,
      'locationPhone': instance.locationPhone,
      'userAppointment': instance.userAppointment?.toJson(),
      'employees': instance.employees?.map((e) => e?.toJson())?.toList(),
      'dist': instance.dist,
    };

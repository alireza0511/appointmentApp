// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentStruct _$AppointmentStructFromJson(Map<String, dynamic> json) {
  return AppointmentStruct(
    json['appointmnetId'] as int,
    json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    json['endTimeExpected'] == null
        ? null
        : DateTime.parse(json['endTimeExpected'] as String),
    json['endTime'] == null ? null : DateTime.parse(json['endTime'] as String),
    json['canceled'] as bool,
    json['cancelationReason'] as String,
    json['dateCreated'] == null
        ? null
        : DateTime.parse(json['dateCreated'] as String),
    json['verifiedByEmployee'] as bool,
    json['service'] == null
        ? null
        : ApptServiceStruct.fromJson(json['service'] as Map<String, dynamic>),
    json['client'] == null
        ? null
        : ApptClientStruct.fromJson(json['client'] as Map<String, dynamic>),
    json['hasAppt'] as bool,
  );
}

Map<String, dynamic> _$AppointmentStructToJson(AppointmentStruct instance) =>
    <String, dynamic>{
      'appointmnetId': instance.appointmnetId,
      'startTime': instance.startTime?.toIso8601String(),
      'endTimeExpected': instance.endTimeExpected?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'canceled': instance.canceled,
      'cancelationReason': instance.cancelationReason,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'verifiedByEmployee': instance.verifiedByEmployee,
      'service': instance.service?.toJson(),
      'client': instance.client?.toJson(),
      'hasAppt': instance.hasAppt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptEmployeeStruct _$ApptEmployeeStructFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'employeeId',
    'firstName',
    'phoneNumber',
    'email',
    'companyId',
    'employeeStartTime',
    'employeeEndTime',
    'employeeAvlWeekDays',
    'timeSlot',
    'services'
  ]);
  return ApptEmployeeStruct(
    json['employeeId'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['phoneNumber'] as String,
    json['profileImg'] as String,
    json['employeeStartTime'] == null
        ? null
        : DateTime.parse(json['employeeStartTime'] as String),
    json['employeeEndTime'] == null
        ? null
        : DateTime.parse(json['employeeEndTime'] as String),
    (json['employeeAvlWeekDays'] as List)?.map((e) => e as bool)?.toList(),
    (json['appointments'] as List)
        ?.map((e) => e == null
            ? null
            : AppointmentStruct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..email = json['email'] as String
    ..companyId = json['companyId'] as int
    ..branchId = json['locationId'] as int
    ..timeSlot = (json['timeSlot'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList()
    ..services = (json['services'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$ApptEmployeeStructToJson(ApptEmployeeStruct instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'companyId': instance.companyId,
      'locationId': instance.branchId,
      'profileImg': instance.profileImg,
      'employeeStartTime': instance.employeeStartTime?.toIso8601String(),
      'employeeEndTime': instance.employeeEndTime?.toIso8601String(),
      'employeeAvlWeekDays': instance.employeeAvlWeekDays,
      'timeSlot': instance.timeSlot?.map((e) => e?.toIso8601String())?.toList(),
      'appointments': instance.appointments?.map((e) => e?.toJson())?.toList(),
      'services': instance.services,
    };

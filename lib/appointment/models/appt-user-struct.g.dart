// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appt-user-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptUserStruct _$ApptUserStructFromJson(Map<String, dynamic> json) {
  return ApptUserStruct(
    json['token'] as String,
    json['expiresIn'] as int,
    json['client'] == null
        ? null
        : ApptClientStruct.fromJson(json['client'] as Map<String, dynamic>),
        DateTime.now().add(Duration(seconds: json['expiresIn'])),
  );
}

Map<String, dynamic> _$ApptUserStructToJson(ApptUserStruct instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiresIn': instance.expiresIn,
      'client': instance.client,
    };

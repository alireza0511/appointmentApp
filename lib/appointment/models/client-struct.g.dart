// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client-struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApptClientStruct _$ApptClientStructFromJson(Map<String, dynamic> json) {
  return ApptClientStruct(
    json['clientId'] as int,
    json['userId'] as int,
    json['clientName'] as String,
    json['contactMobile'] as String,
    json['contactMail'] as String,
  );
}

Map<String, dynamic> _$ApptClientStructToJson(ApptClientStruct instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'userId': instance.userId,
      'clientName': instance.clientName,
      'contactMobile': instance.contactMobile,
      'contactMail': instance.contactMail,
    };

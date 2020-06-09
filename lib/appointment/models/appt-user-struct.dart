

import 'package:appointment_app/appointment/models/client-struct.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appt-user-struct.g.dart';


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class ApptUserStruct {
  ApptUserStruct(this.token, this.expiresIn, this.client, this.expiryDate);

  String token;
  int expiresIn;
  ApptClientStruct client;
  DateTime expiryDate;
  

  factory ApptUserStruct.fromJson(Map<String, dynamic> json) => _$ApptUserStructFromJson(json);

  Map<String, dynamic> toJson() => _$ApptUserStructToJson(this);
}
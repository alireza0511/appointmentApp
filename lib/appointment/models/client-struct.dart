

import 'package:json_annotation/json_annotation.dart';


part 'client-struct.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class ApptClientStruct {
  ApptClientStruct(this.clientId, this.userId, this.clientName, this.contactMobile,this.contactMail,
  );

  int clientId;
  int userId;
  String clientName;
  String contactMobile;
  String contactMail;
  

  factory ApptClientStruct.fromJson(Map<String, dynamic> json) => _$ApptClientStructFromJson(json);

  Map<String, dynamic> toJson() => _$ApptClientStructToJson(this);
}
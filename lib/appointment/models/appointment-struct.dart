
import '../../appointment/models/client-struct.dart';
import '../../appointment/models/service-struct.dart';
import 'package:json_annotation/json_annotation.dart';


part 'appointment-struct.g.dart';


@JsonSerializable(explicitToJson: true)

class AppointmentStruct {
  AppointmentStruct(this.appointmnetId, this.startTime,this.endTimeExpected, this.endTime,this.canceled, this.cancelationReason,
  this.dateCreated, this.verifiedByEmployee, this.service,this.client,this.hasAppt);
  
  int appointmnetId;
  DateTime startTime;
  DateTime endTimeExpected;
  DateTime endTime;
  bool canceled;
  String cancelationReason;
  DateTime dateCreated;
  bool verifiedByEmployee;
  ApptServiceStruct service;
  ApptClientStruct client;
  bool hasAppt;
  
  factory AppointmentStruct.fromJson(Map<String, dynamic> json) => _$AppointmentStructFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentStructToJson(this);
}
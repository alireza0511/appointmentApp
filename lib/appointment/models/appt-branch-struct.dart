

import '../../appointment/models/appointment-struct.dart';
import '../../appointment/models/employee-struct.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `servicestruct` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'appt-branch-struct.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class ApptBranchStruct {
  ApptBranchStruct(this.locationId, this.locationOpeningTime, this.locationClosingTime, this.locationSlotTime,
  this.locationLng , this.locationLat ,this.locationAddress , this.locationPhone ,this.userAppointment , this.employees ,
  this.dist);
  @JsonKey(required: true)
  int locationId;
  DateTime locationOpeningTime;
  DateTime locationClosingTime;
  @JsonKey(required: true)
  int locationSlotTime;
  @JsonKey(required: true)
  double locationLng;
  @JsonKey(required: true)
  double locationLat;
  @JsonKey(required: true)
  String locationAddress;
  String locationPhone;
  @JsonKey(required: true)
  AppointmentStruct userAppointment;
  @JsonKey(required: true)
  List<ApptEmployeeStruct> employees;
  @JsonKey(required: true)
  double dist;

  factory ApptBranchStruct.fromJson(Map<String, dynamic> json) => _$ApptBranchStructFromJson(json);

  Map<String, dynamic> toJson() => _$ApptBranchStructToJson(this);
}
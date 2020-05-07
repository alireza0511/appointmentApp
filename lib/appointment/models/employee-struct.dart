import '../../appointment/models/appointment-struct.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `servicestruct` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'employee-struct.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)

class ApptEmployeeStruct {
  ApptEmployeeStruct(this.employeeId, this.firstName, this.lastName, this.phoneNumber,this.profileImg,
  this.employeeStartTime,this.employeeEndTime,this.employeeAvlWeekDays, //this.timeSlot,
  this.appointments);
@JsonKey(required: true)
  int employeeId;
  @JsonKey(required: true)
  String firstName;
  String lastName;
  @JsonKey(required: true)
  String phoneNumber;
  @JsonKey(required: true)
  String email;
  @JsonKey(required: true)
  int companyId;

  @JsonKey(name: 'locationId')
  int branchId;

  String profileImg;
  @JsonKey(required: true)
  DateTime employeeStartTime;
  @JsonKey(required: true)
  DateTime employeeEndTime;
  @JsonKey(required: true)
  List<bool> employeeAvlWeekDays;
  @JsonKey(required: true)
  List<DateTime> timeSlot;
  List<AppointmentStruct> appointments;
  @JsonKey(required: true)
  List<int> services;

  factory ApptEmployeeStruct.fromJson(Map<String, dynamic> json) => _$ApptEmployeeStructFromJson(json);

  Map<String, dynamic> toJson() => _$ApptEmployeeStructToJson(this);
}
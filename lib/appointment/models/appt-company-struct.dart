import '../../appointment/models/appt-branch-struct.dart';
import '../../appointment/models/service-struct.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appt-company-struct.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class ApptCompanyStruct {
  ApptCompanyStruct(
    this.companyId,
    this.companyName,
    this.companyWeb,
    this.companyLogo,
    this.companyBanner,
    this.apptBranches,
    this.apptCurrentBranch,
    this.services
  );
  @JsonKey(required: true)
  int companyId;
  @JsonKey(required: true)
  String companyName;
  String companyWeb;
  @JsonKey(required: true)
  String companyLogo;
  @JsonKey(required: true)
  String companyBanner;
  @JsonKey(required: true)
  List<ApptBranchStruct> apptBranches;
  @JsonKey(required: true)
  ApptBranchStruct apptCurrentBranch;
  
  List<ApptServiceStruct> services;

  factory ApptCompanyStruct.fromJson(Map<String, dynamic> json) =>
      _$ApptCompanyStructFromJson(json);

  Map<String, dynamic> toJson() => _$ApptCompanyStructToJson(this);
}

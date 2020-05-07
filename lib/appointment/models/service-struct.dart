

import '../../appointment/models/employee-struct.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `servicestruct` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'service-struct.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
/// explicitToJson property bool explicitToJson If true, generated toJson methods will explicitly call toJson on nested objects.
/// When using JSON encoding support in dart:convert, toJson is automatically called on objects, so the default behavior (explicitToJson: false) is to omit the toJson call.
@JsonSerializable(explicitToJson: true)

class ApptServiceStruct {
  ApptServiceStruct(this.serviceId, this.serviceName, this.slotCoefficient);
  @JsonKey(required: true)
  int serviceId;

  @JsonKey(required: true)
  String serviceName;

  int slotCoefficient;

  

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ApptServiceStructFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ApptServiceStruct.fromJson(Map<String, dynamic> json) => _$ApptServiceStructFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ApptServiceStructToJson`.
  Map<String, dynamic> toJson() => _$ApptServiceStructToJson(this);
}
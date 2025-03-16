
import 'package:json_annotation/json_annotation.dart';

import '../../utils/string.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel{

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String employeeName;

  @JsonKey(name: "designation")
  String designation;

  @JsonKey(name: "cell_no")
  String? cellNo;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "address")
  String? presentAddress;

  @JsonKey(name: "nid")
  String? nid;

  @JsonKey(name: "type_id")
  int typeId;

  @JsonKey(name: "employee_id")
  String employeeId;

  @JsonKey(name: "supervisor_id")
  int supervisorId;

  @JsonKey(name: "status_id")
  int statusId;

  @JsonKey(name: "joining_date")
  DateTime joiningDate;

  @JsonKey(name: "permanent_date")
  DateTime? permanentDate;

  String getIsActiveAsString() {
    return statusId == 1 ? Strings.yes : Strings.no;
  }

  EmployeeModel(
      this.id,
      this.employeeName,
      this.designation,
      this.cellNo,
      this.email,
      this.presentAddress,
      this.nid,
      this.typeId,
      this.employeeId,
      this.supervisorId,
      this.statusId,
      this.joiningDate,
      this.permanentDate);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
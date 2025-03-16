import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_model.g.dart';

@JsonSerializable()
class AttendanceModel {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "employee_id")
  int? employeeId;

  @JsonKey(name: "employee_name")
  String? employeeName;

  @JsonKey(name: "date_time")
  String?
      dateTimeUnformated; //This data is not well format, so it is only use for data receive from API. Using of it may occur error
  DateTime? getDateTime() {
    if (dateTimeUnformated == null) {
      return null;
    } else {
      return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateTimeUnformated!);
    }
  }

  String? getDateTimeAsString() {
    if (dateTimeUnformated == null) {
      return null;
    } else {
      return DateFormat("dd/MM/yyyy").format(getDateTime()!);
    }
  }

  @JsonKey(name: "check_in")
  String?
      checkInUnformated; //This data is not well format, so it is only use for data receive from API. Using of it may occur error
  DateTime? getCheckIn() {
    if (checkInUnformated == null) {
      return null;
    } else {
      return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(checkInUnformated!);
    }
  }

  String? getCheckInAsString() {
    if (checkInUnformated == null) {
      return "";
    } else {
      return DateFormat("hh:mm a").format(getCheckIn()!);
    }
  }

  @JsonKey(name: "check_out")
  String?
      checkOutUnformated; //This data is not well format, so it is only use for data receive from API. Using of it may occur error
  DateTime? getCheckOut() {
    if (checkOutUnformated == null) {
      return null;
    } else {
      return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(checkOutUnformated!);
    }
  }

  String? getCheckOutAsString() {
    if (checkOutUnformated == null) {
      return "";
    } else {
      return DateFormat("hh:mm a").format(getCheckOut()!);
    }
  }

  @JsonKey(name: "late_duration")
  int? lateDuration;

  @JsonKey(name: "latitude")
  double? checkInLatitude;

  @JsonKey(name: "longitude")
  double? checkInLongitude;

  @JsonKey(name: "overtimE_MINUTES")
  int overtimeMinutes;

  @JsonKey(name: "check_out_latitude")
  double? checkOutLatitude;

  @JsonKey(name: "check_out_longitude")
  double? checkOutLongitude;

  @JsonKey(name: "check_in_address")
  String? checkInAddress;

  @JsonKey(name: "check_out_address")
  String? checkOutAddress;

  @JsonKey(name: "status")
  String status;

  @JsonKey(name: "missinG_REASON")
  String? missingReason;

  @JsonKey(name: "approval_status_id")
  int? approvalStatusId;

  @JsonKey(name: "approval_status")
  String? approvalStatus;

  AttendanceModel(
      {required this.dateTimeUnformated,
      this.id = 0,
      this.overtimeMinutes = 0,
      this.status = "",
      this.employeeId,
      this.employeeName,
      this.checkInUnformated,
      this.checkOutUnformated,
      this.lateDuration,
      this.checkInLatitude,
      this.checkInLongitude,
      this.checkOutLatitude,
      this.checkOutLongitude,
      this.checkInAddress,
      this.checkOutAddress,
      this.missingReason,
      this.approvalStatusId,
      this.approvalStatus});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}



import 'package:flutter/foundation.dart';
import 'package:i_employment/models/attendance/user_attendance_summary_model.dart';
import 'package:i_employment/models/leave/leave_summary_model.dart';
import 'package:i_employment/repo/api_status.dart';
import 'package:i_employment/repo/attendance_services.dart';
import 'package:i_employment/repo/leave_services.dart';
import 'package:i_employment/repo/location_service.dart';
import 'package:i_employment/utils/global_fields.dart';
import 'package:i_employment/view_models/base_view_model.dart';
import 'package:intl/intl.dart';
import '../models/attendance/attendance_model.dart';
import '../utils/shared_preference.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel() {
    _loadQuickAccess();
  }

  Future<void> pullRefresh() async {
    await Future.delayed(Duration.zero, () async {
      getUserAttendanceSummary();
      getUserHomeAttendance();
      await getEmployeeLeaveSummary();
    }).then((value) {
      notifyListeners();
    });
  }

  // quick access section
  List<String> quickAccessTitleList = [];
  List<String> quickAccessIconList = [];
  bool _isQuickAccessLoaded = false;
  bool get isQuickAccessLoaded => _isQuickAccessLoaded;
  setQuickAccessLoadingStatus(bool status) {
    _isQuickAccessLoaded = status;
    notifyListeners();
  }

  updateListIndex() async {
    SessionManager.setQuickAccessTitleList(quickAccessTitleList);
    SessionManager.setQuickAccessIconList(quickAccessIconList);
  }

  _loadQuickAccess() async {
    var listTitle = await SessionManager.getQuickAccessTitleList();
    var listIcon = await SessionManager.getQuickAccessIconList();
    if (listTitle != null && listIcon != null) {
      quickAccessTitleList.addAll(listTitle);
      quickAccessIconList.addAll(listIcon);
      setQuickAccessLoadingStatus(true);
    } else {
      quickAccessTitleList.add("Attendance");
      quickAccessTitleList.add("Overtimes");
      quickAccessTitleList.add("Leaves");
      quickAccessTitleList.add("Pay-slip");

      quickAccessIconList.add("attendance");
      quickAccessIconList.add("overtime");
      quickAccessIconList.add("leave");
      quickAccessIconList.add("pay_slip");
      setQuickAccessLoadingStatus(true);
      updateListIndex();
    }
  }

  // User home attendance
  List<AttendanceModel> _attendanceList = [];
  List<AttendanceModel> get attendanceList => _attendanceList;
  _setAttendanceModelList(List<AttendanceModel> list) {
    _attendanceList.clear();
    _attendanceList = list;
    notifyListeners();
  }

  Future getUserHomeAttendance() async {
    setErrorMsg("");
    setLoading(true);
    var endDate = DateTime.now();
    var startDate = endDate.add(const Duration(days: -2));
    var res = await AttendanceService.getUserAttendance(startDate, endDate);
    if (res is Success) {
      var data = res.response as List<AttendanceModel>;
      _setAttendanceModelList(data);
      setLoading(false);
    } else if (res is Failed) {
      setErrorMsg(res.failedReason.toString());
      setLoading(false);
    }
  }

// User Attendance Summary
  UserAttendanceSummaryModel? _userAttendanceSummaryModel;
  UserAttendanceSummaryModel? get userAttendanceSummaryModel =>
      _userAttendanceSummaryModel;
  _setUserAttendanceSummaryModel(UserAttendanceSummaryModel model) {
    _userAttendanceSummaryModel = model;
    notifyListeners();
  }

  Future getUserAttendanceSummary() async {
    setErrorMsg("");
    setLoading(true);
    var endDate = DateTime.now();
    var startDate = DateTime(endDate.year, endDate.month, 1);
    var res =
        await AttendanceService.getUserAttendanceSummary(startDate, endDate);
    if (res is Success) {
      var data = res.response as UserAttendanceSummaryModel;
      _setUserAttendanceSummaryModel(data);
      setLoading(false);
    } else if (res is Failed) {
      setErrorMsg(res.failedReason.toString());
      setLoading(false);
    }
  }

  // User Leave Summary
  List<LeaveSummaryModel> _leaveSummaryList = [];
  List<LeaveSummaryModel> get leaveSummaryList => _leaveSummaryList;
  _setLeaveSummaryModelList(List<LeaveSummaryModel> list) {
    _leaveSummaryList = list;
    notifyListeners();
  }

  Future getEmployeeLeaveSummary() async {
    setErrorMsg("");
    setLoading(true);

    var res = await LeaveService.getEmployeeLeaveSummary();
    if (res is Success) {
      var data = res.response as List<LeaveSummaryModel>;
      _setLeaveSummaryModelList(data);
      setLoading(false);
    } else if (res is Failed) {
      setErrorMsg(res.failedReason.toString());
      setLoading(false);
    }
  }

  Future<String?> getGSMAddress() async {
    setErrorMsg("");
    setLoading(true);
    try{
      var position;
      var address = "Address not found";
      if(!kIsWeb){
        position = await LocationService().getGeoLocationPosition();
        address = await  LocationService().GetAddressFromLatLong(position);
      }
      setLoading(false);
      return address;
    }catch(e){
      setErrorMsg(e.toString());
      setLoading(false);
      return null;
    }
  }

  Future checkIn() async {
    setErrorMsg("");
    setLoading(true);
    try{
      var position;
      var address = "Address not found";
      if(!kIsWeb){
        position = await LocationService().getGeoLocationPosition();
        address = await  LocationService().GetAddressFromLatLong(position);
      }
      AttendanceModel attendanceModel = AttendanceModel(
          dateTimeUnformated: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          employeeId: FieldValue.userId,
          checkInLatitude: kIsWeb ? null : position.latitude,
          checkInLongitude: kIsWeb ? null : position.longitude,
          checkInAddress: address);
      var res = await AttendanceService.checkIn(attendanceModel);
      if (res is Success) {
        setLoading(false);
      } else if (res is Failed) {
        Failed result = res as Failed;
        setErrorMsg(result.failedReason.toString());
        setLoading(false);
      }
    }catch(e){
      setErrorMsg(e.toString());
      setLoading(false);
    }
  }

  Future checkOut() async {
    setErrorMsg("");
    setLoading(true);

    try{
      var position;
      var address = "Address not found";
      if(!kIsWeb){
        position = await LocationService().getGeoLocationPosition();
        address = await  LocationService().GetAddressFromLatLong(position);
      }
      AttendanceModel attendanceModel = AttendanceModel(
          dateTimeUnformated: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          employeeId: FieldValue.userId,
          checkOutLatitude: kIsWeb ? null : position.latitude,
          checkOutLongitude: kIsWeb ? null : position.longitude,
          checkOutAddress: address);
      var res = await AttendanceService.checkOut(attendanceModel);
      if (res is Success) {
        setLoading(false);
      } else if (res is Failed) {
        Failed result = res as Failed;
        setErrorMsg(result.failedReason.toString());
        setLoading(false);
      }
    }catch(e){
      setErrorMsg(e.toString());
      setLoading(false);
    }

  }
}

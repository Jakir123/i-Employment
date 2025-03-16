class Messages{
  Messages._();
  static const progressCheckAuth = "Checking Authentication...";
  static const progressInProgress = "In Progress...";

  static const errorNoRecordFound = "No record found";
  static const errorLeaveTypeEmpty = "Please select a leave type";
  static const errorDurationMin = "Duration minimum 1 hour";
  static const errorDurationMax = "Duration maximum 22 hours";
  static const errorDurationLeaveDayMin = "Duration minimum 1 day";
  static const errorDurationLeaveDayMax = "Duration maximum 10 days";
  static const errorDurationLeaveDayBalance = "Duration cross the leave balance";
  static const errorOvertimeDeleteExist = "Failed to delete overtime because of already approved";
  static const errorOvertimeModifyExist = "Failed to modify overtime because of already approved";
  static const errorLeaveDeleteExist = "Failed to delete leave because of already approved";
  static const errorLeaveModifyExist = "Failed to modify leave because of already approved";
  static const errorReasonEmpty = "Reason can not be empty";
  static const errorReasonMaxLength = "Reason required maximum 300 characters";
  static const errorUserNameEmpty = "Please enter user email";
  static const errorPasswordEmpty = "Please enter password";
  static const errorPasswordDigit = "Password required minimum 6 characters";
  static const errorCellNoEmpty = "Cell No. can not be empty";
  static const errorCellNoDigit = "Cell No. must be 11 digit(01XXXXXXXXX)";
  static const errorNameEmpty = "Name can not be empty";
  static const errorOldPasswordEmpty = "Please enter old password";
  static const errorNewPasswordEmpty = "Please enter new password";
  static const errorConfirmPasswordMatch = "Confirm password is not matched with new password";
  static const errorNewPasswordDigit = "New password required minimum 6 characters";

  static const successRequestSent = "Request has been sent successfully";
  static const successRequestDelete = "Request has been deleted successfully";
  static const successOvertimeDelete = "Overtime has been deleted successfully";
  static const successSettingsUpdate = "Settings are updated successfully";
  static const successForgetPasswordRequest = "Your password reset request has been sent to administrator. After changed you will get another email/notification from system.";

  static const warningEndOfMonthPopup = "Please update your Attendance / Overtime / Leave as soon as possible. Otherwise it may affected on your salary...";
  static const warningNotificationCheckIn = "You didn't check in yet...";
  static const warningNotificationCheckOut = "You didn't check out yet...";
  static const warningCheckInAddress = "You are trying to check in from";
  static const warningCheckOutAddress = "You are trying to check out from";
  static const warningDoContinue = "Do you want to continue";
  static const warningLocationNotFound = "Location not found";
  static const warningCheckOutOvertime = "You have seem to done some extra effort today";
  static const warningDoAddOvertime = "Do you want to add overtime";

  static const infoPaySlip = "You can see the current month pay-slip after salary disbursement";
  static const infoLongTapTooltip = "'LONG TAP' to view tooltip of table cell value";

}
import 'package:flutter/material.dart';
import 'package:i_employment/models/overtime/overtime_model.dart';
import 'package:i_employment/utils/common_functions.dart';
import 'package:i_employment/utils/shared_preference.dart';
import 'package:i_employment/utils/string.dart';

import '../components/button_widget.dart';
import '../components/textview_widget.dart';
import '../components/toast_widget.dart';
import '../view_models/home_view_model.dart';
import '../views/home/home_screen.dart';
import '../views/overtime/add_overtime_page.dart';
import 'colors.dart';
import 'message.dart';
import 'navigation_utils.dart';

class Popup{

  static Future<void> showCheckInPopup(BuildContext context, HomeViewModel viewModel) async{
    String? address  = await viewModel.getGSMAddress();
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        builder: (BuildContext buildContext) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.orange,
                        size: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/2 - 200,
                        child: ListView(
                          children: [
                            TitleTextView("${Messages.warningCheckInAddress}:"
                              , textSize: 16, textAlign: TextAlign.center,),
                            TitleTextView("${address ?? Messages.warningLocationNotFound}"
                              , textSize: 12, textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            TitleTextView("${Messages.warningDoContinue}?"
                              , textSize: 20, textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

                                  ),
                                  child: TitleTextView(Strings.btnTextNo,textSize: 18,),
                                ),
                                SizedBox(width: 10,),
                                OutlinedButton(
                                  onPressed: ()async{
                                    Navigator.of(context).pop();
                                    await viewModel.checkIn();
                                    if (viewModel.errorMsg.isNotEmpty) {
                                      CustomToast.showErrorToast(viewModel.errorMsg);
                                    } else {
                                      openNewUI(context, HomeScreen());
                                      //CustomToast.showSuccessToast("CHECK IN is done successfully");
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                                      backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryLightColor)
                                  ),
                                  child: TitleTextView(Strings.btnTextYes,textSize: 18,textColor: Colors.white),
                                ),
                              ]
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        });
  }

  static Future<void> showCheckOutPopup(BuildContext context, HomeViewModel viewModel) async{
    String? address  = await viewModel.getGSMAddress();
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        builder: (BuildContext buildContext) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.orange,
                        size: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/2 - 200,
                        child: ListView(
                          children: [
                            TitleTextView("${Messages.warningCheckOutAddress}:"
                              , textSize: 16, textAlign: TextAlign.center,),
                            TitleTextView("${address ?? Messages.warningLocationNotFound}"
                              , textSize: 12, textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            TitleTextView("${Messages.warningDoContinue}?"
                              , textSize: 20, textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

                                  ),
                                  child: TitleTextView(Strings.btnTextNo,textSize: 18,),
                                ),
                                SizedBox(width: 10,),
                                OutlinedButton(
                                  onPressed: ()async{
                                    Navigator.of(context).pop();
                                    await viewModel.checkOut();
                                    if (viewModel.errorMsg.isNotEmpty) {
                                      CustomToast.showErrorToast(viewModel.errorMsg);
                                    } else {
                                      var allow = await SessionManager.getAlertForMissingOvertime();
                                      if (!allow) {
                                        openNewUI(context, HomeScreen());
                                      }else {
                                        var attendance = viewModel.attendanceList
                                            .first;
                                        showOvertimePopup(context, viewModel,
                                            CommonFunctions.getNewOvertime(
                                                attendance));
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                                      backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryLightColor)
                                  ),
                                  child: TitleTextView(Strings.btnTextYes,textSize: 18,textColor: Colors.white),
                                ),
                              ]
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        });
  }

  static Future<void> showOvertimePopup(BuildContext context, HomeViewModel viewModel, OvertimeModel overtimeModel) async{
    var attendance = viewModel.attendanceList.first;
    var checkInTime = attendance.getCheckIn();
    if(DateTime.now().difference(checkInTime??DateTime.now()).inHours<10) {
      openNewUI(context, HomeScreen());
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        builder: (BuildContext buildContext) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.orange,
                        size: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/2 - 200,
                        child: ListView(
                          children: [
                            TitleTextView("${Messages.warningCheckOutOvertime}:"
                              , textSize: 16, textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            TitleTextView("${Messages.warningDoAddOvertime}?"
                              , textSize: 20, textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: (){
                                    //Navigator.of(context).pop();
                                    openNewUI(context, HomeScreen());
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

                                  ),
                                  child: TitleTextView(Strings.btnTextNo,textSize: 18,),
                                ),
                                SizedBox(width: 10,),
                                OutlinedButton(
                                  onPressed: ()async{
                                    Navigator.of(context).pop();

                                    openNewUI(context, AddOvertimePage(overtimeModel: overtimeModel));
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                                      backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryLightColor)
                                  ),
                                  child: TitleTextView(Strings.btnTextYes,textSize: 18,textColor: Colors.white),
                                ),
                              ]
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        });
  }
}
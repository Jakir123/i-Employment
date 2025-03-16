import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_employment/components/app_bar_widget.dart';
import 'package:i_employment/components/error_popup_widget.dart';
import 'package:i_employment/components/loading_dialog_widget.dart';
import 'package:i_employment/components/toast_widget.dart';
import 'package:i_employment/models/employee/employee_contact_info_model.dart';
import 'package:i_employment/views/employee/profile_page.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_control.dart';
import '../../components/loading_widget.dart';
import '../../models/employee/employee_model.dart';
import '../../models/toolbar_item_model.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/message.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/string.dart';
import '../../view_models/employee_view_model.dart';
import '../menu_page.dart';

class EmployeeEditPage extends StatefulWidget {
  final EmployeeModel employeeModel;
  final EmployeeContactInfoModel? contactInfoModel;
  const EmployeeEditPage(
      {Key? key, required this.employeeModel, this.contactInfoModel})
      : super(key: key);

  @override
  State<EmployeeEditPage> createState() =>
      _EmployeeEditPageState(this.employeeModel, this.contactInfoModel);
}

class _EmployeeEditPageState extends State<EmployeeEditPage> {
  EmployeeModel employeeModel;
  EmployeeContactInfoModel? contactInfoModel;
  _EmployeeEditPageState(this.employeeModel, this.contactInfoModel);

  @override
  void initState() {
    super.initState();
    if (contactInfoModel == null) {
      contactInfoModel = EmployeeContactInfoModel(employeeModel.id, null, null,
          null, null, null, null, null, null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<EmployeeViewModel>();

    ToolBarItemModel item =
    ToolBarItemModel(1, const Icon(Icons.check_outlined), null, () async {
      var result = await viewModel.updateProfile(
          employeeModel, contactInfoModel);
       if (result) {
         openNewUI(context, ProfilePage());
       }
    });

    var mediaSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBar(title: Strings.titleEmployeeEditPage, list: [item], withMenu: false,),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Row(
                children: [
                  mediaSize.width > webWidth
                      ? Flexible(flex: 1, child: MenuPage())
                      : Container(),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _fieldWidget(Strings.textEmployeeId, employeeModel.employeeId,
                                true, null),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(Strings.textEmployeeName,
                                employeeModel.employeeName, false, (value) {
                              employeeModel.employeeName = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textDesignation, employeeModel.designation, true,
                                null),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textCellNo, employeeModel.cellNo ?? "", false,
                                (value) {
                              employeeModel.cellNo = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textSecondCellNo,
                                contactInfoModel != null
                                    ? (contactInfoModel!.secondCellNo ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.secondCellNo = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textEmail, employeeModel.email, true, null),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textPersonalEmail,
                                contactInfoModel != null
                                    ? (contactInfoModel!.personalEmail ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.personalEmail = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(Strings.textNID, employeeModel.nid ?? "", false,
                                (value) {
                              employeeModel.nid = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidgetMultiLine(Strings.textPresentAddress,
                                employeeModel.presentAddress ?? "", false, (value) {
                              employeeModel.presentAddress = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidgetMultiLine(
                                Strings.textPermanentAddress,
                                contactInfoModel != null
                                    ? (contactInfoModel!.permanentAddress ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.permanentAddress = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textFatherName,
                                contactInfoModel != null
                                    ? (contactInfoModel!.fatherName ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.fatherName = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textFatherCellNo,
                                contactInfoModel != null
                                    ? (contactInfoModel!.fatherCellNo ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.fatherCellNo = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textMotherName,
                                contactInfoModel != null
                                    ? (contactInfoModel!.motherName ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.motherName = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textMotherCellNo,
                                contactInfoModel != null
                                    ? (contactInfoModel!.motherCellNo ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.motherCellNo = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textSecondaryContactName,
                                contactInfoModel != null
                                    ? (contactInfoModel!.secondaryContactName ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.secondaryContactName = value;
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            _fieldWidget(
                                Strings.textSecondaryContactCellNo,
                                contactInfoModel != null
                                    ? (contactInfoModel!.secondaryContactCell ?? "")
                                    : "",
                                false, (value) {
                              contactInfoModel!.secondaryContactCell = value;
                            }),
                            mediaSize.width > webWidth
                                ? ListTile(
                              title: ElevatedButton(
                                onPressed: () async {
                                  var result = await viewModel.updateProfile(
                                      employeeModel, contactInfoModel);
                                  if (result) {
                                    openNewUI(context, ProfilePage());
                                  }
                                },
                                child: Text(
                                  Strings.btnTextUpdate,
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateColor
                                        .resolveWith((states) =>
                                    kPrimaryLightColor)),
                              ),
                            )
                                : Container(),
                            mediaSize.width > webWidth ? const SizedBox(
                              height: 20,
                            ) : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (viewModel.loading)
              LoadingPage(
                msg: Messages.progressInProgress,
              ),
            if (viewModel.errorMsg.isNotEmpty)
              ErrorPopupPage(
                msg: viewModel.errorMsg,
                onOkPressed: () {
                  viewModel.setErrorMsg("");
                },
              )
          ],
        ));
  }

  _fieldWidget(
      String label, String value, bool readOnly, Function(String)? onChanged) {
    return CustomTextControl(
      labelText: label,
      defaultValue: value,
      readOnly: readOnly,
      leftFlex: 30,
      rightFlex: 70,
      onChanged: onChanged,
    );
  }

  _fieldWidgetMultiLine(
      String label, String value, bool readOnly, Function(String)? onChanged) {
    return CustomTextControl(
      labelText: label,
      defaultValue: value,
      readOnly: readOnly,
      minLines: 2,
      maxLines: 3,
      leftFlex: 30,
      rightFlex: 70,
      onChanged: onChanged,
    );
  }
}

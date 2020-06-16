//
//  schedule-view.dart
//  JazzB
//
//  Created by Alireza Khakpour on 04/04/20.
//  Copyright © 2020 JazzB. All rights reserved.
//
// dart
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:core';
// package

import 'package:appointment_app/appointment/models/appointment-struct.dart';
import 'package:appointment_app/appointment/models/helper/http-exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'widget/set-appt-widget.dart';

// internal
import '../../appointment/models/appt-branch-struct.dart';
import '../../appointment/models/appt-company-struct.dart';
import '../../appointment/models/employee-struct.dart';
import '../../appointment/models/service-struct.dart';
import '../../appointment/providers/appt-provier.dart';
import '../../appointment/views/widget/ui-constants.dart';
import '../../appointment/views/widget/error-dialog.dart';

enum PickerViewType { Branch, Services }

class ScheduleView extends StatefulWidget {
  const ScheduleView({Key key}) : super(key: key);

  static const routeName = '/schedule-view';

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  ApptCompanyStruct _companyInfo;
  String _appBarTitle = 'Schedule an appointment';
  String _appBarimage = '';
  var _isInit = true;
  var _isLoading = false;
  DateTime _selectedApptDate;
  String _selectedApptDateString = 'Select a Date';
  ApptBranchStruct _selectedBranch;
  ApptServiceStruct _selectedService;
  int _selectedWeekday = DateTime.now().weekday;
  bool _userHasAppt = false;
  ApptEmployeeStruct _selectedEmployee;
  TextEditingController txtFldController_services = TextEditingController();
  TextEditingController txtFldController_branch = TextEditingController();


  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      _fetchCompany();
      print('object');

      setState(() {
        var today = DateTime.now();
        var formatter = new DateFormat.yMd().add_EEEE();

        _selectedApptDate = today;
        _selectedWeekday = today.weekday;
        _selectedApptDateString = formatter.format(_selectedApptDate);
      });
    }
    _isInit = false;

    // _updateLocation();

    super.didChangeDependencies();
  }

  void _fetchCompany() async {
    try {
      var response = await Provider.of<ApptProvider>(context,listen: false)
          .fetchApptCompany(29.2344, -95.3434, 100, 1000);
      setState(() {
        _isLoading = false;
        _companyInfo = response;
        _selectedBranch = _companyInfo.apptCurrentBranch;
        _userHasAppt = _companyInfo.apptCurrentBranch.userAppointment.hasAppt;
        _appBarTitle = _companyInfo.companyName;
        _appBarimage = _companyInfo.companyLogo;
        _selectedEmployee = _companyInfo.apptCurrentBranch.employees[0];
        txtFldController_services.text = 'ALL';
        txtFldController_branch.text = _selectedBranch.locationAddress;
      });
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
    } catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
    }
  }

  void _fetchBranchCompany() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await Provider.of<ApptProvider>(context, listen: false)
          .fetchApptCompanyDetail(
              lat: 29.2344,
              lng: -95.3434,
              userId: 100,
              companyId: 1000,
              branchId: _selectedBranch.locationId);
      setState(() {
        _isLoading = false;
        _companyInfo = response;
      });
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
    } catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
    }
  }

  Future _cancelApptUpdate() async {
    try {
      var response =
          await Provider.of<ApptProvider>(context, listen: false).putCancelAppt(
        branchId: _companyInfo.apptCurrentBranch.locationId,
        companyId: _companyInfo.companyId,
        body: {
          'appointmentId':
              _companyInfo.apptCurrentBranch.userAppointment.appointmnetId
        },
      );
      if (response)
        ErrorDialog.showErrorDialog(ctx: context, message: 'Successful');
    } on HttpMessageException catch (error) {
      ErrorDialog.showErrorDialog(ctx: context, message: error.toString());
    } catch (error) {
      ErrorDialog.showErrorDialog(ctx: context, message: error.toString());
    }
  }

  Widget _buildDate(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text('Date:     '),
          UiConstants.hor12SizedBox,
          Expanded(
            child: UiConstants.outLineBtn(
                onPress: _buildDatePicker, btnName: _selectedApptDateString),
          ),
        ],
      ),
    );
  }

  Widget iconBtn({IconData btnIcon, int dateCount}) {
    return IconButton(
        icon: Icon(
          btnIcon,
          color: Colors.blueAccent,
          size: 10,
        ),
        onPressed: () {
          setState(() {
            var formatter = new DateFormat.yMd().add_EEEE();
            _selectedApptDate =
                _selectedApptDate.add(new Duration(days: dateCount));
            _selectedWeekday = _selectedApptDate.weekday;
            _selectedApptDateString = formatter.format(_selectedApptDate);
          });
        });
  }

  GestureDetector _buildEmployeeItem(BuildContext context, double width) {
    final employee = _selectedEmployee; //employeeList[i];
    final employeeFirstName = employee.firstName ?? ' ';
    final employeeLastName = employee.lastName ?? ' ';

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(DetailPromoViewCons.routeName,
        //     arguments: promotionsData[i]);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: width,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: employee != null
                            ? NetworkImage(employee.profileImg)
                            : AssetImage('assets/images/default.jpg'),
                        backgroundColor: Colors.brown.shade800,
                        //child: Text('Alireza khakpour'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(employeeFirstName + ' ' + employeeLastName),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: employee.timeSlot.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2.5),
                  itemBuilder: (ctx, j) =>
                      _buildTimeSlotItem(context, j, employee),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _buildSubmitDialog(
      BuildContext context, Map<String, dynamic> body) async {
    bool wasSuccess = false;
    wasSuccess = await showDialog<bool>(
        context: context, builder: (ctx) => SetApptWidget(body: body));
    return wasSuccess;
  }

  Widget _buildTimeSlotItem(context, i, ApptEmployeeStruct employeeStruct) {
    var formatterdate = new DateFormat('h:mm a');
    DateTime theTimeSlot = employeeStruct.timeSlot[i];
    DateTime selecteTimeWithSlot = DateTime(
        _selectedApptDate.year,
        _selectedApptDate.month,
        _selectedApptDate.day,
        theTimeSlot.hour,
        theTimeSlot.minute);

    var hourNow = DateTime.now().hour;

    String slotTimeString = formatterdate.format(theTimeSlot);

    // List<AppointmentStruct> userApptAtCurrentSlotTime = new List<AppointmentStruct>();
    var userApptAtCurrentSlotTime;

    // print('selecteTimeWithSlot : \n' +
    //     selecteTimeWithSlot.millisecondsSinceEpoch.toString());
    // employeeStruct.appointments != null
    //     ? print('time slot lentgh : \n' +
    //         employeeStruct.appointments[0].startTime.millisecondsSinceEpoch
    //             .toString())
    //     : print('');
    // employeeStruct.appointments != null
    //     ? print('time slot lentgh : \n' +
    //         employeeStruct.appointments[1].startTime.millisecondsSinceEpoch
    //             .toString())
    //     : print('');
    userApptAtCurrentSlotTime = employeeStruct.appointments != null
        ? employeeStruct.appointments.where((w) =>
            w.startTime.isAtSameMomentAs(selecteTimeWithSlot) ||
            (w.endTimeExpected.isBefore(selecteTimeWithSlot) &&
                w.startTime.isAfter(selecteTimeWithSlot)) ||
            w.endTimeExpected.isAtSameMomentAs(selecteTimeWithSlot))
        : [];

    bool isTimeSlotActive = _selectedApptDate.day == DateTime.now().day
        ? hourNow < theTimeSlot.hour
        : userApptAtCurrentSlotTime != null &&
                userApptAtCurrentSlotTime.length > 0
            ? false
            : true;

    Map<String, dynamic> body = {
      'companyId': _companyInfo.companyId,
      'branchId': _selectedBranch.locationId,
      'startTime': selecteTimeWithSlot.toIso8601String(),
      'locationSlotTime': _companyInfo.apptCurrentBranch.locationSlotTime,
      'employeeId': employeeStruct.employeeId,
      'service': _selectedService == null ? 'All' : _selectedService
    };

    return GestureDetector(
      onTap: () async {
        if (isTimeSlotActive) {
          var respoce = await _buildSubmitDialog(context, body);

          setState(() {
            isTimeSlotActive = !respoce;
            _isLoading = true;
          });

          if (respoce) {
            _fetchCompany();
          }
        }
      },
      child: Card(
        color: isTimeSlotActive ? Colors.blueAccent : Colors.grey,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    slotTimeString,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmloyeeAvatarList(
      BuildContext context, int i, List<ApptEmployeeStruct> employeeList) {
    final currentBranch = _companyInfo.apptCurrentBranch != null
        ? _companyInfo.apptCurrentBranch
        : null;
    final employee = employeeList[i];
    final employeeFirstName = employee.firstName ?? ' ';
    final employeeLastName = employee.lastName ?? ' ';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEmployee = employee;
        });
        // Navigator.of(context).pushNamed(DetailPromoViewCons.routeName,
        //     arguments: promotionsData[i]);
      },
      child: CircleAvatar(
        backgroundColor: employee == _selectedEmployee
            ? Colors.blueAccent
            : ColorConstants.backgroundColor,
        minRadius: 28,
        maxRadius: 33,
        child: CircleAvatar(
          minRadius: 25,
          maxRadius: 30,
          backgroundImage: employee != null
              ? NetworkImage(employee.profileImg)
              : AssetImage('assets/images/default.jpg'),
          backgroundColor: Colors.brown.shade800,
          //child: Text('Alireza khakpour'),
        ),
      ),
    );
  }

  void _buildBranchPicker() {
    _sheetActionView(PickerViewType.Branch);
  }

  void _buildServicePicker() {
    _sheetActionView(PickerViewType.Services);
  }

  void _buildDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().add(Duration(days: -1)),
            lastDate: DateTime.now().add(Duration(days: 730)))
        .then<DateTime>((DateTime value) {
      if (value != null) {
        setState(() {
          //_promoForm[JazzbKeyConstants.date1] = value;
          var formatter = new DateFormat.yMd().add_EEEE();
          // String formatted = formatter.format(now);
          _selectedApptDate = value;
          _selectedWeekday = value.weekday;
          _selectedApptDateString = formatter.format(_selectedApptDate);
        });
        //_buildTimePicker(value ?? DateTime.now());
      }
    });
  }

  void _sheetActionView(PickerViewType type) {
    containerForSheet<Map<String, dynamic>>(
      context: context,
      child: CupertinoActionSheet(
        title: const Text('Please choose one'),
        //message: const Text('please'),
        actions: _buildSheetChild(type),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  List<Widget> _buildSheetChild(PickerViewType type) {
    List<CupertinoActionSheetAction> sheetItems = [];
    switch (type) {
      case PickerViewType.Branch:
        for (ApptBranchStruct item in _companyInfo.apptBranches) {
          Map<String, dynamic> data = {
            'name': item.locationAddress,
            'code': item.locationId,
            'type': type,
            'data': item,
            // 'subCatType' : item.subCategory[0].type,
            // 'subCatId' : item.subCategory[0].id,
          };
          sheetItems.add(
            CupertinoActionSheetAction(
              child: Text(item.locationAddress),
              onPressed: () {
                Navigator.pop(context, data);
              },
            ),
          );
        }
        break;
      case PickerViewType.Services:
        // var index = _actionCfg.categories
        //     .indexWhere((item) => item.type == _selectedCat);
        for (ApptServiceStruct item in _companyInfo.services) {
          Map<String, dynamic> data = {
            'name': item.serviceName,
            'code': item.serviceId,
            'type': type,
            'data': item,
          };
          sheetItems.add(
            CupertinoActionSheetAction(
              child: Text(item.serviceName),
              onPressed: () {
                Navigator.pop(context, data);
              },
            ),
          );
        }
        break;
      default:
    }
    return sheetItems;
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((Map<String, dynamic> value) {
      switch (value['type']) {
        case PickerViewType.Branch:
          // _companyForm[JazzbKeyConstants.catIdKey] = value['code'];
          // _companyForm[JazzbKeyConstants.catTypeKey] = value['name'];

          // _companyForm[JazzbKeyConstants.subCatIdKey] = value['subCatId'];
          // _companyForm[JazzbKeyConstants.subCatTypeKey] = value['subCatType'];

          setState(() {
            _selectedBranch = value['data'];
             txtFldController_branch.text = _selectedBranch.locationAddress;
            // _selectedSubCat = value['subCatType'];
            _fetchBranchCompany();
          });

          break;
        case PickerViewType.Services:
          // _companyForm[JazzbKeyConstants.subCatIdKey] = value['code'];
          // _companyForm[JazzbKeyConstants.subCatTypeKey] = value['name'];

          setState(() {
            _selectedService = value['data'];
            txtFldController_services.text = _selectedService.serviceName;
          });

          break;
        default:
      }

      // updateCompany(body, _selectedCompany.id);
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text('You clicked $value'),
      //   duration: Duration(milliseconds: 800),
      // ));
    });
  }

  Widget _buildEmployeeList(double width) {
    List<ApptEmployeeStruct> employeeList = _selectedService == null
        ? _companyInfo.apptCurrentBranch.employees
            .where((s) => s.employeeAvlWeekDays[_selectedWeekday - 1])
            .toList()
        : (_companyInfo.apptCurrentBranch.employees
            .where((s) =>
                s.services.contains(_selectedService.serviceId) &&
                s.employeeAvlWeekDays[_selectedWeekday - 1])
            .toList());

    return Expanded(
      child: Container(
        color: ColorConstants.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: _buildEmployeeItem(context, width),
              ),
            ),
            Container(
              width: width / 2.4,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: employeeList.length,
                  itemBuilder: (_, i) =>
                      _buildEmloyeeAvatarList(context, i, employeeList)),
            ),
          ],
        ),

        // ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: employeeList.length,
        //   itemBuilder: (_, i) =>
        //       _buildEmployeeItem(context, i, employeeList, width),
        // ),
      ),
    );
  }

  Widget _buildDatePhone(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          iconBtn(btnIcon: Icons.arrow_back_ios, dateCount: -1),
          Expanded(
            child: UiConstants.outLineBtn(
                onPress: _buildDatePicker, btnName: _selectedApptDateString),
          ),
          iconBtn(btnIcon: Icons.arrow_forward_ios, dateCount: 1),
        ],
      ),
    );
  }

  Container _buildServicesPickerView(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      child: 
      TextFormField(
        // initialValue: _selectedService != null
        //             ? _selectedService.serviceName
        //             : 'ALL',
                    controller: txtFldController_services,
                readOnly: true,
                style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  onTap: _buildServicePicker,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'Services',
                    
                    // suffixText:
                    //     GalleryLocalizations.of(context).demoTextFieldUSD,
                  ),
                  maxLines: 1,
                ),
     
    );
  }

  Container _buildBranchPickerView(double width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(8),
      child: 
      
      TextFormField(//initialValue: _selectedBranch.locationAddress,
                readOnly: true,
                controller: txtFldController_branch,
                style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  onTap: _buildBranchPicker,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'location',
                    
                    // suffixText:
                    //     GalleryLocalizations.of(context).demoTextFieldUSD,
                  ),
                  maxLines: 1,
                ),
    );
  }

  Container _buildAlertApptContainer() {
    var theTime = _companyInfo.apptCurrentBranch.userAppointment.startTime;
    var formatterdate = new DateFormat.yMMMMEEEEd().add_jm();
    String theTimeString = formatterdate.format(theTime);

    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Appointment Details',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'You already set an appointment on ${theTimeString}.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            FlatButton(
              onPressed: () async {
                setState(() {
                  _userHasAppt = false;
                });

                await _cancelApptUpdate();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Column _buildPhoneScreen(double screenWidth) {
    return Column(
      children: <Widget>[
        _userHasAppt ? _buildAlertApptContainer() : Container(),
        _buildBranchPickerView(screenWidth),
        _buildServicesPickerView(screenWidth),
        _buildDatePhone(screenWidth),
        _buildEmployeeList(screenWidth / 2)
      ],
    );
  }

  Column _buildWebScreen(double screenWidth) {
    return Column(
      children: <Widget>[
        _userHasAppt ? _buildAlertApptContainer() : Container(),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBranchPickerView(screenWidth / 3),
            _buildDate(screenWidth / 3),
            _buildServicesPickerView(screenWidth / 3),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        _buildEmployeeList(screenWidth / 5)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.9;
    final screenhight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            _appBarimage.length > 1
                ? Flexible(
                    child: Image.network(
                    _appBarimage,
                    width: 40,
                  ))
                : Container(),
            SizedBox(
              width: 20,
            ),
            Text(_appBarTitle),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: kIsWeb && screenWidth >= screenhight
                  ? _buildWebScreen(screenWidth)
                  : _buildPhoneScreen(screenWidth),
            ),
    );
  }
}

// void _buildTimePicker(DateTime selecteTime) {
//   showTimePicker(context: context, initialTime: TimeOfDay.now())
//       .then<TimeOfDay>((TimeOfDay onValue) {
//     if (onValue != null) {
//       setState(() {
//         //_promoForm[JazzbKeyConstants.date1] = value;

//         _selectedApptDate = DateTime(
//             _selectedApptDate.year,
//             _selectedApptDate.month,
//             _selectedApptDate.day,
//             onValue.hour,
//             onValue.minute);

//         var formatter = new DateFormat.yMd().add_jm();
//         // String formatted = formatter.format(now);

//         _selectedApptDateString = formatter.format(_selectedApptDate);
//       });
//     }
//   });
// }

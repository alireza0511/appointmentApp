//
//  prefCode-widget-cons.dart
//  JazzB
//
//  Created by Alireza Khakpour on 7/18/19.
//  Copyright © 2019 JazzB. All rights reserved.
//
// package
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../appointment/providers/appt-provier.dart';
import 'package:flutter/material.dart';

// internal
import '../../models/helper/http-exception.dart';
import 'error-dialog.dart';

class SetApptWidget extends StatefulWidget {
  Map<String, dynamic> body;
  SetApptWidget({@required this.body});

  @override
  _SetApptWidgetState createState() => _SetApptWidgetState();
}

class _SetApptWidgetState extends State<SetApptWidget> {
  final _form = GlobalKey<FormState>();
  final _txt1Focus = FocusNode();
  final _txt2Focus = FocusNode();
  final _txt3Focus = FocusNode();
  final _txt1Controller = TextEditingController();
  final _txt2Controller = TextEditingController();
  final _txt3Controller = TextEditingController();
  Map<String, dynamic> body = {};
  var _isInit = true;
  bool checkboxValue = true;

  @override
  void didChangeDependencies() async{
    if (_isInit) {
      body['startTime'] = widget.body['startTime'];
      body['locationSlotTime'] = widget.body['locationSlotTime'];
      body['employeeId'] = widget.body['employeeId'];
      body['service'] = widget.body['service'];

      await fetchUserDefualtData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _txt1Focus.dispose();
    _txt2Focus.dispose();
    _txt3Focus.dispose();

    super.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    String typeKey;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
   
    _form.currentState.save();
    print('\n----------' + body.toString());
   
   if (checkboxValue){
      setUserDefualtData();
    } else {
      
    }

    try {
      var response = await Provider.of<ApptProvider>(context, listen: false)
          .postApptCompanyDetail(
        branchId: widget.body['branchId'],
        companyId: widget.body['companyId'],
        body: body,
      );
      if (response) {
        var userTapped = await ErrorDialog.showErrorDismissDialog(
            ctx: context, title: '', message: 'Successful!');
        if (userTapped) Navigator.pop(context, true);
      }
      //Navigator.of(context).pop();
    } on HttpMessageException catch (error) {
      ErrorDialog.showErrorDialog(ctx: context, message: error.toString());
    } catch (error) {
      ErrorDialog.showErrorDialog(ctx: context, message: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Appointment', style: TextStyle(fontSize: 14, color: Colors.grey),),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildText1(context),
              _buildText2(context),
              _buildText3(context),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: checkboxValue, onChanged: (value){
                    setState(() {
                      checkboxValue = value;
                    });
                  }),
                  Text('save information'),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Submit'),
          onPressed: () {

            _saveForm(context);
            //Navigator.of(context).pop();

            // if (_prefCodeEntered != null && _prefCodeEntered.isNotEmpty) {
            //   _updatePrefCodeFunc(context);
            // } else {
            //   Navigator.of(context).pop();
            //   ErrorDialog.showErrorDialog(ctx: context,message: 'Please, provide four digit code!');
            // }
          },
        ),
      ],
    );
  }

  Widget _buildText1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
        cursorColor: Colors.amber,
        controller: _txt1Controller,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            suffixStyle: TextStyle(color: Colors.blueAccent),
            labelText: 'Name'),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_txt2Focus);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please provide a value.';
          }
          if (value.length < 4) {
            return 'your profile name must be at least three characters long.';
          }
          // return null;
        },
        onSaved: (value) {
          body['name'] = value;
        },
      ),
    );
  }

  Widget _buildText2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        controller: _txt2Controller,
        style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
        cursorColor: Colors.amber,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
            suffixStyle: TextStyle(color: Colors.blueAccent),
            labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_txt3Focus);
        },
        validator: (value) {
          if (!value.isEmpty &&
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter valid email address.';
          }
          // return null;
        },
        onSaved: (value) {
          body['email'] = value;
        },
      ),
    );
  }

  Widget _buildText3(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      
      child: TextFormField(
        controller: _txt3Controller,
        style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
        cursorColor: Colors.amber,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            suffixStyle: TextStyle(color: Colors.blueAccent),
            labelText: 'Phone'),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_txt2Focus);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please provide a value.';
          }
          if (value.length < 10) {
            return 'Please provide a 10 digit phone number.';
          }
          // return null;
        },
        onSaved: (value) {
          body['phone'] = value;
        },
      ),
    );
  }

  
void fetchUserDefualtData() async {
    final userDefualts = await SharedPreferences.getInstance();

    if (userDefualts.getString('name').isNotEmpty &&
        userDefualts.getString('email').isNotEmpty &&
        userDefualts.getString('phone').isNotEmpty) {
      body['name'] = userDefualts.getString('name');
      body['email'] = userDefualts.getString('email');
      body['phone'] = userDefualts.getString('phone');
      setState(() {
        _txt1Controller.text = body['name'];
        _txt2Controller.text = body['email'];
        _txt3Controller.text = body['phone'];
      });
    }
  }

  void setUserDefualtData() async {
    final userDefualts = await SharedPreferences.getInstance();

    userDefualts.setString('name', body['name']);

    userDefualts.setString('email', body['email']);

    userDefualts.setString('phone', body['phone']);
  }

}

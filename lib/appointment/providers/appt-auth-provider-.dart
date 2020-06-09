//
//  auth-provider-admin.dart
//  JazzB
//
//  Created by Alireza Khakpour on 6/6/20.
//  Copyright © 2019 JazzB. All rights reserved.
//
// dart
import 'dart:convert';
import 'dart:io';
// package
import 'package:appointment_app/appointment/models/appt-user-struct.dart';
import 'package:appointment_app/appointment/models/helper/appt-constant.dart';
import 'package:appointment_app/appointment/models/helper/location-struct.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// internal

class ApptAuthProvider with ChangeNotifier {

  ApptUserStruct _user;
  LocationStruct _userLocation;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_user.expiresIn != null &&
        _user.expiryDate.isAfter(DateTime.now()) &&
        _user.token != null) {
      return _user.token;
    }
    return null;
  }

  ApptUserStruct get userInfo {
    return _user;
  }

  LocationStruct get userLocation {
    return _userLocation;
  }

  void setUserLocation(LocationStruct loc) {
    _userLocation = loc;
  }

  

  Future<void> authenticate(String uuid) async {
    
    var url = Uri.https(
        'node.jazzb.com','/appointment/auth');

    print('\n------------\n' + url.toString());
    final Map<String, String> authData = {
      'uuid': uuid,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(authData),
        headers: ApptConstants.createHeader(),
      );

      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String,dynamic> body = json.decode(response.body);
        throw HttpException(
            'Your request returned error message:\n${body['message']} ');
      } else if (response == null) {
        throw HttpException('No data was returned by the request!');
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['responseCode'] != 20) {
        throw HttpException(responseData['message']);
      }

      Map<String, dynamic> successResponse = responseData['response'];
      _user = ApptUserStruct.fromJson(successResponse);

      // _expiryDate = _jazzbAdminUser.expiryDate;
      // .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

 
  Future<bool> hasConnectionToNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

}

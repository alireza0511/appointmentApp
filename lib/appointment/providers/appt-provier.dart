//
//  appt-provider.dart
//  JazzB
//
//  Created by Alireza Khakpour on 4/6/20. 
//  Copyright © 2020 JazzB. All rights reserved.
//

// dart
import 'dart:convert';
import 'dart:io';
// package
import 'package:appointment_app/appointment/models/appt-user-struct.dart';
import 'package:appointment_app/appointment/models/helper/appt-constant.dart';
import '../models/helper/http-exception.dart';
import '../models/appt-company-struct.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
// internal


class ApptProvider with ChangeNotifier {
  ApptCompanyStruct _item;
  
  final ApptUserStruct _user;

  ApptProvider(this._user,this._item);
  
  ApptCompanyStruct get compnayInfo {
    return _item;
  }

  Future<ApptCompanyStruct> fetchApptCompany(
      double lat, double lng, int userId, int companyId) async {
    
    var url = Uri.https(
        'node.jazzb.com','/appointment/user/employee/'+ companyId.toString());

    print(ApptConstants.createHeader(_user.token));

    try {
      final response = await http.get(url, headers: ApptConstants.createHeader(_user.token));

      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String, dynamic> body = json.decode(response.body);
        throw HttpMessageException(
            'Your request returned error message:\n${body['message']} ');
      } else if (response == null) {
        throw HttpMessageException('No data was returned by the request!');
      }

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return null;
      }
      if (responseData[ApptConstants.responseCodeKey] != 20) {
        throw HttpMessageException(responseData[ApptConstants.messageKey]);
      }

      final dynamic parsedJson = responseData[ApptConstants.responseKey];

      ApptCompanyStruct loadedProducts = ApptCompanyStruct.fromJson(parsedJson);
      _item = loadedProducts;

      notifyListeners();
      return loadedProducts;
    } catch (error) {
      throw (error);
    }
  }

 Future<ApptCompanyStruct> fetchApptCompanyDetail({
      double lat, double lng, int userId, int companyId, int branchId}) async {
    
    var queryParameters = {
      'locationId': branchId.toString(),
    };

    var url = Uri.https(
        'node.jazzb.com','/appointment/user/employee/'+ companyId.toString(), queryParameters);

    print(url);

    try {
      final response = await http.get(url);
        
      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String, dynamic> body = json.decode(response.body);
        throw HttpMessageException(
            'Your request returned error message:\n${body['message']} ');
      } else if (response == null) {
        throw HttpMessageException('No data was returned by the request!');
      }

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return null;
      }
      if (responseData[ApptConstants.responseCodeKey] != 20) {
        throw HttpMessageException(responseData[ApptConstants.messageKey]);
      }

      final dynamic parsedJson = responseData[ApptConstants.responseKey];

      ApptCompanyStruct loadedProducts = ApptCompanyStruct.fromJson(parsedJson);
      _item = loadedProducts;

      notifyListeners();
      return loadedProducts;
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> postApptCompanyDetail({
      int companyId, int branchId, Map<String, dynamic> body}) async {
    
    var url = Uri.https(
        'node.jazzb.com','/appointment/user/setAppointment/'+ companyId.toString() + '\/'+branchId.toString());

    print(url);

    print(json.encode(body));

    try {
      final response = await http.post(url, body: json.encode(body) ,headers: ApptConstants.createHeader());
      print(response.body);
      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String, dynamic> body = json.decode(response.body);
        print(body);
        throw HttpMessageException(
            'Your request returned error message:\n${body['message']} ');
      } else if (response == null) {
        throw HttpMessageException('No data was returned by the request!');
      }

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return null;
      }
      if (responseData[ApptConstants.responseCodeKey] != 20) {
        throw HttpMessageException(responseData[ApptConstants.messageKey]);
      }

      final dynamic parsedJson = responseData[ApptConstants.responseKey];
      print(parsedJson);

      
      return true;
    } catch (error) {
      throw (error);
    }
  }

 Future<bool> putCancelAppt({
      int companyId, int branchId, Map<String, dynamic> body}) async {
    
    var url = Uri.https(
        'node.jazzb.com','/appointment/user/cancelAppointment/'+ companyId.toString() + '\/'+branchId.toString());

    print(url);

    print(json.encode(body));

    try {
      final response = await http.put(url, body: json.encode(body) ,headers: ApptConstants.createHeader());
      print(response.body);
      if (response.statusCode < 200 || response.statusCode > 299) {
        Map<String, dynamic> body = json.decode(response.body);
        print(body);
        throw HttpMessageException(
            'Your request returned error message:\n${body['message']} ');
      } else if (response == null) {
        throw HttpMessageException('No data was returned by the request!');
      }

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return null;
      }
      if (responseData[ApptConstants.responseCodeKey] != 20) {
        throw HttpMessageException(responseData[ApptConstants.messageKey]);
      }

      final dynamic parsedJson = responseData[ApptConstants.responseKey];
      print(parsedJson);

      
      return true;
    } catch (error) {
      throw (error);
    }
  }
}

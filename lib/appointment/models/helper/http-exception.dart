//
//  http-exception.dart
//  JazzB
//
//  Created by Alireza Khakpour on 7/8/19.
//  Copyright © 2019 JazzB. All rights reserved.
//
class HttpMessageException implements Exception {
  final String message;

  HttpMessageException(this.message);

  @override
  String toString() {
    return  message;
    // return super.toString(); // Instance of HttpException
  }
}
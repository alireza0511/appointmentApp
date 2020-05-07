import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog({
    BuildContext ctx,
    String title = 'An Error Occurred!',
    String message,
  }) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const Text('Okay'),
            onPressed: () {
              
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  static Future<bool> showErrorOptionDialog({
    BuildContext ctx,
    String title = 'An Error Occurred!',
    String message,
  }) async {
    bool accept = false;
    await showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Okay'),
                  onPressed: () {
                    accept = true;
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    accept = false;
                    Navigator.of(ctx).pop();
                    // return false;
                  },
                )
              ],
            ));
    return accept;
  }

  static Future<bool> showErrorDismissDialog({
    BuildContext ctx,
    String title = 'An Error Occurred!',
    String message,
  }) async {
    bool accept = false;
    await showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    accept = true;
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ));
    return accept;
  }

 
}

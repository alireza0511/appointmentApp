import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appointment/providers/appt-auth-provider-.dart';
import 'appointment/providers/appt-provier.dart';
import 'appointment/views/schedule-view.dart';
import 'appointment/views/widget/error-dialog.dart';
import 'appointment/views/widget/ui-constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ApptAuthProvider()
          ),
          ChangeNotifierProxyProvider<ApptAuthProvider,ApptProvider>(
            create: null, 
            update: (context, auth, previousData) => ApptProvider(auth.userInfo,
               previousData == null ? null : previousData.compnayInfo),),
        
      ],
      child: Consumer<ApptAuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          theme: ThemeData(
            brightness: ColorConstants.brightness,
            primarySwatch: ColorConstants.primarySwatch,
            accentColor: ColorConstants.accentColor,
            buttonColor: ColorConstants.buttonColor,
          ),
          debugShowCheckedModeBanner: false,
          home: Home(),
          routes: {},
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          child: OutlineButton(
        child: Text('Login'),
        onPressed: () async{
          if(await _login(context)){
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => ScheduleView()));

          }
        },
      )),
    );
  }

  Future<bool> _login(BuildContext context) async {
    try {
      await Provider.of<ApptAuthProvider>(context, listen: false)
          .authenticate('webversionofapplication');
      return true;
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
          return false;
    } catch (error) {
      ErrorDialog.showErrorDialog(
          ctx: context, title: 'Error!', message: error.toString());
           return false;
    }
   
  }
  
}

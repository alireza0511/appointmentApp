import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appointment/providers/appt-provier.dart';
import 'appointment/views/schedule-view.dart';
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
          value: ApptProvider(),
        ),
      ],
      child: Consumer<ApptProvider>(
        builder: (context, auth, _) => MaterialApp(
          theme: ThemeData(
            brightness: ColorConstants.brightness,
            primarySwatch: ColorConstants.primarySwatch,
            accentColor: ColorConstants.accentColor,
            buttonColor: ColorConstants.buttonColor,
          ),
          debugShowCheckedModeBanner: false,
          home: ScheduleView(),
          routes: {},
        ),
      ),
    );
  }
}

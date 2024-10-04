import 'package:agrohub/farmState.dart';
import 'package:agrohub/gamePage.dart';
import 'package:agrohub/mapPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'buttonNavigator.dart'; // Your navigation bar

// Global variable to store the camera list
List<CameraDescription>? cameras;

void main() async {
  // Ensure the camera is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FarmState(), // Provide the FarmState
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ButtomNavigationBar(),
        ),
      ),
    );
  }
}

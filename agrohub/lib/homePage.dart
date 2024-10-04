import 'package:agrohub/ArCameraPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.camera_alt, size: 100.0, color: Colors.green),
          onPressed: () {
            // Navigate to the AR camera page when the icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ARCameraPage()),
            );
          },
        ),
      ),
    );
  }
}

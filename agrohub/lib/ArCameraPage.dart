import 'package:agrohub/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ARCameraPage extends StatefulWidget {
  const ARCameraPage({super.key});

  @override
  State<ARCameraPage> createState() => _ARCameraPageState();
}

class _ARCameraPageState extends State<ARCameraPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String? temperature;
  String? humidity;
  String? windSpeed; // This will store wind speed in km/h
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getWeatherData();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(cameras![0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _getWeatherData() async {
    try {
      Position position = await _getCurrentLocation();
      final lat = position.latitude;
      final lon = position.longitude;

      setState(() {
        latitude = lat.toString();
        longitude = lon.toString();
      });

      final apiKey = 'b9a18466e45db5a837eb102cf365529d';
      final weatherUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(weatherUrl));
      final data = json.decode(response.body);

      setState(() {
        temperature = data['main']['temp'].toString();
        humidity = data['main']['humidity'].toString();

        // Convert wind speed from m/s to km/h
        double windSpeedInKmH = (data['wind']['speed'] as double) * 3.6;
        windSpeed =
            windSpeedInKmH.toStringAsFixed(2); // Rounded to 2 decimal places
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller!),
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weather Info:",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
                // if (latitude != null && longitude != null) ...[
                //   Text(
                //     "Latitude: $latitude",
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.white,
                //       backgroundColor: Colors.black.withOpacity(0.5),
                //     ),
                //   ),
                //   Text(
                //     "Longitude: $longitude",
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.white,
                //       backgroundColor: Colors.black.withOpacity(0.5),
                //     ),
                //   ),
                // ],
                if (temperature != null) ...[
                  Text(
                    "Temperature: $temperature°C",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
                if (humidity != null) ...[
                  Text(
                    "Humidity: $humidity%",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
                if (windSpeed != null) ...[
                  Text(
                    "Wind Speed: $windSpeed km/h", // Show wind speed in km/h
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

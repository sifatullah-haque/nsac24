import 'package:agrohub/const/ColorWillBe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late Future<Map<String, dynamic>> weatherData; // To store weather data

  // Update the LatLng with the new coordinates
  final LatLng _center = const LatLng(24.8490, 89.3469); // New location

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeatherData(); // Fetch data when page is loaded
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Fetch weather data from OpenWeatherMap API (replace YOUR_API_KEY with your actual API key)
  Future<Map<String, dynamic>> fetchWeatherData() async {
    final lat = 24.8490;
    final lon = 89.3469;
    final apiKey =
        'b9a18466e45db5a837eb102cf365529d'; // Replace with your OpenWeatherMap API key

    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Parse the JSON response
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWillBe.whiteColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(40.h), // Set the desired height for the AppBar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
          child: AppBar(
            backgroundColor: colorWillBe.secondaryColor,
            toolbarHeight: 40.h, // Adjust the height of the toolbar here
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            title: const Text('Birds Eye View'),
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWillBe.whiteColor,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // Clip the GoogleMap with rounded corners
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.r), // Apply rounded corners
                child: Container(
                  width: double.infinity, // Custom width
                  height: 250, // Custom height
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center, // Set to the new coordinates
                      zoom: 19,
                    ),
                    mapType: MapType.satellite, // Set the map to satellite view
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "This is how your farm looks from the sky",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: colorWillBe.textColor,
                ),
              ),
              SizedBox(height: 20.h),

              // Fetch and display weather data from the OpenWeatherMap API
              FutureBuilder<Map<String, dynamic>>(
                future: weatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loader while waiting for data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!; // Extract the weather data
                    var temperature = data['main']['temp'];
                    var windSpeed = data['wind']['speed'];
                    var rain = data['rain'] != null
                        ? data['rain']['1h'] ?? 'No rain in last hour'
                        : 'No rain';
                    var weatherDescription = data['weather'][0]['description'];

                    return Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weather Info In your area",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: colorWillBe.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Temperature: ${temperature}°C",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorWillBe.textColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Wind Speed: ${windSpeed} m/s",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorWillBe.textColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Rain: $rain",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorWillBe.textColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Weather Condition: $weatherDescription",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: colorWillBe.textColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text('No weather data available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

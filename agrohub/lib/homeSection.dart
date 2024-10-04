import 'package:agrohub/const/ColorWillBe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the chart package

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWillBe.whiteColor,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(50.h), // Set the desired height for the AppBar
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
            child: AppBar(
              backgroundColor: colorWillBe.secondaryColor,
              toolbarHeight: 50.h, // Adjust the height of the toolbar here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              title: const Text('Good Morning!'),
              actions: [
                Icon(Icons.thermostat,
                    size: 25.h, color: colorWillBe.whiteColor),
                Text(
                  "25°C",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: colorWillBe.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 15.w),
              ],
              titleTextStyle: TextStyle(
                fontSize: 18.sp,
                color: colorWillBe.whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              weatherReport(),
              SizedBox(height: 20.h),
              Text(
                'Chances of Natural Disasters (In 45 days)',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: colorWillBe.textColor,
                ),
              ),
              SizedBox(height: 10.h),
              BarOfDisaster(),
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  width: 150.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorWillBe.warningColor),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "What to do now?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colorWillBe.warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Crop Health Test',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: colorWillBe.textColor,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CropHealth(
                      title: "Take a photo",
                      icon: Icons.camera_alt_rounded,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CropHealth(
                      title: "Upload a photo",
                      icon: Icons.file_upload_outlined,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CropHealth(
                      title: "Learn more",
                      icon: Icons.menu_book_rounded,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class CropHealth extends StatelessWidget {
  final String title;
  final IconData icon;

  const CropHealth({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60.h,
          // width: 60.h,
          decoration: BoxDecoration(
            color: colorWillBe.secondaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Icon(icon, size: 30.h, color: colorWillBe.whiteColor),
          ),
        ),
        SizedBox(height: 5.h),
        Text(title,
            style: TextStyle(
                fontSize: 12.sp,
                color: colorWillBe.textColor,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}

class BarOfDisaster extends StatelessWidget {
  const BarOfDisaster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h, // Fixed height for the chart
      width: double.infinity, // Full width of the container
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Floods');
                    case 1:
                      return const Text('Droughts');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 80, // High chance of floods
                  color: colorWillBe.errorColor,
                  width: 20.w,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 20, // Low chance of droughts
                  color: colorWillBe.secondaryColor,
                  width: 20.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class weatherReport extends StatelessWidget {
  const weatherReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: colorWillBe.secondaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor: colorWillBe.whiteColor,
                        child: Icon(
                          Icons.air_rounded,
                          color: colorWillBe.secondaryColor,
                          size: 15.h,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text("Wind Speed: 25 km/h",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: colorWillBe.whiteColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 3,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: colorWillBe.secondaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor: colorWillBe.whiteColor,
                        child: Icon(
                          Icons.wb_cloudy_outlined,
                          color: colorWillBe.secondaryColor,
                          size: 15.h,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text("Cloudy: 25%",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: colorWillBe.whiteColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: colorWillBe.warningColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor: colorWillBe.whiteColor,
                        child: Icon(
                          Icons.sunny_snowing,
                          color: colorWillBe.secondaryColor,
                          size: 15.h,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text("Rain: 85%",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: colorWillBe.whiteColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 4,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: colorWillBe.secondaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor: colorWillBe.whiteColor,
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          color: colorWillBe.secondaryColor,
                          size: 15.h,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text("Heatwave: NO",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: colorWillBe.whiteColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

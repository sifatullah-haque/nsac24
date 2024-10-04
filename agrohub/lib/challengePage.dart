import 'package:agrohub/const/ColorWillBe.dart';
import 'package:agrohub/gamePage.dart';
import 'package:agrohub/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample leaderboard data
    List<Map<String, dynamic>> leaderboard = [
      {"name": "Alice", "score": 150, "position": 1},
      {"name": "Bob (You)", "score": 130, "position": 2},
      {"name": "Charlie", "score": 120, "position": 3},
      {"name": "Diana", "score": 110, "position": 4},
      {"name": "Eve", "score": 100, "position": 5},
    ];

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
            title: const Text('Crop Challenges'),
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWillBe.whiteColor,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Quiz page when the button is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage()),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: colorWillBe.secondaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15.r,
                            backgroundColor: colorWillBe.whiteColor,
                            child: Icon(
                              Icons.videogame_asset,
                              color: colorWillBe.secondaryColor,
                              size: 15.h,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text("Play game",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: colorWillBe.whiteColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Quiz page when the button is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Quiz()),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: colorWillBe.secondaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15.r,
                            backgroundColor: colorWillBe.whiteColor,
                            child: Icon(
                              Icons.quiz_rounded,
                              color: colorWillBe.secondaryColor,
                              size: 15.h,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text("Play Quiz",
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
            SizedBox(height: 20.h),
            Center(
              child: Text("Leaderboard",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: colorWillBe.secondaryColor,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 20.h),

            // Leaderboard List
            Expanded(
              child: ListView.builder(
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  var player = leaderboard[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Row(
                        children: [
                          // Player Position
                          CircleAvatar(
                            radius: 15.r,
                            backgroundColor: colorWillBe.secondaryColor,
                            child: Text(
                              player['position'].toString(),
                              style: TextStyle(
                                color: colorWillBe.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),

                          // Player Name
                          Expanded(
                            child: Text(
                              player['name'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: colorWillBe.secondaryColor,
                              ),
                            ),
                          ),

                          // Player Score
                          Text(
                            "${player['score']} pts",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: colorWillBe.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

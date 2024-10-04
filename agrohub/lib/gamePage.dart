import 'package:agrohub/const/ColorWillBe.dart';
import 'package:agrohub/farmState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the FarmState using Provider
    final farmState = Provider.of<FarmState>(context);

    return Scaffold(
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
            title: const Text('Farming Game'),
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWillBe.whiteColor,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: farmState.gameOver
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Final Points: ${farmState.points}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      farmState.resetFarm(); // Reset the game
                    },
                    child: const Text('Restart Game'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tap to plant or harvest crops',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Points: ${farmState.points}', // Show points
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Seeds left: ${farmState.seeds}', // Show seeds left
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time left: ${farmState.timeLeft}s', // Show time left
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Number of fields per row
                    ),
                    itemCount: farmState.farm.length,
                    itemBuilder: (context, index) {
                      final tileState = farmState.farm[index];
                      return GestureDetector(
                        onTap: () {
                          farmState.toggleTile(
                              index); // Change the state when tapped
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: tileState == CropState.empty
                                ? Colors.brown[300]
                                : tileState == CropState.grown
                                    ? Colors.green
                                    : Colors.yellow,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(
                            child: Text(
                              tileState == CropState.empty
                                  ? ''
                                  : tileState == CropState.grown
                                      ? '🌾'
                                      : '🌱',
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      farmState.resetFarm(); // Reset all tiles and points
                    },
                    child: const Text('Reset Farm'),
                  ),
                ),
              ],
            ),
    );
  }
}

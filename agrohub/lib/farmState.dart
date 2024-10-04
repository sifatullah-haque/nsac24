import 'dart:async';
import 'package:flutter/material.dart';

class FarmState with ChangeNotifier {
  static const int farmSize = 25; // 5x5 grid
  List<CropState> farm = List<CropState>.filled(farmSize, CropState.empty);
  int points = 0; // Points system
  int seeds = 10; // Limited seeds
  bool gameOver = false; // Game over state
  int timeLeft = 60; // 60-second time limit for the game
  Timer? _gameTimer;

  FarmState() {
    _startGameTimer();
  }

  // Starts the overall game timer for a 60-second game
  void _startGameTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        gameOver = true;
        _gameTimer?.cancel();
        notifyListeners();
      }
    });
  }

  // Toggles the crop state when tapped
  void toggleTile(int index) {
    if (gameOver || seeds == 0)
      return; // Don't allow actions if game is over or no seeds left

    if (farm[index] == CropState.empty && seeds > 0) {
      // Plant the crop and start timer for growth
      farm[index] = CropState.planted;
      seeds--; // Decrease seed count
      notifyListeners();
      _startGrowthTimer(index);
    } else if (farm[index] == CropState.grown) {
      // Harvest the crop and add points
      farm[index] = CropState.empty;
      points += 10; // 10 points for each harvested crop
      notifyListeners();
    }
  }

  // Resets the farm and points
  void resetFarm() {
    farm = List<CropState>.filled(farmSize, CropState.empty);
    points = 0; // Reset points
    seeds = 10; // Reset seeds
    gameOver = false; // Reset game over state
    timeLeft = 60; // Reset time
    _startGameTimer();
    notifyListeners();
  }

  // Timer to grow the crop after 3 seconds and wither after 5 more seconds
  void _startGrowthTimer(int index) {
    Future.delayed(const Duration(seconds: 3), () {
      if (farm[index] == CropState.planted) {
        farm[index] = CropState.grown;
        notifyListeners();

        // Start decay timer
        _startDecayTimer(index);
      }
    });
  }

  // Timer to decay the crop after 5 seconds if not harvested
  void _startDecayTimer(int index) {
    Future.delayed(const Duration(seconds: 5), () {
      if (farm[index] == CropState.grown) {
        // Crop has withered
        farm[index] = CropState.empty;
        points -= 5; // Lose points for withered crop
        notifyListeners();
      }
    });
  }
}

// Enum to represent the state of each crop tile
enum CropState {
  empty, // No crop
  planted, // Planted, but not grown
  grown, // Grown and ready to harvest
}

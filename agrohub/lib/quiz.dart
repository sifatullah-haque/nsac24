import 'package:agrohub/buttonNavigator.dart';
import 'package:agrohub/const/ColorWillBe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // Define a list of questions and answers (both image-based and text-based)
  final List<Map<String, dynamic>> _questions = [
    {
      "type": "text", // Type of question (text-based)
      "question":
          "What is the best time to irrigate crops to minimize water evaporation?",
      "options": ["Early morning", "Noon", "Late afternoon", "Evening"],
      "answer": 0, // Index of the correct answer (A = 0)
    },
    {
      "type": "image", // Type of question (image-based)
      "image": "assets/1.jpeg",
      "question":
          "What could be the reason for the yellowing leaves on this tree?",
      "options": [
        "Overwatering",
        "Nitrogen deficiency",
        "Fungal infection",
        "Lack of sunlight"
      ],
      "answer": 2, // Correct answer (Fungal infection)
    },
    {
      "type": "text", // Type of question (text-based)
      "question":
          "Which of the following practices helps conserve water in farming?",
      "options": [
        "Overwatering plants",
        "Drip irrigation",
        "Growing the same crop every year",
        "Leaving soil bare"
      ],
      "answer": 0, // Index of the correct answer (A = 0)
    },
    {
      "type": "image", // Type of question (image-based)
      "image": "assets/2.jpeg",
      "question": "What disease is affecting this crop?",
      "options": ["Powdery mildew", "Blight", "Root rot", "Rust fungus"],
      "answer": 2, // Correct answer (Fungal infection)
    },
    {
      "type": "text", // Type of question (text-based)
      "question": "Which factor is most likely to contribute to soil erosion?",
      "options": [
        "Heavy rainfall",
        "Irrigation",
        "Crop rotation",
        "Shade trees"
      ],
      "answer": 0, // Correct answer (A = 0)
    }
  ];

  int _currentQuestionIndex = 0; // Track the current question index
  int _correctAnswers = 0; // Track the number of correct answers
  int? _selectedOption; // Track the selected option by the user

  // Function to handle option selection
  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  // Function to move to the next question
  void _nextQuestion() {
    if (_selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _correctAnswers++; // Increase the score if the answer is correct
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null; // Reset selected option for the next question
      });
    } else {
      // Navigate to the results page when all questions are answered
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultsPage(score: _correctAnswers, total: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final options = currentQuestion['options'] as List<String>;

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conditional rendering of question type (text or image)
            if (currentQuestion['type'] == 'text')
              // Text-based question
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  currentQuestion['question'],
                  style: const TextStyle(fontSize: 18.0),
                ),
              )
            else if (currentQuestion['type'] == 'image')
              // Image-based question with text under the image
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 150.h,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      currentQuestion['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text under the image
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      currentQuestion[
                          'question'], // Display the question under the image
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            const SizedBox(height: 20.0),
            // Options
            Column(
              children: List.generate(options.length, (index) {
                return GestureDetector(
                  onTap: () => _selectOption(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: _selectedOption == index
                          ? colorWillBe.secondaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            options[index],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20.0),
            // Next Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorWillBe.secondaryColor,
              ),
              onPressed: _selectedOption != null
                  ? () {
                      _nextQuestion();
                    }
                  : null, // Disable button if no option is selected
              child: _currentQuestionIndex == _questions.length - 1
                  ? Text('See Results',
                      style: TextStyle(color: colorWillBe.whiteColor))
                  : const Text('Next Question',
                      style: TextStyle(color: colorWillBe.whiteColor)),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;
  final int total;

  const ResultsPage({super.key, required this.score, required this.total});

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You scored $score out of $total',
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorWillBe.secondaryColor,
                ),
                onPressed: () {
                  // Navigate to home and remove all previous routes
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ButtomNavigationBar(), // Navigate to the home page
                    ),
                    (Route<dynamic> route) =>
                        false, // This removes all previous routes
                  );
                },
                child: Text(
                  'Go Home',
                  style: TextStyle(color: colorWillBe.whiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

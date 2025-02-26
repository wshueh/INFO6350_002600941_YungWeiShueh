import 'package:flutter/material.dart';

class QuizCompletedScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRestart;

  QuizCompletedScreen(
      {required this.score,
      required this.totalQuestions,
      required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Completed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Score: $score/$totalQuestions',
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              child: Text('Take the Quiz Again'),
            ),
          ],
        ),
      ),
    );
  }
}

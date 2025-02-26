import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Map question;
  final bool isMultipleChoice;
  final int questionIndex;

  QuestionWidget(
      {required this.question,
      required this.isMultipleChoice,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Question ${questionIndex + 1}: ${isMultipleChoice ? "(Multiple Choice)" : ""}',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(question['question'], style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
      ],
    );
  }
}

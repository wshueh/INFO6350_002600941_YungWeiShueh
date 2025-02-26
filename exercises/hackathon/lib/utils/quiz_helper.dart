import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class QuizHelper {
  static Future<List<Map<String, dynamic>>> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final List<dynamic> data = json.decode(response);

    List<Map<String, dynamic>> questions =
        List<Map<String, dynamic>>.from(data);
    questions.shuffle(Random());

    return questions;
  }
}

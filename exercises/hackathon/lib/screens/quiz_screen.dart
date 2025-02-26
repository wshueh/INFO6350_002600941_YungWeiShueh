import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/quiz_helper.dart';
import '../widgets/question_widget.dart';
import '../widgets/option_button.dart';
import '../widgets/quiz_completed.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  Timer? _timer;
  int _timeLeft = 60;
  Set<String> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void startTimer() {
    _timer?.cancel();
    _timeLeft = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
        submitAnswer();
      }
    });
  }

  Future<void> loadQuestions() async {
    List<Map<String, dynamic>> data = await QuizHelper.loadQuestions();
    setState(() {
      questions = data;
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
      selectedAnswers.clear();
      startTimer();
    });
  }

  void selectAnswer(String answer) {
    setState(() {
      if (selectedAnswers.contains(answer)) {
        selectedAnswers.remove(answer);
      } else {
        selectedAnswers.add(answer);
      }
    });
  }

  void submitAnswer() {
    if (selectedAnswers.isEmpty) {
      moveToNextQuestion();
      return;
    }

    List<String> correctAnswers =
        List<String>.from(questions[currentQuestionIndex]['answer']);

    if (Set.from(selectedAnswers).containsAll(correctAnswers) &&
        Set.from(correctAnswers).containsAll(selectedAnswers)) {
      score++;
    }

    selectedAnswers.clear();
    moveToNextQuestion();
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        startTimer();
      });
    } else {
      setState(() {
        quizCompleted = true;
        _timer?.cancel();
      });
    }
  }

  void restartQuiz() {
    loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      return QuizCompletedScreen(
          score: score,
          totalQuestions: questions.length,
          onRestart: restartQuiz);
    }

    if (questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var question = questions[currentQuestionIndex];
    bool isMultipleChoice = question.containsKey('isMultipleChoice') &&
        question['isMultipleChoice'] == true;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz App'), actions: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Time: $_timeLeft s', style: TextStyle(fontSize: 18)),
        )
      ]),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionWidget(
                question: question,
                isMultipleChoice: isMultipleChoice,
                questionIndex: currentQuestionIndex),
            ...List<String>.from(question['options'])
                .map((option) => OptionButton(
                      option: option,
                      isSelected: selectedAnswers.contains(option),
                      onTap: () => selectAnswer(option),
                    )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitAnswer,
              child: Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

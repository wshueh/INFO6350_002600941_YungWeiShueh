import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (value == "=") {
        _num2 = double.tryParse(_input) ?? 0;
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
            break;
        }
        _input = "";
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        _num1 = double.tryParse(_input) ?? 0;
        _operator = value;
        _input = "";
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(value),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          textStyle: const TextStyle(fontSize: 24),
        ),
        child: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" vv calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _output,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["7", "8", "9", "÷"]
                    .map((value) => Expanded(child: _buildButton(value)))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["4", "5", "6", "×"]
                    .map((value) => Expanded(child: _buildButton(value)))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["1", "2", "3", "-"]
                    .map((value) => Expanded(child: _buildButton(value)))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["C", "0", "=", "+"]
                    .map((value) => Expanded(child: _buildButton(value)))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Quizzler_questions.dart';

void main() => runApp(Quizzler());

QuizlerQuestions questions = QuizlerQuestions();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> Result = [];

  check_answer(bool answer) {
    bool finish = questions.GoToNextQuestion();

    if (finish == true) {
      if (answer == questions.Question_answer()) {
        Result.add(Icon(
          Icons.done,
          color: Colors.green,
        ));
      } else {
        Result.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    } else {
      Alert(
          context: context,
          title: "Finishied",
          desc: "You were Good",
          buttons: [
            DialogButton(
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                questions.Reset_questions();
                setState(() {
                  Result.clear();
                  questions.GoToNextQuestion();
                  Navigator.pop(context);
                });
              },
              width: 120,
            )
          ]).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.Question_text(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  check_answer(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  check_answer(false);
                });
              },
            ),
          ),
        ),
        Row(
          children: Result,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

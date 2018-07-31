import 'package:flutter/material.dart';
import 'package:flutter_crash_course/utils/question.dart';
import 'package:flutter_crash_course/utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';
import '../pages/score_page.dart';

class QuizPage extends StatefulWidget{

  @override
  State createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Ellon Musk is human", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is awesome", true),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer){
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      overlayOn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false,() => handleAnswer(false)),
          ],
        ),
        overlayOn == true ? new CorrectWrongOverlay(
          isCorrect,
            () {
              if(quiz.length == questionNumber) {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
                return;
              }
              currentQuestion = quiz.nextQuestion;
              this.setState((){
                overlayOn = false;
                questionText = currentQuestion.question;
                questionNumber = quiz.questionNumber;
              });
            }
        ) : new Container(

        )
      ],
    );
  }
}
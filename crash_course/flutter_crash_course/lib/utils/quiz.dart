import 'package:flutter_crash_course/utils/question.dart';

class Quiz{
  List<Question> _questions;
  int _currentQuestionIdx = -1;
  int _score = 0;

  Quiz(this._questions){
    _questions.shuffle();
  }

  int get score => _score;
  int get length => _questions.length;
  List<Question> get questions => _questions;
  int get questionNumber => _currentQuestionIdx + 1;

  Question get nextQuestion{
    _currentQuestionIdx ++;
    if(_currentQuestionIdx >= length) return null;
    return _questions[_currentQuestionIdx];
  }

  void answer(bool isCorrect){
    if(isCorrect) _score++;
  }

}

import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final List<Question> _questions = [
    Question(
        "Après leur mort, les héros et les gens vertueux seretrouvaient aux Champs Élysées.",
        true),
    Question(
        "La division du territoire en cités-États a assuré une longue période de paix dans la civilisation grecque.",
        false),
    Question(
        "À l'origine, le mot agora servait à désigner une assemblée de prêtresses dans un lieu public.",
        false),
    Question("Platon n'a laissé aucun écrit.", 
        false),
    Question("Homère est un personnage de l'Odyssée, comme Ulysse.", 
        false),
    Question(
        "Les esclaves qui remportaient une compétition olympique gagnaient aussi leur liberté.",
        false),
    Question(
        "La médecine par les songes était pratiquée au sanctuaire d'Asclépios.",
        true),
    Question(
        "L'expression « une victoire à la Pyrrhus » signifie une victoire surprise.",
        false),
    Question("La Vénus de Milo représente en fait la déesse Aphrodite.", 
        true),
    Question("Zeus était la divinité vénérée au Parthénon.", 
        false),
  ];

  int _questionIndex = 0;
  int _score = 0;

  void _answerQuestion(bool answer) {
    if (_questions[_questionIndex].answer == answer) {
      _score++;
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenue à votre quizz!'),
        ),
        body: Center(
          child: _questionIndex < _questions.length
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "La Grèce antique",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.cyan,
                      ),
                    ),
                    Divider(height: 20,),
                    Text(
                      "${_questionIndex + 1}/${_questions.length}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _questions[_questionIndex].question,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Vrai',
                          ),
                          onPressed: () => _answerQuestion(true),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Faux'),
                          onPressed: () => _answerQuestion(false),
                        ),
                      ],
                    ),
                  ],
                )
              : AlertDialog(
                  title: Text('Quizz terminé !',
                  style: TextStyle(color: Colors.lightBlue),),
                  content: Text('Score : $_score / ${_questions.length}'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.refresh_sharp),
                      onPressed: () {
                        _resetQuiz();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final bool answer;

  Question(this.question, this.answer);
}

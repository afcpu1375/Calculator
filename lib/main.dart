import 'package:calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var inputUser = '';
  var result='';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text1)),
          onPressed: () {
            if(text1=='ac'){
              setState(() {
                inputUser='';
                result='';
              });
            }else{
              buttonPressed(text1);

            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text1,
              style: TextStyle(fontSize: 26, color: getTextColor(text1)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text2)),
          onPressed: () {
            if (text2 == 'ec') {
              setState(() {
                if (inputUser.isNotEmpty) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text2,
              style: TextStyle(fontSize: 26, color: getTextColor(text2)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text3)),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text3,
              style: TextStyle(fontSize: 26, color: getTextColor(text3)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text4)),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);

              setState(() {
                result= eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text4,
              style: TextStyle(fontSize: 26, color: getTextColor(text4)),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: textGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ),
                      Text(
                        result,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: textGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 45),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ec', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ec', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color getTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}

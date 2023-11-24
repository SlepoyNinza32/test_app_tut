import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:test_app_tut/main.dart';
import 'package:test_app_tut/test_model.dart';
import 'package:test_app_tut/test_page.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({super.key, required this.answers, required this.test});

  TestsModel test;
  List<String> answers;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  int trueAnswers = 0;
  int fakeAnswers = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.test.test);
    print(widget.answers);
    for (int i = 0; i < widget.test.test.length; i++) {
      if (widget.answers[i] == widget.test.test[i].trueAnswer) {
        trueAnswers++;
      } else {
        fakeAnswers++;
      }
    }
    print('trueAnswers ' + trueAnswers.toString());
    print('fakeAnswers ' + fakeAnswers.toString());
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.test);
    // print(widget.answers);
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleCircularProgressBar(
              size: 200,
              valueNotifier:
                  ValueNotifier<double>(double.parse(trueAnswers.toString())),
              progressStrokeWidth: 24,
              backStrokeWidth: 24,
              maxValue: double.parse(widget.test.test.length.toString()),
              mergeMode: true,
              // onGetText: (value) {
              //   return Text(
              //     '${value.toInt()}',
              //   );
              // },
              progressColors: [Color(0xff39FF14)],
              backColor: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Correct answers: ${trueAnswers}',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Wrong answers: ${fakeAnswers}',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TestPage(test: widget.test),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh, color: Colors.white,),
                          Text(
                            'ReTest',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MyApp(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.home, color: Colors.white,),
                          Text(
                            'Go to next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

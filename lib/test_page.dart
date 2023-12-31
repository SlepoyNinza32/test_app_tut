import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_tut/resulats_page.dart';
import 'package:test_app_tut/test_model.dart';

class TestPage extends StatefulWidget {
  TestPage({super.key, required this.test});

  TestsModel test;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> listOfAnswers = [];
  int indexList = 0;
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.test.name!.toUpperCase(),
          style: const TextStyle(
            color: Color(0xffEDF5E1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff05386B),
      ),
      backgroundColor: const Color(0xff5CDB95),
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //scrollDirection: Axis.horizontal,
        itemBuilder: (context, ind) {
          //indexList = ind;
          answers.clear();
          answers.add(widget.test.test![indexList].trueAnswer.toString());
          answers.add(widget.test.test![indexList].fakeAnswer3.toString());
          answers.add(widget.test.test![indexList].fakeAnswer2.toString());
          answers.add(widget.test.test![indexList].fakeAnswer1.toString());
          answers.shuffle();
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.purple[800],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width - 16,
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: Center(
                    child: Text(
                      '${widget.test.test![indexList].question}',
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color(0xffEDF5E1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(
                          () {
                            listOfAnswers.add(answers[index]);
                            // print(widget.test.test.length);
                            if (widget.test.test!.length-1 > indexList) {
                              indexList+=1;
                            } else {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ResultsPage(test: widget.test, answers: listOfAnswers),
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: index == 0
                              ? Colors.blue[900]
                              : index == 1
                                  ? Colors.teal[800]
                                  : index == 2
                                      ? Colors.orange[300]
                                      : Colors.pink[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            answers[index],
                            style: const TextStyle(
                              color: Color(0xffEDF5E1),
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.test.test!.length,
      ),
    );
  }
}

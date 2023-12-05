import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_tut/main.dart';
import 'package:test_app_tut/test_model.dart';

class CreateTestPage extends StatefulWidget {
  CreateTestPage({
    super.key,
    required this.lengthOfQuestions,
    required this.nameOfTest,
  });

  int lengthOfQuestions;
  String nameOfTest;

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  int countOfQuestions = 1;
  List<Test> tests = [];
  List<ControllersModel> controlers = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController trueAnswerCont = TextEditingController();
  TextEditingController fakeAnswer1Cont = TextEditingController();
  TextEditingController fakeAnswer2Cont = TextEditingController();
  TextEditingController fakeAnswer3Cont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controlers =
        List.generate(widget.lengthOfQuestions, (index) => ControllersModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text(
          '${widget.nameOfTest}',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[50],
      ),
      body: SingleChildScrollView(
        physics: RangeMaintainingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                  itemCount: controlers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width - 16,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, right: 8.0, left: 8.0, top: 16.0),
                            child: Text(
                              'Test: ${index}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoTextField(
                              controller: controlers[index].questionController,
                              placeholder: 'Question',
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoTextField(
                              controller: controlers[index].trueAnswerCont,
                              placeholder: 'Correct answer',
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoTextField(
                              controller: controlers[index].fakeAnswer1Cont,
                              placeholder: 'Wrong answer 1',
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoTextField(
                              controller: controlers[index].fakeAnswer2Cont,
                              placeholder: 'Wrong answer 2',
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoTextField(
                              controller: controlers[index].fakeAnswer3Cont,
                              placeholder: 'Wrong answer 3',
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                  child: Text(''),
                                  onPressed: () {
                                    TestsModel test = TestsModel(
                                      id: '',
                                      name: '',
                                      test: List.generate(
                                        widget.lengthOfQuestions,
                                            (index) => Test(
                                          fakeAnswer1: controlers[index].fakeAnswer1Cont?.value.text??'',
                                          fakeAnswer2: controlers[index].fakeAnswer2Cont?.value.text??'',
                                          fakeAnswer3: controlers[index].fakeAnswer3Cont?.value.text??'',
                                          question: controlers[index].questionController?.value.text??'',
                                          trueAnswer: controlers[index].trueAnswerCont?.value.text??'',
                                        ),
                                      ),
                                    );
                                    FirebaseFirestore.instance
                                        .collection('tests')
                                        .add(
                                          test.toJson(),
                                        );
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => MyApp(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// ListView.builder(
// itemBuilder: (context, index) => Container(
// width: MediaQuery.of(context).size.width,
// height: 100,
// child: Column(
// children: [
//
// ],
// ),
// ),
// itemCount: countOfQuestions,
// ),
// InkWell(
// onTap: () {
// setState(() {
// countOfQuestions++;
// });
// },
// child: Container(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height*0.1,
// decoration: BoxDecoration(
// color: Colors.grey[400],
// borderRadius: BorderRadius.circular(15),
// ),
// child: Center(
// child: Text('Add question'),
// ),
// ),
// ),

class ControllersModel {
  TextEditingController? questionController = TextEditingController();
  TextEditingController? trueAnswerCont = TextEditingController();
  TextEditingController? fakeAnswer1Cont = TextEditingController();
  TextEditingController? fakeAnswer2Cont = TextEditingController();
  TextEditingController? fakeAnswer3Cont = TextEditingController();

  ControllersModel({
    this.questionController,
    this.trueAnswerCont,
    this.fakeAnswer1Cont,
    this.fakeAnswer2Cont,
    this.fakeAnswer3Cont,
  });
}

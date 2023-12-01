import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_tut/test_model.dart';

class CreateTestPage extends StatefulWidget {
  const CreateTestPage({super.key});

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  int countOfQuestions = 1;
  List<Test> tests= [];
  TextEditingController questionController = TextEditingController();
  TextEditingController trueAnswerCont = TextEditingController();
  TextEditingController fakeAnswer1Cont = TextEditingController();
  TextEditingController fakeAnswer2Cont = TextEditingController();
  TextEditingController fakeAnswer3Cont = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text(
          'Quiz App',
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
              Container(
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
                        bottom: 8.0,
                        right: 8.0,
                        left: 8.0,
                        top: 16.0
                      ),
                      child: Text(
                        'Test: 1',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CupertinoTextField(
                        controller: questionController,
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
                        controller: trueAnswerCont,
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
                        controller: fakeAnswer1Cont,
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
                        controller: fakeAnswer2Cont,
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
                        controller: fakeAnswer3Cont,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

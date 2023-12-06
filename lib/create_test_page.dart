import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_tut/main.dart';
import 'package:test_app_tut/test_model.dart';
import 'package:uuid/uuid.dart';

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
  List<Test> tests = [];
  Future< List<ControllersModel>>? controlers;

  // TextEditingController questionController = TextEditingController();
  // TextEditingController trueAnswerCont = TextEditingController();
  // TextEditingController fakeAnswer1Cont = TextEditingController();
  // TextEditingController fakeAnswer2Cont = TextEditingController();
  // TextEditingController fakeAnswer3Cont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future initialize() async {
   controlers = Future.value(List.generate(widget.lengthOfQuestions, (index) => ControllersModel()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5CDB95),
      appBar: AppBar(
        title: Text(
          '${widget.nameOfTest}',
          style: TextStyle(
            color: Color(0xffEDF5E1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff05386B),
      ),
      body: FutureBuilder(
        future: controlers,
        builder:(context, snapshot) {
         if(snapshot.hasData){
           return SingleChildScrollView(
             physics: RangeMaintainingScrollPhysics(),
             child: Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height,
               padding: EdgeInsets.all(8),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height * 0.8,
                     child: ListView.builder(
                         physics: PageScrollPhysics(),
                         scrollDirection: Axis.horizontal,
                         itemCount: snapshot.data?.length,
                         itemBuilder: (context, index) {
                           return Container(
                             margin: EdgeInsets.all(8),
                             padding: EdgeInsets.all(8),
                             width: MediaQuery.of(context).size.width - 16,
                             height: MediaQuery.of(context).size.height * 0.5,
                             decoration: BoxDecoration(
                               color: Color(0xff379683),
                               borderRadius: BorderRadius.circular(30),
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(
                                       bottom: 8.0,
                                       right: 8.0,
                                       left: 8.0,
                                       top: 16.0),
                                   child: Text(
                                     'Test: ${index + 1}',
                                     style: TextStyle(
                                         fontSize: 25,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.white),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: CupertinoTextField(
                                     controller:
                                     snapshot.data?[index].questionController,
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
                                     controller: snapshot.data?[index].trueAnswerCont,
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
                                     controller: snapshot.data?[index].fakeAnswer1Cont,
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
                                     controller: snapshot.data?[index].fakeAnswer2Cont,
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
                                     controller: snapshot.data?[index].fakeAnswer3Cont,
                                     placeholder: 'Wrong answer 3',
                                     padding: EdgeInsets.all(16),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(24),
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           );
                         }),
                   ),
                   CupertinoButton(
                     color: Color(0xff05386B),
                     child: Text('Create'),
                     onPressed: () {
                       // Uuid uuid = Uuid();
                       // String ss = uuid.v4();
                       //FirebaseFirestore.instance.collection('test');
                       TestsModel test = TestsModel(
                         //id: '',
                         name: '${widget.nameOfTest}',
                         test: List.generate(
                           widget.lengthOfQuestions,
                               (index) => Test(
                             fakeAnswer1:
                             snapshot.data?[index].fakeAnswer1Cont?.value.text,
                             fakeAnswer2:
                             snapshot.data?[index].fakeAnswer2Cont?.value.text,
                             fakeAnswer3:
                             snapshot.data?[index].fakeAnswer3Cont?.value.text,
                             question:
                             snapshot.data?[index].questionController?.value.text,
                             trueAnswer:
                             snapshot.data?[index].trueAnswerCont?.value.text,
                           ),
                         ),
                       );
                       print(test.test);
                       print(snapshot.data?.length);
                       FirebaseFirestore.instance.collection('tests').add(
                             {
                               'name': test.name,
                               'test': test.test?.map((e) =>e.toJson()).toList()
                             }
                           ).then((value) => print("User Added"))
                           .catchError((error) => print("Failed to add user: $error"));
                       // String id;
                       // FirebaseFirestore.instance
                       //     .collection('tests')
                       //     .get()
                       //     .then((value) {
                       //   for (var m in value.docs) {
                       //     if (m.get('test') == test.test) {
                       //       id = m.id;
                       //     }
                       //   }
                       // });
                       // Navigator.pushAndRemoveUntil(
                       //   context,
                       //   CupertinoPageRoute(
                       //     builder: (context) => MyApp(),
                       //   ),
                       //   (route) => false,
                       // );
                     },
                   ),
                 ],
               ),
             ),
           );
         }
         else{
           return Text(snapshot.error.toString());
         }
        }
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
  late TextEditingController questionController;
  late TextEditingController trueAnswerCont = TextEditingController();
  late TextEditingController fakeAnswer1Cont = TextEditingController();
  late TextEditingController fakeAnswer2Cont = TextEditingController();
  late TextEditingController fakeAnswer3Cont = TextEditingController();

  ControllersModel() {
    questionController = TextEditingController();
    trueAnswerCont = TextEditingController();
    fakeAnswer1Cont = TextEditingController();
    fakeAnswer2Cont = TextEditingController();
    fakeAnswer3Cont = TextEditingController();
  }
}

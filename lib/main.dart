//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/widgets.dart';
import 'package:test_app_tut/test_model.dart';
import 'package:test_app_tut/test_page.dart';

import 'create_test_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference testFire = FirebaseFirestore.instance.collection('tests');
  List<TestsModel> model = [];
  TextEditingController countOfQuestionController = TextEditingController();
  TextEditingController nameOfCourse = TextEditingController();
  Uuid uuid = Uuid();

  //String autoId = uuid.v4().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5CDB95),
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            color: Color(0xffEDF5E1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff05386B),
      ),
      body: FutureBuilder(
        future: testFire.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    //print(snapshot.data!.docs[index].get('id'));
                    print(snapshot.data!.docs[index].get('name'));

                    ///print(snapshot.data!.docs[index].data().toString().contains('questions'));
                    print(ListJsonOfQuestions(
                            snapshot.data!.docs[index].get('test'))
                        .toString());
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TestPage(
                          test: TestsModel(
                            //id: snapshot.data!.docs[index].get('id'),
                            name: snapshot.data!.docs[index].get('name'),
                            test: ListJsonOfQuestions(
                                snapshot.data!.docs[index].get('test')),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Color(0xff379683),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${snapshot.data?.docs[index].get('name')}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.navigate_next,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: snapshot.data?.docs.length,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff379683),
        elevation: 1,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Create a new test'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CupertinoTextField(
                      controller: nameOfCourse,
                      placeholder: 'Write name of course',
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
                      controller: countOfQuestionController,
                      placeholder: 'Write count of questions',
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.black12,
                        child: const Text('Cansel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Color(0xff379683),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateTestPage(
                                lengthOfQuestions: int.parse(
                                    countOfQuestionController.value.text),
                                nameOfTest: nameOfCourse.value.text,
                              ),
                            ),
                          );
                        },
                        child: const Text('Create'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      //drawer: Draw,
    );
  }
}

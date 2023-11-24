import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_tut/test_model.dart';
import 'package:test_app_tut/test_page.dart';

import 'firebase_options.dart';

void main() async {
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
          backgroundColor: Colors.red[50]),
      body: FutureBuilder(
        future: testFire.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10,),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    print(snapshot.data!.docs[index].get('id'));
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
                            id: snapshot.data!.docs[index].get('id'),
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
                      color: Colors.black12,
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
    );
  }
}

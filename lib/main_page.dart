import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//import 'package:flutter/widgets.dart';
import 'package:test_app_tut/test_model.dart';
import 'package:test_app_tut/test_page.dart';

import 'create_test_page.dart';
//import 'firebase_options.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference testFire = FirebaseFirestore.instance.collection('tests');
  List<TestsModel> model = [];
  List<TestsModel> searchModel = [];
  TextEditingController countOfQuestionController = TextEditingController();
  TextEditingController nameOfCourse = TextEditingController();
  TextEditingController aboutCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  Uuid uuid = const Uuid();
  double _height = 0;

  //String autoId = uuid.v4().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5CDB95),
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(
            color: Color(0xffEDF5E1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff05386B),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_height == MediaQuery.of(context).size.height * 0.1) {
                  searchCont.text = '';
                  _height = 0;
                } else {
                  _height = MediaQuery.of(context).size.height * 0.1;
                }
              });
            },
            icon: Icon(
              _height == 0 ? Icons.search : Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: testFire.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff05386B),
                backgroundColor: Color(0xff5CDB95),
              ),
            );
          } else {
            return Container(
              // margin: const EdgeInsets.only(
              //   top: 10,
              // ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  AnimatedContainer(
                    height: _height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff05386B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    duration: Duration(milliseconds: 600),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchModel.clear();
                            for (var b in snapshot.data!.docs) {
                              (b.get('name') as String).contains(value);
                              b.id.contains(value);
                              if ((b.get('name') as String).contains(value) ||
                                  b.id.contains(value)) {
                                print('it has got');
                                searchModel.add(
                                  TestsModel(
                                    about: b.get('about'),
                                    name: b.get('name'),
                                    test: ListJsonOfQuestions(b.get('test')),
                                    id: b.id,
                                  ),
                                );
                              }
                            }
                          });
                          // FirebaseFirestore.instance
                          //     .collection('tests')
                          //     .get()
                          //     .then((value) {
                          //   for (var b in value.docs) {
                          //
                          //     searchModel.add(
                          //       TestsModel(
                          //         about: b.get('about'),
                          //         name: b.get('name'),
                          //         test: b.get('test'),
                          //       ),
                          //     );
                          //   }
                          // });
                        },
                        controller: searchCont,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.search,color: Colors.white),
                          border: InputBorder.none,
                          hintText: "Search...",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              backgroundColor: Color(0xff05386B)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: const Color(0xff05386B),
                              title: Text(
                                  '${_height == 0 ? snapshot.data!.docs[index].get('name') : searchModel[index].name}'),
                              content: Container(
                                child: Text(
                                    '${_height == 0 ? snapshot.data!.docs[index].id : searchModel[index].id} \nThis test has ${_height == 0 ? (ListJsonOfQuestions(snapshot.data!.docs[index].get('test')) as List<Test>).length : searchModel[index].test?.length}\n${_height == 0 ? snapshot.data!.docs[index].get('about') : searchModel[index].about}'),
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                        color: const Color(0xff379683),
                                        child: const Text('Cansel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                        color: const Color(0xff379683),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => TestPage(
                                                test: TestsModel(
                                                  about:_height == 0 ? snapshot
                                                      .data!.docs[index]
                                                      .get('about'):searchModel[index].about,
                                                  name:_height == 0 ? snapshot
                                                      .data!.docs[index]
                                                      .get('name') : searchModel[index].name,
                                                  test:_height == 0 ? ListJsonOfQuestions(
                                                      snapshot.data!.docs[index]
                                                          .get('test')): searchModel[index].test,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Let\'s begin'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: const Color(0xff379683),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${_height == 0 ? snapshot.data?.docs[index].get('name') : searchModel[index].name}',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.navigate_next,
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: _height == 0
                          ? snapshot.data?.docs.length
                          : searchModel.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff379683),
        elevation: 1,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create a new test'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CupertinoTextField(
                      controller: nameOfCourse,
                      placeholder: 'Write name of course',
                      padding: const EdgeInsets.all(16),
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CupertinoTextField(
                      controller: aboutCont,
                      minLines: 2,
                      placeholder: 'Write something about test',
                      padding: const EdgeInsets.all(16),
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
                        color: const Color(0xff379683),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateTestPage(
                                lengthOfQuestions: int.parse(
                                    countOfQuestionController.value.text),
                                nameOfTest: nameOfCourse.value.text,
                                about: aboutCont.value.text,
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

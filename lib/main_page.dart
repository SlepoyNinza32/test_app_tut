import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
=======
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:toast/toast.dart';
>>>>>>> 0b28fe0 (ssggd)

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
<<<<<<< HEAD
=======
  final _advancedDrawerController = AdvancedDrawerController();
>>>>>>> 0b28fe0 (ssggd)
  double _height = 0;

  //String autoId = uuid.v4().toString();

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    ToastContext().init(context);
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xff5CDB95),
        appBar: AppBar(
          title: const Text(
            'Quiz App',
            style: TextStyle(
              color: Color(0xffEDF5E1),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff05386B),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_height == MediaQuery.of(context).size.height * 0.08) {
                    searchCont.text = '';
                    _height = 0;
                  } else {
                    _height = MediaQuery.of(context).size.height * 0.08;
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
                              // if(searchCont.value.text == ''||searchCont.value.text.isEmpty){
                              //   searchModel.clear();
                              //   searchModel.addAll(List.generate(snapshot.data!.docs.length, (index) => TestsModel(
                              //     about: snapshot.data!.docs[index].get('about'),
                              //     name: snapshot.data!.docs[index].get('name'),
                              //     test: ListJsonOfQuestions(snapshot.data!.docs[index].get('test')),
                              //     id: snapshot.data!.docs[index].id,
                              //   ),));
                              // }else{
                              //   searchModel.clear();
                              // }
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
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: const Color(0xff05386B),
                                title: Text(
                                  '${_height == 0 ? snapshot.data!.docs[index].get('name') : searchModel[index].name}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${_height == 0 ? snapshot.data!.docs[index].id : searchModel[index].id}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text:
                                                        '${_height == 0 ? snapshot.data!.docs[index].id : searchModel[index].id}',
                                                  ),
                                                );
                                                Toast.show("Copied",
                                                    duration: Toast.lengthShort,
                                                    gravity: Toast.bottom);
                                              },
                                              icon: Icon(Icons.copy),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '\nThis test has ${_height == 0 ? (ListJsonOfQuestions(snapshot.data!.docs[index].get('test')) as List<Test>).length : searchModel[index].test?.length}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '${_height == 0 ? snapshot.data!.docs[index].get('about') : searchModel[index].about}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
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
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          color: const Color(0xff379683),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) => TestPage(
                                                  test: TestsModel(
                                                    about: _height == 0
                                                        ? snapshot
                                                            .data!.docs[index]
                                                            .get('about')
                                                        : searchModel[index]
                                                            .about,
                                                    name: _height == 0
                                                        ? snapshot
                                                            .data!.docs[index]
                                                            .get('name')
                                                        : searchModel[index]
                                                            .name,
                                                    test: _height == 0
                                                        ? ListJsonOfQuestions(
                                                            snapshot.data!
                                                                .docs[index]
                                                                .get('test'))
                                                        : searchModel[index]
                                                            .test,
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
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
>>>>>>> 0b28fe0 (ssggd)
                      ),
                    ),
                  ],
                ),
<<<<<<< HEAD
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      //drawer: Draw,
    );
  }
=======
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
      ),
    );
  }
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
>>>>>>> 0b28fe0 (ssggd)
}

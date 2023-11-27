import 'package:flutter/material.dart';

class CreateTestPage extends StatefulWidget {
  const CreateTestPage({super.key});

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  int countOfQuestions = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: (context, index) => Container(
              child: Column(
                children: [

                ],
              ),
            ),
            itemCount: countOfQuestions,
          ),
          InkWell(
            onTap: () {
              setState(() {
                countOfQuestions++;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.1,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text('Add question'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

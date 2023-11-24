import 'dart:convert';
import 'dart:js_interop';

class TestsModel {
  String id;
  String name;
  List<Test> test;

  TestsModel({
    required this.id,
    required this.name,
    required this.test,
  });
}

class Test {
  String? question;
  String? trueAnswer;
  String? fakeAnswer3;
  String? fakeAnswer1;
  String? fakeAnswer2;

  Test({
    required this.question,
    required this.fakeAnswer1,
    required this.fakeAnswer2,
    required this.trueAnswer,
    required this.fakeAnswer3,
  });

  Test.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    fakeAnswer1 = json['fakeAnswer1'];
    fakeAnswer2 = json['fakeAnswer2'];
    fakeAnswer3 = json['fakeAnswer3'];
    trueAnswer = json['trueAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['question'] = question;
    data['fakeAnswer1'] = fakeAnswer1;
    data['fakeAnswer2'] = fakeAnswer2;
    data['fakeAnswer3'] = fakeAnswer3;
    data['trueAnswer'] = trueAnswer;
    return data;
  }

  @override
  String toString() {
    return 'Test{\n    question: $question,\n    trueAnswer: $trueAnswer,\n    fakeAnswer3: $fakeAnswer3,\n    fakeAnswer1: $fakeAnswer1,\n    fakeAnswer2: $fakeAnswer2,\n}';
  }
}

ListJsonOfQuestions(dynamic json) {
  return List<Test>.from(json.map((e) => Test.fromJson(e))).toList();
}

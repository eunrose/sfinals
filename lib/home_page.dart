


import 'package:flutter/material.dart';

import 'db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
        ),
      ),
      body: Center(
        child: FutureBuilder <List<Grocery>>(
          future: DatabaseHelper.instance.getGroceries(),
          builder: (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
            if (!snapshot.hasData){
              return Center(child: Text('Loading'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          print(textController.text);
        },
      ),
    );
  }
}
class Grocery {
  final int? id;
  final String name;

  Grocery({this.id, required this.name});

  factory Grocery.fromMap(Map<String, dynamic> json) => new Grocery(
    id: json['id'],
    name: json['name'],
  );
  Map<String, dynamic> toMap(){
    return {
      'id': id,
       'name': name,
    };
  }
}

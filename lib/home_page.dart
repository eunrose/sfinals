
import 'package:flutter/material.dart';
import 'db_helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedId;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
        ),
      ),
      body: Center(
        child: FutureBuilder <List<Todos>>(
          future: DatabaseHelper.instance.getTodos(),
          builder: (BuildContext context, AsyncSnapshot<List<Todos>> snapshot) {
            if (!snapshot.hasData){
              return Center(child: Text('Loading'));
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('No Todos in  List.'))
                :ListView(
            children: snapshot.data!.map((todos) {
              return Center(
                    child: Card(
                      color: selectedId == todos.id
                        ? Colors.deepPurple
                        : Colors.blueAccent,
                      child: ListTile(
                        title:  Text (todos.name),
                        onTap: () {
                          setState(() {
                            if (selectedId == null) {
                              textController.text = todos.name;
                              selectedId = todos.id;
                            } else {
                              textController.text = '';
                              selectedId = null;
                            }
                          });
                        },
                        onLongPress: (){
                          setState(() {
                            DatabaseHelper.instance.remove(todos.id!);
                          });
                        },
                      ),
                    ),
                );
               }).toList(),
          );
         }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon (Icons.save),
        onPressed: ()  async {
          selectedId != null
              ? await DatabaseHelper.instance.update(
            Todos(id: selectedId, name: textController.text,)
          )
           : await DatabaseHelper.instance.add(
            Todos(name: textController.text),
          );
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }
}
class Todos{
  final int? id;
  final String name;

  Todos({this.id, required this.name});

  factory Todos.fromMap(Map<String, dynamic> json) => Todos(
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

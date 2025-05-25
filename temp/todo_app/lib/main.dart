// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent.shade200,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var items = List.empty().cast<Item>();

  MyHomePage() {
    items = [];
    //items.add(Item(title: 'item 1', done: false));
    //items.add(Item(title: 'item 2', done: true));
    //items.add(Item(title: 'item 3', done: false));
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _newTaskController = TextEditingController();

  void _addNewTask() {
    if (_newTaskController.text.isEmpty) return;
    setState(() {
      widget.items.add(Item(title: _newTaskController.text, done: false));
      _newTaskController.clear();
    });
  }

  void _removeTask(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList('data');

    if (data != null) {
      List<Item> result =
          data.map((item) => Item.fromJson(jsonDecode(item))).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  _MyHomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _newTaskController,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          decoration: const InputDecoration(
            labelText: 'New task',
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 112, 89, 241),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Dismissible(
              key: Key(item.title),
              background: Container(
                color: Colors.red.withOpacity(0.5),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _removeTask(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.title} was removed'),
                  ),
                );
              },
              child: ListTile(
                title: Text(item.title),
                trailing: Checkbox(
                  value: item.done,
                  onChanged: (bool? value) {
                    setState(() {
                      item.done = value ?? false;
                    });
                  },
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTask,
        backgroundColor: const Color.fromARGB(255, 112, 89, 241),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
    items.add(Item(title: 'item 1', done: false));
    items.add(Item(title: 'item 2', done: true));
    items.add(Item(title: 'item 3', done: false));
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _newTaskController = TextEditingController();

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                widget.items
                    .add(Item(title: _newTaskController.text, done: false));
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return ListTile(
            title: Text(item.title),
            trailing: Checkbox(
              value: item.done,
              onChanged: (bool? value) {
                setState(() {
                  item.done = value ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

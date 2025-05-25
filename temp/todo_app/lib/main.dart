import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart'; ios

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Text('oi'),
          title: Text('Todo List'),
          actions: <Widget>[
            Icon(Icons.plus_one),
          ],
        ),
        body: Container(
          child: const Center(child: Text('Hello, World!')),
        ));
  }
}

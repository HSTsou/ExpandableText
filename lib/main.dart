import 'package:flutter/material.dart';
import 'package:flutter_expand_text_app/expandable_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page', list: [0, 1, 2, 3, 4, 5, 6, 7]),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.list}) : super(key: key);
  final String title;
  final List<int> list;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _shuffle() {
    setState(() {
      widget.list.shuffle();
      print("Shuffle: ${widget.list}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            ExpandableText(
                'this is a test, this is a test, this is a test, this is a test, this is a test, this is a test, this is a test,')
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  Tile(this.value);

  final int value;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text("${widget.value}", style: TextStyle(fontSize: 18)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moments/api.dart';

class AddMomentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _add(),
          )
        ],
        centerTitle: true,
        title: Text(
          'Add Moment',
          style: TextStyle(letterSpacing: 1),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Editor(),
              ),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  void _add() {
    final moment = Moment(
      note: 'Hello',
      date: DateTime.now(),
    );
    moment.save();
  }
}

class Editor extends StatefulWidget {
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

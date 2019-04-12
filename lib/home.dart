import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_moment_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        centerTitle: true,
        title: Text(
          'Moments',
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: StoryHolder(),
              ),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 32, bottom: 8, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cameraRetro,
            ),
            onPressed: () => _addMoment(context),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.layerGroup,
            ),
            onPressed: () => _analysis(context),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.slidersH,
            ),
            onPressed: () => _settings(context),
          ),
        ],
      ),
    );
  }

  void _addMoment(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddMomentScreen()));
  }

  void _settings(BuildContext context) {}

  void _analysis(BuildContext context) {}
}

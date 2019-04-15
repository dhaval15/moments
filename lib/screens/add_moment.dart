import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:moments/stores/stores.dart';
import 'package:moments/views/views.dart';
import 'package:relay/relay.dart';

class AddMomentScreen extends StatefulWidget {
  static final builder =
      MaterialPageRoute(builder: (context) => AddMomentScreen());

  @override
  AddMomentScreenState createState() => AddMomentScreenState();
}

class AddMomentScreenState extends State<AddMomentScreen> {
  MomentStore store;

  @override
  void initState() {
    super.initState();
    store = Provider.of(context).get(MomentStore);
    store.fetchCurrentMoment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartBar(
        'Add Moment',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              store.addCurrentMoment(() {
                Navigator.of(context).pop();
              });
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _Editor(),
              ),
              _BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MomentStore store = Provider.of(context).get(MomentStore);
    return RelayBuilder<MomentStore, MomentUpdate>(
      store: store,
      observers: [MomentUpdate.CURRENT_MOMENT_FETCHED],
      builder: (context, store) => TextField(
            controller:
                TextEditingController(text: store.currentMoment?.note ?? ''),
            onChanged: (text) {
              store.currentMoment.note = text;
            },
          ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

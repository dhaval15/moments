import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moments/models/models.dart';
import 'package:moments/style/style.dart';
import 'package:moments/views/views.dart';
import 'package:moments/stores/stores.dart';
import 'package:relay/relay.dart';
import 'add_moment.dart';

class HomeScreen extends StatefulWidget {
  static final builder = MaterialPageRoute(builder: (context) => HomeScreen());

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  MomentStore momentStore;

  @override
  void initState() {
    super.initState();
    momentStore = Provider.of(context).get(MomentStore);
    momentStore.fetchMoments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartBar('Moments'),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _SwiperHolder(),
              ),
              _BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwiperHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MomentStore store = Provider.of(context).get(MomentStore);
    return RelayBuilder<MomentStore, MomentUpdate>(
        store: store,
        observers: [MomentUpdate.NEW_ADDED],
        builder: (context, snapshot) {
          if (store.moments != null) {
            final moments = store.moments;
            return Swiper(
              itemCount: moments.length,
              index: 0,
              loop: false,
              itemBuilder: (context, index) => Card(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      width: double.infinity,
                      height: double.infinity,
                      child: _MomentView(
                        moment: moments[index],
                        index: index,
                      ),
                    ),
                  ),
              layout: SwiperLayout.STACK,
              itemWidth: MediaQuery.of(context).size.width - 60,
              itemHeight: MediaQuery.of(context).size.height - 60,
              scrollDirection: Axis.horizontal,
            );
          } else
            return Container();
        });
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MomentStore store = Provider.of(context).get(MomentStore);
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 32, bottom: 8, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cameraRetro,
            ),
            onPressed: () {
              Navigator.of(context).push(AddMomentScreen.builder);
            },
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

  void _settings(BuildContext context) {}

  void _analysis(BuildContext context) {}
}

class _MomentView extends StatelessWidget {
  final Moment moment;
  final int index;

  const _MomentView({this.moment, this.index});

  @override
  Widget build(BuildContext context) {
    MomentStore store = Provider.of(context).get(MomentStore);
    return Column(
      children: <Widget>[
        Text(
          'Moment #$index',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        Text(
          moment.note,
          maxLines: 20,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.fade,
        ),
        SizedBox(height: 16),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton(
                  textColor: primaryColor,
                  child: Text('Delete'),
                  onPressed: () => store.remove(index),
                ),
                Text(moment.formattedDate),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moments/style/style.dart';
import 'package:moments/screens/screens.dart';
import 'package:relay/relay.dart';
import 'package:moments/stores/stores.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      manager: StoreManager(
        stores: {
          MomentStore: () => MomentStore(),
        },
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: canvasColor,
          primaryColor: primaryColor,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          appBarTheme: AppBarTheme(
            color: canvasColor,
            elevation: 0,
            textTheme: TextTheme(
              title: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
              ),
            ),
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
          ),
          cardTheme: CardTheme(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          textTheme: TextTheme(
            button: TextStyle(
              color: primaryColor,
            ),
            body1: TextStyle(
              color: primaryColor,
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
          ),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

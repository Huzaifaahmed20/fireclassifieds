import 'package:fireclassifieds/screens/ad_listing.dart';
import 'package:fireclassifieds/screens/ad_posting.dart';
import 'package:fireclassifieds/screens/login.dart';
import 'package:fireclassifieds/screens/my_ads.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => Login(),
        '/ad-posting': (ctx) => AdPosting(),
        '/ad-listing': (ctx) => AdListing(),
        '/my-ads': (ctx) => MyAds(),
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireclassifieds/screens/ad_listing.dart';
import 'package:fireclassifieds/screens/ad_posting.dart';
import 'package:fireclassifieds/screens/login.dart';
import 'package:fireclassifieds/screens/my_ads.dart';
import 'package:fireclassifieds/services/firebase_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
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
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/ad-listing' : '/login',
      routes: {
        '/login': (ctx) => Login(),
        '/ad-posting': (ctx) => AdPosting(),
        '/ad-listing': (ctx) => AdListing(),
        '/my-ads': (ctx) => MyAds(),
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireclassifieds/models/ad.dart';
import 'package:fireclassifieds/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AdPosting extends StatefulWidget {
  const AdPosting({Key key}) : super(key: key);

  @override
  _AdPostingState createState() => _AdPostingState();
}

class _AdPostingState extends State<AdPosting> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController decpController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: decpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (!isLoading)
              ElevatedButton(
                onPressed: postAd,
                child: Text('Create Ad'),
              ),
            if (isLoading) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  postAd() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseService.createAd(Ad(
        uid: FirebaseAuth.instance.currentUser.uid,
        title: titleController.text,
        descp: decpController.text,
        price: priceController.text,
        phoneNum: phoneController.text,
      ));
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

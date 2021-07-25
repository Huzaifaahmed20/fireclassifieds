import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireclassifieds/models/ad.dart';
import 'package:fireclassifieds/services/firebase_service.dart';
import 'package:flutter/material.dart';

class MyAds extends StatefulWidget {
  const MyAds({Key key}) : super(key: key);

  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Ad>>>(
        future: FirebaseService.getAds(true),
        builder: (childContext, data) =>
            data.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : data.data == null || data.data.isEmpty
                    ? Text("No data here!")
                    : ListView.builder(
                        itemCount: data.data.length,
                        itemBuilder: (ctx, idx) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(data.data[idx]
                                    .data()
                                    .title
                                    .characters
                                    .first
                                    .toUpperCase()),
                              ),
                              title: Text(data.data[idx].data().title),
                              subtitle: Text(data.data[idx].data().descp),
                              trailing: IconButton(
                                onPressed: () => deleteAd(data.data[idx].id),
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  deleteAd(String id) async {
    try {
      await FirebaseService.deleteAd(id);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }
}

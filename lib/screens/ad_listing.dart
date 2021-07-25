import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireclassifieds/models/ad.dart';
import 'package:fireclassifieds/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdListing extends StatefulWidget {
  const AdListing({Key key}) : super(key: key);

  @override
  _AdListingState createState() => _AdListingState();
}

class _AdListingState extends State<AdListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.purple,
              child:
                  Center(child: Text(FirebaseAuth.instance.currentUser.email)),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Ads'),
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).pushNamed('/my-ads');
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (r) => false);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed('/ad-posting');
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text('Ads'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Ad>>>(
        future: FirebaseService.getAds(false),
        builder: (childContext, data) => data.connectionState ==
                ConnectionState.waiting
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
                            onPressed: () {
                              launch("tel:${data.data[idx].data().phoneNum}");
                            },
                            icon: Icon(Icons.phone),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

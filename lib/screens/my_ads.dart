import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, idx) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('AB'),
              ),
              title: Text('Title here'),
              subtitle: Text('description'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

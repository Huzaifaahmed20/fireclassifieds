import 'package:flutter/material.dart';

class AdListing extends StatelessWidget {
  const AdListing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.purple,
              child: Center(child: Text('FireCLassifieds')),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Ads'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/my-ads');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/ad-posting');
        },
      ),
      appBar: AppBar(
        title: Text('Ads'),
        centerTitle: true,
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
                icon: Icon(Icons.phone),
              ),
            ),
          );
        },
      ),
    );
  }
}

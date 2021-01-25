import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('circularData').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text('error occured!'),
              );
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                  );
                },
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.lightBlueAccent,
                      title: Text(snapshot.data.documents[index]['name']),
                      subtitle: Image.network(
                        snapshot.data.documents[index]['url'],
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

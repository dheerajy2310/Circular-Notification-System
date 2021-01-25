import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_splashscreen/simple_splashscreen.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:viit_circular/firstpage.dart';
import 'package:viit_circular/splashScreen.dart';
import 'package:viit_circular/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Simple_splashscreen(
        context: context,
        splashscreenWidget: SplashScreen(),
        timerInSeconds: 3,
        gotoWidget: WelcomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  StreamSubscription<DocumentSnapshot> subscription;
  // final DocumentReference documentReference =
  //     FirebaseFirestore.instance.doc('deviceTokens');
  TextEditingController textEditingController = TextEditingController();
  var counter = 1;
  var linkUrl;
  File image;
  var name;
  List<String> tokenList = [];

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   this.firebaseCloudMessagingListeners(context);
    // });
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    firebaseMessaging.getToken().then((deviceToken) async {
      print('Device token is: $deviceToken');
      await FirebaseFirestore.instance
          .collection('deviceTokens')
          .get()
          .then((value) {
        if (!value.docs
            .any((element) => element.data()['token'] == deviceToken)) {
          FirebaseFirestore.instance
              .collection('deviceTokens')
              .add({"token": deviceToken});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFF66e3c4),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera),
          onPressed: () async {
            var temp = await ImagePicker().getImage(source: ImageSource.camera);
            setState(() {
              image = File(temp.path);
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_copy),
            onPressed: () {
              // Navigator.of(context)
              //     .push(new MaterialPageRoute(builder: (context) {
              //   return FirstPage();
              // }));
            },
          )
        ],
        centerTitle: true,
        title: Text('Sample'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: (image != null)
                ? Column(
                    children: [
                      Image.file(
                        image,
                        height: 300,
                        width: 300,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: textEditingController,
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            name = textEditingController.text;
                          });
                          addImagetoDb();
                        },
                        child: Text('Submit'),
                      )
                    ],
                  )
                : SizedBox(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'add image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _getImage() async {
    var temp = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = File(temp.path);
    });
  }

  void addImagetoDb() async {
    Reference reference =
        FirebaseStorage.instance.ref().child('circulars/image${counter++}');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print("completed");
    });
    var url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      linkUrl = url;
    });
    linktoCloudFireStore();
  }

  void linktoCloudFireStore() async {
    // FirebaseFirestore.instance
    //     .collection('circularData')
    //     .add({"name": name, "url": linkUrl});
  }
}

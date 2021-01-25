import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viit_circular/Faculty/FucultyVerification.dart';
import 'package:viit_circular/Services/circularCount.dart';
import 'package:viit_circular/Students/StudentDashboard.dart';
import 'package:viit_circular/Students/StudentsHomeScreen.dart';
import 'package:viit_circular/common/helpScreen.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var currentBackPressTime;
  var _message;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  AssetImage welcomeAsset = AssetImage('images/welcomeAsset.png');

  @override
  void initState() {
    super.initState();
    _registerOnFirebase();
    getMessage();
    CircularCount.insertcountData();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('received message');
      setState(() => _message = message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
    });
  }

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text(
                'Help',
                style: GoogleFonts.lora(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1E56A0),
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) {
                      return HelpScreen();
                    },
                  ),
                );
              },
            ),
          ],
          backgroundColor: Color(0xFFF2F3F8),
          elevation: 0,
        ),
        key: _scaffoldKey,
        backgroundColor: Color(0xFFF2F3F8),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: welcomeAsset, fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Tap to select your category :',
                      style: GoogleFonts.lora(
                        color: Colors.grey[800],
                        fontSize: 17,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: Color(0xFF1E56A0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          'Faculty',
                          style: GoogleFonts.lora(
                            color: Color(0xFFF2F3F8),
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return FacultyVerification();
                        }));
                      },
                    ),
                    SizedBox(height: 15),
                    RaisedButton(
                      color: Color(0xFF1E56A0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 10),
                        child: Text(
                          'Students',
                          style: GoogleFonts.lora(
                            color: Color(0xFFF2F3F8),
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return StudentDashBoard();
                          // return StudentsHomeScreen();
                        }));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> willPop() {
    final snackBar = SnackBar(
      content: Text(
        'Tap again to Exit.',
        style: GoogleFonts.lora(
          letterSpacing: 1,
          color: Color(0xFFF2F3F8),
        ),
      ),
    );
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return Future.value(true);
    }
  }
}

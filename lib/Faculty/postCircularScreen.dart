import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:viit_circular/Faculty/home.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class PostCircularScreen extends StatefulWidget {
  @override
  _PostCircularScreenState createState() => _PostCircularScreenState();
}

class _PostCircularScreenState extends State<PostCircularScreen> {
  TextEditingController title = TextEditingController();

  final postCircularkey = GlobalKey<FormState>();
  SnackBar postedSnackBar = SnackBar(
    content: Text(
      'Circular Successfully Posted',
      style: GoogleFonts.lora(
        letterSpacing: 1,
        color: Color(0xFFF2F3F8),
      ),
    ),
  );
  List<String> categories = ['Academics', 'Sports', 'Events', 'Other'];
  List<String> branchSelection = [
    'All Branches',
    'CSE',
    'ECE',
    'EEE',
    'MECH',
    'CIVIL',
    'IT',
    'ECM'
  ];
  var linkUrl;
  File image;
  bool loading = false;
  String finalCategory, finalBranch;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0.75,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          actions: [
            FlatButton(
              child: Text(
                'Ciculars',
                style: GoogleFonts.lora(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1E56A0),
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: HomeCircularScreen()),
                );
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFFF2F3F8),
          title: Text(
            'Post Circular',
            style: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Color(0xFFF2F3F8),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: postCircularkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return '* Title required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        title.text = value.trim();
                      });
                    },
                    controller: title,
                    style: GoogleFonts.lora(
                        color: Colors.grey[800],
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500),
                    cursorColor: Colors.grey[600],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      isDense: true,
                      hintText: 'Enter Title',
                      hintStyle: GoogleFonts.lora(
                          color: Colors.grey[800],
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400),
                      labelText: 'Enter title',
                      labelStyle: GoogleFonts.lora(
                          color: Colors.grey[800],
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xFF1E56A0), width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xFF1E56A0), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xFF1E56A0), width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category :',
                          style: GoogleFonts.lora(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        DropdownButton(
                          style: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600),
                          hint: Text(
                            'Tap to Select',
                            style: GoogleFonts.lora(
                                color: Colors.grey[800],
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600),
                          ),
                          value: finalCategory,
                          onChanged: (value) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              finalCategory = value;
                            });
                          },
                          items: categories.map((String val) {
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Branch :',
                          style: GoogleFonts.lora(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        DropdownButton(
                          style: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600),
                          hint: Text(
                            'Tap to Select',
                            style: GoogleFonts.lora(
                                color: Colors.grey[800],
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600),
                          ),
                          value: finalBranch,
                          onChanged: (value) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              finalBranch = value;
                            });
                          },
                          items: branchSelection.map((String val) {
                            return DropdownMenuItem(
                              child: Text(val),
                              value: val,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Select the Circular image :',
                    style: GoogleFonts.lora(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  (image == null)
                      ? SizedBox()
                      : Center(
                          child: Image.file(
                            image,
                            height: 200,
                            width: 200,
                          ),
                        ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        color: Color(0xFF1E56A0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Text(
                            'camera',
                            style: GoogleFonts.lora(
                              color: Color(0xFFF2F3F8),
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var temp = await ImagePicker()
                              .getImage(source: ImageSource.camera);
                          if (temp != null) {
                            setState(() {
                              image = File(temp.path);
                            });
                          } else {
                            Toast.show('Image not Selected', context,
                                gravity: Toast.TOP, duration: 2);
                          }
                        },
                      ),
                      RaisedButton(
                        color: Color(0xFF1E56A0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Text(
                            'Gallery',
                            style: GoogleFonts.lora(
                              color: Color(0xFFF2F3F8),
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var temp = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (temp != null) {
                            setState(() {
                              image = File(temp.path);
                            });
                          } else {
                            Toast.show('Image not Selected', context,
                                gravity: Toast.TOP, duration: 2);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: RaisedButton(
                      color: Color(0xFF1E56A0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          'Post Circular',
                          style: GoogleFonts.lora(
                            color: Color(0xFFF2F3F8),
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (!postCircularkey.currentState.validate()) return;
                        if (!categories.contains(finalCategory)) {
                          Toast.show('Select the Category', context,
                              gravity: Toast.TOP, duration: 2);
                          return;
                        } else if (!branchSelection.contains(finalBranch)) {
                          Toast.show('Select the Branch', context,
                              gravity: Toast.TOP, duration: 2);
                          return;
                        } else {
                          setState(() {
                            loading = true;
                          });
                          //adding image to firebase storage
                          var x = await FirebaseFirestore.instance
                              .collection(finalCategory)
                              .get();
                          var counter = x.size;
                          Reference reference = FirebaseStorage.instance
                              .ref()
                              .child('$finalCategory/image${++counter}');
                          UploadTask uploadTask = reference.putFile(image);
                          TaskSnapshot taskSnapshot =
                              await uploadTask.whenComplete(() {
                            setState(() {
                              loading = false;
                            });
                            _scaffoldKey.currentState
                                .showSnackBar(postedSnackBar);
                            notifyAllDevices();
                          });
                          var url = await taskSnapshot.ref.getDownloadURL();
                          setState(() {
                            linkUrl = url;
                          });
                          //adding data to cloud Firestore
                          FirebaseFirestore.instance
                              .collection(finalCategory)
                              .add({
                            'title': title.text,
                            'imageUrl': linkUrl,
                            'timeStamp':
                                DateTime.now().toUtc().millisecondsSinceEpoch,
                            'branch': finalBranch,
                          });
                          setState(() {
                            image = null;
                            title.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void notifyAllDevices() async {
    var headers = {
      'Authorization':
          '', //Firebase server key need to be added and also firebase google-json file also need to be added.
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body =
        '''{\r\n    "notification": {\r\n        "body": "A new Circular to $finalBranch",\r\n        "title": "You have a new $finalCategory Circular."\r\n    },\r\n    "priority": "high",\r\n    "data": {\r\n        "clickaction": "FLUTTERNOTIFICATIONCLICK",\r\n        "id": "1",\r\n        "status": "done"\r\n    },\r\n    "to": "/topics/all"\r\n}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

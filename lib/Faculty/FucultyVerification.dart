import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:viit_circular/Faculty/postCircularScreen.dart';
import 'package:viit_circular/firstpage.dart';
import 'package:viit_circular/main.dart';

class FacultyVerification extends StatefulWidget {
  @override
  _FacultyVerificationState createState() => _FacultyVerificationState();
}

class _FacultyVerificationState extends State<FacultyVerification> {
  TextEditingController idController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AssetImage faculty = AssetImage('images/facultyLogo.png');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFFF2F3F8),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          // height: MediaQuery.of(context).size.height-AppBar().preferredSize.height-25,
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
                  image: DecorationImage(image: faculty, fit: BoxFit.fitWidth),
                ),
              ),
              Text(
                'Enter the provided Id to post Circulars',
                style: GoogleFonts.lora(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return '* Id required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        idController.text = value.trim();
                      });
                    },
                    controller: idController,
                    style: GoogleFonts.lora(
                        color: Colors.grey[800],
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500),
                    cursorColor: Colors.grey[600],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      isDense: true,
                      hintText: 'Enter ID',
                      hintStyle: GoogleFonts.lora(
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
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(
                color: Color(0xFF1E56A0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    'Submit',
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
                  if (!_key.currentState.validate())
                    return;
                  else if (idController.text == 'VIIT') {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return PostCircularScreen();
                    }));
                  } else {
                    Toast.show('Enter correct ID', context,
                        gravity: Toast.TOP, duration: 2);
                  }
                  idController.clear();
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

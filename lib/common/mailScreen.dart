import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MailToScreen extends StatefulWidget {
  @override
  _MailToScreenState createState() => _MailToScreenState();
}

class _MailToScreenState extends State<MailToScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'Contact Us',
            style: GoogleFonts.lora(
                fontSize: 24,
                fontWeight: FontWeight.w500),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return '* UserName required.';
                          if (value.length < 5)
                            return '* Username must exceed 4 characters';
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            username.text = value.trim();
                          });
                        },
                        controller: username,
                        style: GoogleFonts.lora(
                            color: Colors.grey[800],
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.grey[600],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          isDense: true,
                          labelText: 'Enter your name',
                          hintText: 'Enter your name',
                          labelStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          hintStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        // validator: (value) {
                        //   if (value.isEmpty) return '* UserName required.';
                        //   if (value.length < 5)
                        //     return '* Username must exceed 4 characters';
                        //   return null;
                        // },
                        onSaved: (value) {
                          setState(() {
                            subject.text = value.trim();
                          });
                        },
                        controller: subject,
                        style: GoogleFonts.lora(
                            color: Colors.grey[800],
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.grey[600],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          isDense: true,
                          hintText: 'Enter Subject',
                          labelText: 'Enter Subject',
                          labelStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          hintStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.start,
                        maxLines: 8,
                        validator: (value) {
                          if (value.isEmpty) return '* query required.';
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            body.text = value.trim();
                          });
                        },
                        controller: body,
                        style: GoogleFonts.lora(
                            color: Colors.grey[800],
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.grey[600],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          isDense: true,
                          hintText: 'Enter Your Query',
                          labelText: 'Enter your Query',
                          labelStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          hintStyle: GoogleFonts.lora(
                              color: Colors.grey[800],
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Color(0xFF1E56A0), width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xFF1E56A0),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (!_key.currentState.validate()) {
                        return;
                      }
                      final url = Uri.encodeFull(
                          'mailto:dheerajy2310@gmail.com?subject=${subject.text}&body=${body.text}');
                      if (await canLaunch(url)) {
                        launch(url);
                      } else {
                        Toast.show(
                            'Mail Cannot be send from this devices', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      username.clear();
                      subject.clear();
                      body.clear();
                    },
                    child: Text(
                      'Send Query',
                      style: GoogleFonts.lora(
                        color: Color(0xFFF2F3F8),
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

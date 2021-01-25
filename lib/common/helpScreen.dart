import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viit_circular/common/mailScreen.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  AssetImage helpasset = AssetImage('images/helpassist.png');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'Help',
            style: GoogleFonts.lora(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: helpasset,
                  fit: BoxFit.contain,
                )),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  'Thankyou for using our Application.\n\nIt looks like you are facing problems with our application. We are here to help you, so please get in touch with us.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(fontSize: 17, wordSpacing: 1)),
            ),
            SizedBox(height: 15),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xFF1E56A0),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      return MailToScreen();
                    },
                  ));
                },
                child: Text(
                  'Contact Us',
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
    );
  }
}

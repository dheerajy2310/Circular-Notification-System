import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.lora(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

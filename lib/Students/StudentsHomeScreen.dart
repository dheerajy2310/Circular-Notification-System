import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:viit_circular/Students/StudentDashboard.dart';
import 'package:viit_circular/common/Culturals.dart';
import 'package:viit_circular/common/Education.dart';
import 'package:viit_circular/common/Others.dart';
import 'package:viit_circular/common/ProfileScreen.dart';
import 'package:viit_circular/common/SportsCirculars.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StudentsHomeScreen extends StatefulWidget {
  @override
  _StudentsHomeScreenState createState() => _StudentsHomeScreenState();
}

class _StudentsHomeScreenState extends State<StudentsHomeScreen> {
  var index = 0;
  int _selectedIndex = 0;
  Widget tabBody = StudentDashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                gap: 10,
                activeColor: Colors.white,
                iconSize: 22,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Color(0xFF1E56A0),
                tabs: [
                  GButton(
                    icon: Icons.dashboard_outlined,
                    text: 'Dashboard',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.15),
                  ),
                  GButton(
                    icon: Icons.person_outline_outlined,
                    text: 'Profile',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.15),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if (index == 0) {
                    setState(() {
                      tabBody = StudentDashBoard();
                    });
                  } else {
                    setState(() {
                      tabBody = ProfileScreen();
                    });
                  }
                }),
          ),
        ),
      ),
      body: tabBody,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:viit_circular/common/Culturals.dart';
import 'package:viit_circular/common/Education.dart';
import 'package:viit_circular/common/Others.dart';
import 'package:viit_circular/common/SportsCirculars.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeCircularScreen extends StatefulWidget {
  @override
  _HomeCircularScreenState createState() => _HomeCircularScreenState();
}

class _HomeCircularScreenState extends State<HomeCircularScreen> {
  var index = 0;
  int _selectedIndex = 0;
  Widget tabBody=EducationCirculars(faculty: true);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Academics',
      style: optionStyle,
    ),
    Text(
      'Index 1: Sports',
      style: optionStyle,
    ),
    Text(
      'Index 2: Culturals',
      style: optionStyle,
    ),
    Text(
      'Index 3: Others',
      style: optionStyle,
    ),
  ];

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
                gap: 10,
                activeColor: Colors.white,
                iconSize: 22,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Color(0xFF1E56A0),
                tabs: [
                  GButton(
                    icon: Icons.book_outlined,
                    text: 'Academics',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15),
                  ),
                  GButton(
                    icon: Icons.sports_basketball_outlined,
                    text: 'Sports',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15),
                  ),
                  GButton(
                    icon: FlutterIcons.event_available_mdi,
                    text: 'Culturals',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15),
                  ),
                  GButton(
                    icon: FlutterIcons.new_releases_mdi,
                    text: 'Others',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
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
                      tabBody = EducationCirculars(faculty:true);
                    });
                  } else if (index == 1) {
                    setState(() {
                      tabBody = SportsCirculars(faculty:true);
                    });
                  } else if (index == 2) {
                    setState(() {
                      tabBody = CulturalsCirculars(faculty:true);
                    });
                  } else {
                    setState(() {
                      tabBody = OthersCirculars(faculty:true);
                    });
                  }
                }),
          ),
        ),
      ),
      body: tabBody,
    );
  }

  Widget Screens(int i) {
    var screens = [
      EducationCirculars(),
      SportsCirculars(),
      CulturalsCirculars(),
      OthersCirculars(),
    ];
    return screens[i];
  }

  List<PersistentBottomNavBarItem> NavigationItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book_outlined),
        title: "Education",
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.sports_bar_outlined),
        title: ("Sports"),
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FlutterIcons.event_available_mdi),
        title: ("Events"),
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FlutterIcons.rest_ant),
        title: ("Others"),
        activeColor: Colors.indigo,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  _handleIndexChanged(int p1) {
    setState(() {
      index = p1;
    });
  }
}

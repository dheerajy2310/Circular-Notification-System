import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viit_circular/common/Culturals.dart';
import 'package:viit_circular/common/Education.dart';
import 'package:viit_circular/common/Others.dart';
import 'package:viit_circular/common/SportsCirculars.dart';
import 'package:page_transition/page_transition.dart';

class StudentDashBoard extends StatefulWidget {
  @override
  _StudentDashBoardState createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  List<String> categories = ["Academics", "Sports", "Events", "Other"];
  List<String> keywords = ["Academics", "Sports", "Events", "Other"];
  List<Widget> circularScreens = [
    EducationCirculars(faculty: false),
    SportsCirculars(faculty: false),
    CulturalsCirculars(faculty: false),
    OthersCirculars(faculty: false)
  ];

  @override
  Widget build(BuildContext context) {
    String greetingText = greetingmessage();
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
          'DashBoard',
          style: GoogleFonts.lora(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingText,
                style: GoogleFonts.lora(fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
              Text(
                'Tap to select the type of Circular you want to see',
                style: GoogleFonts.lora(
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              Container(
                // padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Color(0xFFD6E4F0).withOpacity(0.3),
                      onTap: () {
                        // Navigator.of(context)
                        //     .push(new MaterialPageRoute(builder: (context) {
                        //   return circularScreens[index];
                        // }));
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: circularScreens[index]),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xFF3A5160).withOpacity(0.2),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              categories[index],
                              style: GoogleFonts.lora(
                                fontSize: 17,
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(keywords[index])
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.documents.length.toString(),
                                    style: GoogleFonts.lora(
                                      fontSize: 30,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Icon(Icons.error_outline),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String greetingmessage() {
    var datetime = DateTime.now().hour;
    if (datetime < 12)
      return 'Good Morning ';
    else if (datetime < 17)
      return 'Good Afternoon ';
    else
      return 'Good Evening ';
  }
}

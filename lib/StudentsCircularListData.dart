import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'imageView.dart';

class StudentsCircularList extends StatefulWidget {
  @override
  _StudentsCircularListState createState() => _StudentsCircularListState();
}

class _StudentsCircularListState extends State<StudentsCircularList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        centerTitle: true,
        title: Text(
          'Circulars',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('circularData')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text('error occured!'),
                );
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return Imagepage(
                            imageurl: snapshot.data.documents[index]['url'],
                            title: snapshot.data.documents[index]['name'].toString(),
                          );
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFF3A5160).withOpacity(0.2),
                                  offset: Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(75))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              height: 160,
                              width: MediaQuery.of(context).size.width * 0.4,
                              imageUrl: snapshot.data.documents[index]['url'],
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Center(
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                            Text(
                              snapshot.data.documents[index]['name'].toString(),
                              style: GoogleFonts.lora(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey[800],
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viit_circular/common/CircularPage.dart';
import 'package:viit_circular/imageView.dart';

class CulturalsCirculars extends StatefulWidget {
  final faculty;

  const CulturalsCirculars({Key key, this.faculty}) : super(key: key);
  @override
  _CulturalsCircularsState createState() => _CulturalsCircularsState();
}

class _CulturalsCircularsState extends State<CulturalsCirculars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        centerTitle: true,
        title: Text(
          'Event Circulars',
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
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 10, bottom: 90, right: 10, left: 10),
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Events')
                .orderBy('timeStamp')
                .limitToLast(20)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(),
                );
              var len = snapshot.data.documents.length;
              if (snapshot.hasError)
                return Center(
                  child: Text('error occured!'),
                );
              if (snapshot.hasData) {
                return (len != 0)
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CircularPage(
                                      data: snapshot
                                          .data.documents[len - index - 1],
                                    )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Color(0xFF3A5160).withOpacity(0.2),
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      (widget.faculty)
                                          ? FlatButton(
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.red[600],
                                              ),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction((Transaction
                                                        myTransaction) async {
                                                  myTransaction.delete(snapshot
                                                      .data
                                                      .documents[
                                                          len - index - 1]
                                                      .reference);
                                                });
                                              },
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedNetworkImage(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: snapshot
                                              .data.documents[len - index - 1]
                                          ['imageUrl'],
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100.0),
                        child: Center(
                          child: Text(
                            'No Circulars found yet!',
                            style: GoogleFonts.lora(
                                color: Colors.blueGrey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
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

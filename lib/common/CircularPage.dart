import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:viit_circular/imagePage.dart';

class CircularPage extends StatefulWidget {
  final data;
  const CircularPage({Key key, this.data}) : super(key: key);
  @override
  _CircularPageState createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        centerTitle: true,
        title: Text(
          'Circular',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ImagePage(
                        title: widget.data['title'],
                        url: widget.data['imageUrl'],
                      )),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.3,
                  imageUrl: widget.data['imageUrl'],
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
            ),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                  text: '➤ Title : ',
                  style: GoogleFonts.lora(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                    letterSpacing: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.data['title'],
                      style: GoogleFonts.lora(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[800],
                        letterSpacing: 1.5,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                  text: '➤ Department : ',
                  style: GoogleFonts.lora(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                    letterSpacing: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.data['branch'],
                      style: GoogleFonts.lora(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[800],
                        letterSpacing: 1.5,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 15),
            RichText(
              text: TextSpan(
                  text: '➤ Uploaded at : ',
                  style: GoogleFonts.lora(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[800],
                    letterSpacing: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: DateTime.fromMillisecondsSinceEpoch(
                              widget.data['timeStamp'])
                          .toString(),
                      style: GoogleFonts.lora(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey[800],
                        letterSpacing: 1.5,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

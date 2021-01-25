import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class Imagepage extends StatefulWidget {
  var imageurl;
  var title;

  Imagepage({this.imageurl, this.title});

  @override
  _ImagepageState createState() => _ImagepageState();
}

class _ImagepageState extends State<Imagepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[800],
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Color(0xFFF2F3F8),
      body: Container(
        child: Center(
          child: CachedNetworkImage(
            height: 225,
            width: MediaQuery.of(context).size.width * 0.4,
            imageUrl: widget.imageurl,
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
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImagePage extends StatefulWidget {
  final title;
  final url;
  ImagePage({Key key, this.title, this.url}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F3F8),
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
      body: PinchZoom(
        image: CachedNetworkImage(
          imageUrl: widget.url,
        ),
        zoomedBackgroundColor: Colors.black.withOpacity(0.5),
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 5,
      ),
    );
  }
}

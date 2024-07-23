import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullscreenImage1 extends StatelessWidget {
  final String imageUrl;

  FullscreenImage1({required this.imageUrl,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: InteractiveViewer(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}

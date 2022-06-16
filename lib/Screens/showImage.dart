import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  String url;
  ShowImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: (url != "null")
        ?Center(child: Image.network(url))
        :Center(child: Text("Image Unavailable !",style: TextStyle(color: Colors.white),)),
    );
  }
}
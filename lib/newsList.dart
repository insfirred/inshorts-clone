import 'dart:ui';

import 'package:flutter/material.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  String Heading = "Indian street food restaurant Chai Pani named best in US";
  String description = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (context, index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3,
              // color: Colors.amber,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/img.png')
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                // color: Colors.red[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Heading ,style: TextStyle(fontSize: 25),textAlign: TextAlign.justify),
                    SizedBox(height: 10,),
                    Text(description ,style: TextStyle(color: Colors.grey[600],fontSize: 17),textAlign: TextAlign.justify,),
                    SizedBox(height: 15),
                    Text('swipe left for more info.' ,style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.justify,),

                  ],
                ),
              )
            )
          ],
        );
      });
  }
}
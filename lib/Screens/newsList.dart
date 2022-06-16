import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './showImage.dart';
import '../animation/animation.dart';

class NewsList extends StatelessWidget {
  var jsonData;
  NewsList(this.jsonData);

  final DateTime now = DateTime.now();
  final timeFormatter = DateFormat('Hms');
  final dateFormatter = DateFormat('MMMMd');

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: jsonData["articles"].length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowImage("${jsonData["articles"][index]["urlToImage"]}"))),
                onTap: () =>
                  Navigator.push(context, SizeTransition3(ShowImage("${jsonData["articles"][index]["urlToImage"]}"))),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: (jsonData["articles"][index]["urlToImage"] != null)
                        ? Image.network(
                            "${jsonData["articles"][index]["urlToImage"]}",
                            fit: BoxFit.fill,
                          )
                        : const Image(image: AssetImage('assets/images/unavailable-image.jpg'))
                ),
              ),
              Expanded(
                child: Container(
                padding: EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jsonData["articles"][index]["title"],
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.justify),
                    const SizedBox(height: 10),
                    Text(
                      (jsonData["articles"][index]["content"] != null)
                          ? jsonData["articles"][index]["content"]
                          : "",
                      style: TextStyle(color: Colors.grey[600], fontSize: 17),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Published at: ${dateFormatter.format(DateTime.parse(jsonData["articles"][index]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(jsonData["articles"][index]["publishedAt"]))}',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'swipe left for more info.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ))
            ],
          );
        });
  }
}
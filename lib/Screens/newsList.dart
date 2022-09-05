import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:vibration/vibration.dart';
import 'package:shake/shake.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../HomeScreen.dart';
import './showImage.dart';
import '../animation/animation.dart';
import '../database/database.dart';

class NewsList extends StatefulWidget {
  var jsonData;
  NewsList(this.jsonData);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin<NewsList> {
  final DateTime now = DateTime.now();

  final timeFormatter = DateFormat('Hms');

  final dateFormatter = DateFormat('MMMMd');

  bool get wantKeepAlive => true;

  void addedToBookmarks() {
    // Vibration.vibrate(duration: 100);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to Bookmarks!'),
        duration: Duration(milliseconds: 800),
      )
    );
  }

  Widget NewsImage(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            SizeTransition3(ShowImage(
                "${widget.jsonData["articles"][index]["urlToImage"]}")));
      },
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: (widget.jsonData["articles"][index]["urlToImage"] != null)
              // ? Image.network(
              //     "${widget.jsonData["articles"][index]["urlToImage"]}",
              //     fit: BoxFit.fill,
              //   )
                ? CachedNetworkImage(
                    imageUrl: "${widget.jsonData["articles"][index]["urlToImage"]}",
                    errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : const Image(
                  image: AssetImage('assets/images/unavailable-image.jpg'))),
    );
  }

  Widget NewsDetails(index) {
    
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async{
              // Tapping on title
              int i = await DatabaseClass.instance.create(
                {
                  ColumnFields.title: widget.jsonData["articles"][index]["title"],
                  ColumnFields.description: (widget.jsonData["articles"][index]["content"] != null) ?widget.jsonData["articles"][index]["content"] :"",
                  ColumnFields.date: 'Published at: ${dateFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}',
                  ColumnFields.url: (widget.jsonData["articles"][index]["url"] != null) ?widget.jsonData["articles"][index]["url"] :""
                }
              );
              addedToBookmarks();
            },
            child: Container(
              child: Text(widget.jsonData["articles"][index]["title"],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
            ),
          ),
          SizedBox(height: 10),

          GestureDetector(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.jsonData["articles"][index]["content"] != null)
                        ? widget.jsonData["articles"][index]["content"]
                        : "",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Published at: ${dateFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}',
                    style: TextStyle(color: Colors.grey, fontSize: 16,fontStyle: FontStyle.italic),
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
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        addedToBookmarks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
        onPageChanged: (page) {
          HomeScreen.newsIndex = page;
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.jsonData["articles"].length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NewsImage(index),
              NewsDetails(index),
            ],
          );
        });
  }
}

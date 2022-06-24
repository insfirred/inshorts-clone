import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';

import '../HomeScreen.dart';
import './showImage.dart';
import '../animation/animation.dart';

class NewsList extends StatefulWidget {
  var jsonData;
  NewsList(this.jsonData);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> with AutomaticKeepAliveClientMixin<NewsList> {
  final DateTime now = DateTime.now();

  final timeFormatter = DateFormat('Hms');

  final dateFormatter = DateFormat('MMMMd');

  // int newsIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PageController controller = PageController(initialPage: 0);
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      onPageChanged: (page){
        HomeScreen.newsIndex = page;
      },
        scrollDirection: Axis.vertical,
        itemCount: widget.jsonData["articles"].length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, SizeTransition3(ShowImage("${widget.jsonData["articles"][index]["urlToImage"]}")));
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: (   widget.jsonData["articles"][index]["urlToImage"] != null    )
                        ? Image.network(
                            "${widget.jsonData["articles"][index]["urlToImage"]}",
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
                    GestureDetector(
                      onLongPress: (){
                        Vibration.vibrate(duration: 100);
                        Fluttertoast.showToast(
                          msg: "Added to Bookmarks",
                          backgroundColor: Color.fromARGB(255, 65, 63, 63)
                        );
                      },
                      child: Text(
                        widget.jsonData["articles"][index]["title"],
                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify),
                    ),
                    const SizedBox(height: 10),
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
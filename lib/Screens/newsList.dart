import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:shake/shake.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

import '../HomeScreen.dart';
import './showImage.dart';
import '../animation/animation.dart';
import '../database/database.dart';
import '../animation/bouncing_button.dart';

class NewsList extends StatefulWidget {
  var jsonData;
  NewsList(this.jsonData);

  shareNews(index) async {
    await Share.share(
        'Hey! Check out this awesome article ${jsonData["articles"][index]["url"]}',
        subject: 'Look what I made!');
  }

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin<NewsList> ,TickerProviderStateMixin {
  final DateTime now = DateTime.now();

  final timeFormatter = DateFormat('jm');

  final dateFormatter = DateFormat('MMMMd');

  bool get wantKeepAlive => true;

  void addedToBookmarks() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Added to Bookmarks!'),
      duration: Duration(milliseconds: 800),
    ));
  }

  Widget NewsImageHolder(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            SizeTransition3(ShowImage(
                "${widget.jsonData["articles"][index]["urlToImage"]}")));
      },
      child: SizedBox(
          height: (MediaQuery.of(context).size.height / 3) - 20,
          child: (widget.jsonData["articles"][index]["urlToImage"] != null)
              ? CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl:
                      "${widget.jsonData["articles"][index]["urlToImage"]}",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              // ? FadeInImage.assetNetwork(
              //   fit: BoxFit.fill,
              //   placeholder: 'assets/gifs/skeleton_image.gif',
              //   image: widget.jsonData["articles"][index]["urlToImage"]
              //   )

              // ? Image.network(widget.jsonData["articles"][index]["urlToImage"],fit: BoxFit.fill)
              : const Image(
                  image: AssetImage('assets/images/unavailable-image.jpg'),
                  fit: BoxFit.fill,
                )),
    );
  }

  List<Map<String, dynamic>> list = [];

  Widget NewsDetails(index) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Expanded(
        child: Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              // Tapping on title

              list = await DatabaseClass.instance.read();

              bool isPresent = false;
              for (int i = 0; i < list.length; i++) {
                if (list[i]["url"] ==
                    widget.jsonData["articles"][index]["url"]) {
                  isPresent = true;
                }
              }

              if (isPresent) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(milliseconds: 800),
                    content: Text("Already present in Bookmarks")));
              } else {
                int i = await DatabaseClass.instance.create({
                  ColumnFields.title: widget.jsonData["articles"][index]
                      ["title"],
                  ColumnFields.description:
                      (widget.jsonData["articles"][index]["content"] != null)
                          ? widget.jsonData["articles"][index]["content"]
                          : "",
                  ColumnFields.date:
                      '${dateFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}',
                  ColumnFields.url:
                      (widget.jsonData["articles"][index]["url"] != null)
                          ? widget.jsonData["articles"][index]["url"]
                          : ""
                });
                addedToBookmarks();
              }
              setState(() {});
            },
            child: Text(
              widget.jsonData["articles"][index]["title"],
              style: _textTheme.headline5,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (widget.jsonData["articles"][index]["content"] != null)
                    ? widget.jsonData["articles"][index]["content"].substring( 0 , widget.jsonData["articles"][index]["content"].length - 14)
                    : "",
                style: _textTheme.subtitle1,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Text(
                'Published at: ${dateFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(widget.jsonData["articles"][index]["publishedAt"]))}',
                style: _textTheme.subtitle2,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ],
      ),
    ));
  }

  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool isPresent = false;
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height - 200,
            child: PageView.builder(
                onPageChanged: (page) {
                  HomeScreen.newsIndex = page;
                  setState(() {});
                },
                scrollDirection: Axis.vertical,
                itemCount: widget.jsonData["articles"].length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NewsImageHolder(index),
                      NewsDetails(index),
                    ],
                  );
                }),
          ),
        ),


        Container(
          decoration: const BoxDecoration(
            // color: Colors.pink
            gradient: LinearGradient(colors: [
              Color.fromRGBO(242, 146, 237, 1),
              Color.fromRGBO(243, 99, 100, 1)
            ]),
          ),
          height: MediaQuery.of(context).size.height/12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    widget.shareNews(HomeScreen.newsIndex);
                  },
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () async {
                    list = await DatabaseClass.instance.read();

                    // bool isPresent = false;
                    isPresent = false;
                    for (int i = 0; i < list.length; i++) {
                      if (list[i]["url"] ==
                          widget.jsonData["articles"][HomeScreen.newsIndex]
                              ["url"]) {
                        isPresent = true;
                      }
                    }

                    if (isPresent) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(milliseconds: 800),
                          content: Text("Already present in Bookmarks")));
                    } else {
                      int i = await DatabaseClass.instance.create({
                        ColumnFields.title: widget.jsonData["articles"]
                            [HomeScreen.newsIndex]["title"],
                        ColumnFields.description: (widget.jsonData["articles"]
                                    [HomeScreen.newsIndex]["content"] !=
                                null)
                            ? widget.jsonData["articles"][HomeScreen.newsIndex]
                                ["content"]
                            : "",
                        ColumnFields.date:
                            '${dateFormatter.format(DateTime.parse(widget.jsonData["articles"][HomeScreen.newsIndex]["publishedAt"]))}  ${timeFormatter.format(DateTime.parse(widget.jsonData["articles"][HomeScreen.newsIndex]["publishedAt"]))}',
                        ColumnFields.url: (widget.jsonData["articles"]
                                    [HomeScreen.newsIndex]["url"] !=
                                null)
                            ? widget.jsonData["articles"][HomeScreen.newsIndex]
                                ["url"]
                            : ""
                      });
                      addedToBookmarks();
                    }
                    setState(() {
                      
                    });
                  },
                  icon: FaIcon(FontAwesomeIcons.bookmark),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

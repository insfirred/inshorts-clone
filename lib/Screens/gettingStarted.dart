import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  final _controller = PageController();

  @override
  bool isLastPage = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            isLastPage = (value == 3);
          });
        },
        controller: _controller,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/gifs/swipe_up.gif'),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Swipe Up',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Simply swipe up and know about the world',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/gifs/tap.gif'),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Tap on Headlines',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      'Save your favourite news article by tapping on their headline',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/gifs/swipe_right.gif'),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Swipe Right',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      'All your saved bookmarks will appear on the left',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/gifs/swipe_left.gif'),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Swipe Left',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To see the full article, swipe left',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(25, 10, 25, 12),
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 73, 71, 80)),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())
                  );
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(),
                  //     ));
                },
                child: Text('Take me to the App'),
              ),
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 73, 71, 80)),
                      onPressed: () => _controller.animateToPage(3,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.linear),
                      child: Text("Skip")),
                  SmoothPageIndicator(
                    onDotClicked: (i) {
                      _controller.animateToPage(i,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.linear);
                      ;
                    },
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      activeDotColor: Colors.grey.shade700,
                      spacing: 10,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 73, 71, 80)),
                      onPressed: () => _controller.nextPage(
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeIn),
                      child: FaIcon(FontAwesomeIcons.chevronRight))
                ],
              ),
            ),
    );
  }
}

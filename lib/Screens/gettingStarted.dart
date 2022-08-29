import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {

  final _controller = PageController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          Center(child: Text('Hello 1')),
          Center(child: Text('Hello 2')),
          Center(child: Text('Hello 3')),
          Center(
            child: ElevatedButton(
              child: Text('Take me to the app'),
              onPressed: (){
                Navigator.pushNamed(context, '/');
              },
            )
          ),
        ],
      ),
      bottomSheet: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => _controller.animateToPage(3, duration: Duration(milliseconds: 150), curve: Curves.linear),
              child: Text("Skip")
            ),
            SmoothPageIndicator(
              onDotClicked: (i){
                _controller.animateToPage(i, duration: Duration(milliseconds: 150), curve: Curves.linear);
;              },
              controller: _controller,
              count: 4,
              effect: WormEffect(
                activeDotColor: Colors.grey.shade700,
                spacing: 10,
              ),
            ),
            ElevatedButton(
              onPressed: () => _controller.nextPage(duration: Duration(milliseconds: 150), curve: Curves.easeIn),
              child: FaIcon(FontAwesomeIcons.arrowRight)
            )
          ],
        ),
      ),
    );
  }
}
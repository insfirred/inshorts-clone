import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with TickerProviderStateMixin {
  final _controller = PageController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animation =
        CurvedAnimation(curve: Curves.linear, parent: _animationController);
    _animationController.repeat();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget PageOne() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/businessman.jpeg'),
              fit: BoxFit.fill)),
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      width: 118,
                      height: 56,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(242, 146, 237, 1),
                            Color.fromRGBO(243, 99, 100, 1)
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          _controller.animateToPage(1,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: Center(
                            child: Text('Next',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    Color.fromRGBO(242, 146, 237, 1),
                    Color.fromRGBO(243, 99, 100, 1)
                  ]).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text('Swipe Right', style: TextStyle(fontSize: 40)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('To see all your bookmarks',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LargeDot(),
                  SmallDot(),
                  SmallDot(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget PageTwo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/doctor.jpeg'),
              fit: BoxFit.fill)),
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _controller.animateToPage(0,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.white,)),
                    Container(
                      width: 118,
                      height: 56,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(242, 146, 237, 1),
                            Color.fromRGBO(243, 99, 100, 1)
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          _controller.animateToPage(2,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        child: Center(
                            child: Text('Next',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    Color.fromRGBO(242, 146, 237, 1),
                    Color.fromRGBO(243, 99, 100, 1)
                  ]).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text('Swipe Up', style: TextStyle(fontSize: 40)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('To know more about the world',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallDot(),
                  LargeDot(),
                  SmallDot(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget PageThree() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ronaldo.jpeg'),
              fit: BoxFit.fill)),
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _controller.animateToPage(1,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.linear);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.white,)),
                    Container(
                      width: 118,
                      height: 56,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(242, 146, 237, 1),
                            Color.fromRGBO(243, 99, 100, 1)
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Center(
                            child: Text('Finish',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    Color.fromRGBO(242, 146, 237, 1),
                    Color.fromRGBO(243, 99, 100, 1)
                  ]).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text('Tap Headlines', style: TextStyle(fontSize: 40)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('To open & read the full article',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallDot(),
                  SmallDot(),
                  LargeDot(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget SmallDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 24,
              height: 8,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(242, 146, 237, 1),
                    Color.fromRGBO(243, 99, 100, 1)
                  ]),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ],
        ),
      ),
    );
  }

  Widget LargeDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 8,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(242, 146, 237, 1),
                    Color.fromRGBO(243, 99, 100, 1)
                  ]),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            controller: _controller,
            children: [PageOne(), PageTwo(), PageThree()]));
  }
}

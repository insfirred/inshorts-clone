import 'package:flutter/material.dart';
import './onboardingScreen.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted>
    with TickerProviderStateMixin {
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

  @override
  bool isLastPage = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            isLastPage = (value == 3);
          });
        },
        controller: _controller,
        children: [
          Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _animation,
                      child: Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(242, 146, 237, 1),
                              Color.fromRGBO(243, 99, 100, 1)
                            ]),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(
                          'N',
                          style: TextStyle(fontFamily: 'Abril_Fatface',fontSize: 64, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoarding()));
                        },
                        child: Center(
                            child: Text('Get Started',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          // SWIPE UP
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('assets/images/doctor.jpeg'),
          //           fit: BoxFit.fill)),
          //   padding: EdgeInsets.symmetric(horizontal: 32),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 250),
          //         child: ShaderMask(
          //           blendMode: BlendMode.srcIn,
          //           shaderCallback: (bounds) => LinearGradient(colors: [
          //             Color.fromRGBO(242, 146, 237, 1),
          //             Color.fromRGBO(243, 99, 100, 1)
          //           ]).createShader(
          //             Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          //           ),
          //           child: Text('Swipe Up', style: TextStyle(fontSize: 40)),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Text('To know more about the world',
          //           style: TextStyle(color: Colors.white70, fontSize: 20),
          //           textAlign: TextAlign.center),
          //     ],
          //   ),
          // ),

          // // Tap Headlines
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('assets/images/ronaldo.jpeg'),
          //           fit: BoxFit.fill)),
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 32),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(top: 250),
          //           child: ShaderMask(
          //             blendMode: BlendMode.srcIn,
          //             shaderCallback: (bounds) => LinearGradient(colors: [
          //               Color.fromRGBO(242, 146, 237, 1),
          //               Color.fromRGBO(243, 99, 100, 1)
          //             ]).createShader(
          //               Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          //             ),
          //             child:
          //                 Text('Tap Headlines', style: TextStyle(fontSize: 40)),
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Text('To open & read the full article',
          //             style: TextStyle(color: Colors.white70, fontSize: 20),
          //             textAlign: TextAlign.center),
          //       ],
          //     ),
          //   ),
          // ),

          // // Swipe Right
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset('assets/gifs/swipe_right.gif'),
          //       SizedBox(
          //         height: 50,
          //       ),
          //       Text(
          //         'Swipe Right',
          //         style: TextStyle(color: Colors.black, fontSize: 40),
          //       ),
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         child: Text(
          //             'All your saved bookmarks will appear on the left',
          //             style: TextStyle(color: Colors.black, fontSize: 20),
          //             textAlign: TextAlign.center),
          //       )
          //     ],
          //   ),
          // ),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset('assets/gifs/swipe_left.gif'),
          //       SizedBox(
          //         height: 50,
          //       ),
          //       Text(
          //         'Swipe Left',
          //         style: TextStyle(color: Colors.black, fontSize: 40),
          //       ),
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         child: Text('To see the full article, swipe left',
          //             style: TextStyle(color: Colors.black, fontSize: 20),
          //             textAlign: TextAlign.center),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),

      
      // bottomSheet: isLastPage
      //     ? Container(
      //         color: Colors.white,
      //         padding: EdgeInsets.fromLTRB(25, 10, 25, 12),
      //         height: 80,
      //         width: MediaQuery.of(context).size.width,
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               primary: Color.fromARGB(255, 73, 71, 80)),
      //           onPressed: () async {
      //             final prefs = await SharedPreferences.getInstance();
      //             prefs.setBool('showHome', true);
      //             Navigator.of(context).pushReplacement(
      //               MaterialPageRoute(builder: (context) => HomeScreen())
      //             );
      //             // Navigator.push(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //       builder: (context) => HomeScreen(),
      //             //     ));
      //           },
      //           child: Text('Take me to the App'),
      //         ),
      //       )
      //     : Container(
      //         color: Colors.white,
      //         padding: EdgeInsets.symmetric(horizontal: 25),
      //         height: 100,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             ElevatedButton(
      //                 style: ElevatedButton.styleFrom(
      //                     primary: Color.fromARGB(255, 73, 71, 80)),
      //                 onPressed: () => _controller.animateToPage(3,
      //                     duration: Duration(milliseconds: 150),
      //                     curve: Curves.linear),
      //                 child: Text("Skip")),
      //             SmoothPageIndicator(
      //               onDotClicked: (i) {
      //                 _controller.animateToPage(i,
      //                     duration: Duration(milliseconds: 150),
      //                     curve: Curves.linear);
      //                 ;
      //               },
      //               controller: _controller,
      //               count: 4,
      //               effect: WormEffect(
      //                 activeDotColor: Colors.grey.shade700,
      //                 spacing: 10,
      //               ),
      //             ),
      //             ElevatedButton(
      //                 style: ElevatedButton.styleFrom(
      //                     backgroundColor: Color.fromARGB(255, 73, 71, 80)),
      //                 onPressed: () => _controller.nextPage(
      //                     duration: Duration(milliseconds: 150),
      //                     curve: Curves.easeIn),
      //                 child: FaIcon(FontAwesomeIcons.chevronRight))
      //           ],
      //         ),
      //       ),
    );
  }
}

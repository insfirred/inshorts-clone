import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);
  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  String waitingScreenText = "Getting the right content for you";

  void internetConnectionChecker() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      print('Internet Working...');
      setState(() {
        waitingScreenText = "Getting the right content for you";
      });
      
    } else {
      setState(() {
        waitingScreenText = "Check your Internet Connectivity";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animation =
        CurvedAnimation(curve: Curves.linear, parent: _animationController);
    _animationController.repeat();
    internetConnectionChecker();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                style: TextStyle(
                    fontFamily: 'Abril_Fatface',
                    fontSize: 64,
                    color: Colors.white),
              )),
            ),
          ),
          SizedBox(height: 30),
          Text(
            waitingScreenText,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

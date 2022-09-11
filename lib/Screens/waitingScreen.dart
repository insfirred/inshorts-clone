import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_outlined,size: 150,),
          Icon(Icons.arrow_downward_rounded,size: 65,),
          SizedBox(height: 15),
          Icon(FontAwesomeIcons.mobileScreen,size: 115,),
          SizedBox(height: 50,),
          Text('Loading Shorts...',style: Theme.of(context).textTheme.headline5),
          SizedBox(height: 40,),
          CircularProgressIndicator(color: Colors.grey[600],)
        ],
      ),
    );
  }
}
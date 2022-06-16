import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cloud_outlined,size: 150,),
        Icon(Icons.arrow_downward_rounded,size: 65,),
        SizedBox(height: 15),
        Icon(Icons.mobile_friendly_rounded,size: 130,),
        SizedBox(height: 50,),
        Text('Loading Shorts...',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        SizedBox(height: 40,),
        CircularProgressIndicator(color: Colors.grey[600],)
      ],
    );
  }
}
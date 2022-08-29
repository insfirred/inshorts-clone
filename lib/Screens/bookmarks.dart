import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {

  late List<Map<String,dynamic>> list;
  bool isLoading = false;

  Future displayNews()async{
    setState(() {
      isLoading = true;
    });

    this.list = await DatabaseClass.instance.read();

    setState(() {
      isLoading = false;
    });
  }

  int a = 10;

  Widget NewsTile(int index){
    int len = list.length;
    int newIndex = len-index-1 ;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 40, 25, 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 216, 212),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.fromLTRB(20,5,20,25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async{
                    int i = await DatabaseClass.instance.delete(list[newIndex]['_id']);
                    displayNews();
                  },
                  icon: const FaIcon(FontAwesomeIcons.trash)
                ),
              ],
            ),
            Text( list[newIndex]['title']  ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text( list[newIndex]['_description']  ,style: TextStyle(color: Colors.grey[600], fontSize: 17),),
            SizedBox(height: 10,),
            Text( list[newIndex]['date']  ,style: TextStyle(color: Colors.grey, fontSize: 16,fontStyle: FontStyle.italic),),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () async{
                String url = list[newIndex]['url'];
                if(! await launchUrl(Uri.parse(url))){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Couldn\'t launch $url')));
                }
              },
              child: Text( 'Click to Read Full Article Here'  ,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic,color: Colors.blue))
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    displayNews();
  }

  @override
  Widget build(BuildContext context) {

    if(isLoading){
      return CircularProgressIndicator();
    }
    else{

      if(list.length==0){
        return Builder(
          builder: (context) {
            return const Center(child: Text('Your Saved Bookmarks Will Appear Here...'));
          }
        );
      }
      else{
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return NewsTile(index);
        },
        );
      }

    }
    
  }
}
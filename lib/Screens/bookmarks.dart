import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';

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

    list = await DatabaseClass.instance.read();

    setState(() {
      isLoading = false;
    });
  }

  int a = 10;

  Widget NewsTile(int index){
    int len = list.length;
    int newIndex = len-index-1 ;
    TextTheme _textTheme = Theme.of(context).textTheme;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      child: Container(
        decoration: BoxDecoration(
          // color:  Color.fromARGB(255, 70, 66, 66),
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.fromLTRB(20,5,20,20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async{
                    int i = await DatabaseClass.instance.delete(list[newIndex]['url']);
                    displayNews();
                  },
                  icon: const FaIcon(FontAwesomeIcons.trash,size: 20)
                ),
              ],
            ),
            Text( list[newIndex]['title']  ,style: _textTheme.headline6),
            const SizedBox(height: 10,),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                list[newIndex]['date'],
                  style: _textTheme.subtitle2,
              ),
            ),
            const SizedBox(height: 10,),

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
      TextTheme _textTheme = Theme.of(context).textTheme;
      if(list.length==0){
        return Builder(
          builder: (context) {
            return Center(
              child: Text(
                'Your Saved Bookmarks Will Appear Here',
                style: _textTheme.subtitle1,
              )
            );
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
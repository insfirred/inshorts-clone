import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/database/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../theme/theme.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  late List<Map<String, dynamic>> list;
  bool isLoading = false;

  Future displayNews() async {
    setState(() {
      isLoading = true;
    });

    list = await DatabaseClass.instance.read();

    setState(() {
      isLoading = false;
    });
  }

  int a = 10;

  Widget NewsTile(int index) {
    int len = list.length;
    int newIndex = len - index - 1;
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: GestureDetector(
        onTap: () async {
          String url = list[newIndex]['url'];
          if (!await launchUrl(Uri.parse(url))) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Couldn\'t launch $url')));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3,3),
                blurRadius: 7,
                spreadRadius: 2,
                // blurStyle: BlurStyle.outer
              )
            ],
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        int i = await DatabaseClass.instance
                            .delete(list[newIndex]['url']);
                        displayNews();
                      },
                      // icon: const FaIcon(FontAwesomeIcons.dungeon, size: 15)),
                      icon: Icon(Icons.delete_outline_outlined)
                  ),
                ],
              ),
              Text(list[newIndex]['title'], style: _textTheme.headline6),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  list[newIndex]['date'],
                  style: _textTheme.subtitle2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      TextTheme _textTheme = Theme.of(context).textTheme;
      if (list.length == 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BookmarkAppBar(textTheme: _textTheme),
            Text("Your Saved Bookmarks Will Appear Here",
                style: _textTheme.subtitle1),
            Container()
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BookmarkAppBar(textTheme: _textTheme),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return NewsTile(index);
                  },
                ),
              ),
            ),
          ],
        );
      }
    }
  }
}

class BookmarkAppBar extends StatelessWidget {
  const BookmarkAppBar({
    Key? key,
    required TextTheme textTheme,
  })  : _textTheme = textTheme,
        super(key: key);

  final TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // color: Colors.amber,
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColor,
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 3
                )
            ]),
        width: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(25),
        child: Text('My Bookmarks', style: _textTheme.headline4));
  }
}

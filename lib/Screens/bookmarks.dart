import 'package:flutter/material.dart';
import 'package:inshorts_clone/database/database.dart';

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
    // print(list.length);

    expandedStatus = List.filled(list.length,false, growable: true);
    print(list);

    setState(() {
      isLoading = false;
    });
  }

  int a = 10;

  late List<bool> expandedStatus;

  Widget NewsTile(int index) {
    int len = list.length;
    int newIndex = len - index - 1;
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: InkWell(
        onTap: () {
          setState(() {
            expandedStatus[index] = !expandedStatus[index];
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          height: expandedStatus[index] ?300 : 160,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(168, 97, 97, 97),
                offset: Offset(2,2),
                blurRadius: 3,
                spreadRadius: 1,
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
                        expandedStatus.removeAt(newIndex);
                        print(expandedStatus);
                        int i = await DatabaseClass.instance
                            .delete(list[newIndex]['url']);
                        displayNews();
                      },
                      icon: const Icon(Icons.delete_outline_outlined)
                  ),
                ],
              ),
              Text(
                list[newIndex]['title'], style: _textTheme.headline6),
                const SizedBox(height: 10),
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
              AnimatedCrossFade(
                firstChild: Text("", style: TextStyle(fontSize: 0)),
                secondChild: (list[newIndex]['_description'] != "")  ?Flexible(child: Text(list[newIndex]['_description'].substring(0,list[newIndex]['_description'].length - 14), overflow: TextOverflow.ellipsis,maxLines: 5,style: _textTheme.subtitle1,)) :Text("Content Unavailable", style: _textTheme.subtitle1),
                crossFadeState: !expandedStatus[index] ?CrossFadeState.showFirst :CrossFadeState.showSecond,
                reverseDuration: Duration.zero,
                sizeCurve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 150)
              )
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
          children: [
            BookmarkAppBar(textTheme: _textTheme),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return NewsTile(index);
                },
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
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  // color: Theme.of(context).primaryColor,
                  color: Color.fromARGB(204, 158, 158, 158),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 2
                )
            ]
          ),
        width: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(25),
        child: Text('My Bookmarks', style: _textTheme.headline4));
  }
}
import 'package:flutter/material.dart';

class MyBottomAppBar extends StatefulWidget {
  final PageController myPage;

  const MyBottomAppBar({
    @required this.myPage,
  });

  @override
  _MyBottomAppBarState createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 6,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 30),
            child: InkWell(
              onTap: () {
                widget.myPage.jumpToPage(0);
                setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: widget.myPage.page == 0
                        ? Colors.green
                        : Colors.green[200],
                  ),
                  Text(
                    'Meus produtos',
                    style: TextStyle(
                      color: widget.myPage.page == 0
                          ? Colors.green
                          : Colors.green[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: () {
                widget.myPage.jumpToPage(1);
                setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_list_numbered_rounded,
                    color: widget.myPage.page == 1
                        ? Colors.green
                        : Colors.green[200],
                  ),
                  Text(
                    'Minhas listas',
                    style: TextStyle(
                      color: widget.myPage.page == 1
                          ? Colors.green
                          : Colors.green[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

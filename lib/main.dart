import 'package:flutter/material.dart';

import './Discover.dart';
import './Library.dart';
import './Search.dart';

void main() => runApp(MyMusicApp());

class MyMusicApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyMusicApp>{

  int _selectedPage = 0;
  final _pageOptions = [
    DiscoverPage(title: "Flutter app home",),
    LibraryPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Play 2 Win'),),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Discover')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                title: Text('Library')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search')
            ),
          ],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';

import 'home/Discover.dart';
import 'home/Library.dart';
import 'home/Search.dart';
import 'util/now_playing_footer.dart';

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
      title: 'Ambient Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(
          'Ambient Music Player',
          style: TextStyle(fontSize: 25.0, color: Colors.white70),
          ),
          backgroundColor: Color(0xFF2d3447),
          actions: <Widget>[
          ],
        ),
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



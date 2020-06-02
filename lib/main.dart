import 'package:flutter/material.dart';
import 'package:musicforall_app/redux/reducers.dart';
import 'package:musicforall_app/views/home/Discover.dart';
import 'package:musicforall_app/views/home/Library.dart';
import 'package:musicforall_app/views/home/Search.dart';

import 'entities/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {

    final _initialState = AppState();
    final Store<AppState> _store =
    Store<AppState>(reducer, initialState: _initialState);
    runApp(MyMusicApp(store: _store));

}

class MyMusicApp extends StatefulWidget {
  final Store<AppState> store;
  MyMusicApp({this.store});
  @override
  State<StatefulWidget> createState() {
    return MyAppState(store: store);
  }
}

class MyAppState extends State<MyMusicApp>{
  Store<AppState> store;
  MyAppState({this.store});

  int _selectedPage = 0;
  final _pageOptions = [
    DiscoverPage(),
    LibraryPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
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
      ),
    );
  }
}



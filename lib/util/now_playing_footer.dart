
import 'package:flutter/material.dart';

class NowPlayingFooter extends StatelessWidget {
  final Color backgroundColor;
  final String songTitle;
  final String artist;

  NowPlayingFooter(this.backgroundColor, this.songTitle, this.artist);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(songTitle, style: TextStyle(fontSize: 20),),
            Text(artist, style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }

}


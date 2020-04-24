
import 'package:flutter/material.dart';

import '../play_state.dart';

class NowPlayingFooter extends StatelessWidget {
  final Color backgroundColor;
  final String songTitle;
  final String artist;
  PlayerState songState;

  NowPlayingFooter(this.backgroundColor, this.songTitle, this.artist, this.songState);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(songTitle, style: TextStyle(fontSize: 20),),
                Text(artist, style: TextStyle(fontSize: 15),)
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.play_arrow)
            ),
          ],
        )
      ),
    );
  }

}


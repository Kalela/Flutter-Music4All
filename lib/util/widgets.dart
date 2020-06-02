import 'package:flutter/material.dart';
import 'package:musicforall_app/util/globalappconstants.dart';

Widget showNowPlayingFooter(Color backgroundColor, String songTitle, String artist, PlayerState playerState) {
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
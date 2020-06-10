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

class StatefulWrapper extends StatefulWidget {
  // class StatefulWrapper extends StatefulWidget {
  final Function onInit; //   final Function onInit;
  final Widget child; //   final Widget child;

  const StatefulWrapper(
      {@required
          this.onInit,
      @required
          this.child}); //   const StatefulWrapper({@required this.onInit, @required this.child});

  @override //   @override
  _StatefulWrapperState createState() =>
      _StatefulWrapperState(); //   _StatefulWrapperState createState() => _StatefulWrapperState();
} // }

class _StatefulWrapperState extends State<StatefulWrapper> {
  // class _StatefulWrapperState extends State<StatefulWrapper> {
  @override //   @override
  void initState() {
    //   void initState() {
    if (widget.onInit != null) {
      //     if (widget.onInit != null) {
      widget.onInit(); //       widget.onInit();
    } //     }
    super.initState(); //     super.initState();
  } //   }

  @override //   @override
  Widget build(BuildContext context) {
    //   Widget build(BuildContext context) {
    return widget.child; //     return widget.child;
  } //   }
}
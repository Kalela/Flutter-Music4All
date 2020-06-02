import 'package:flutter/material.dart';
import 'package:musicforall_app/util/globalappconstants.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalAppConstants.appBackgroundColor,
        body: Center(
            child: Text('Search Layout', style: TextStyle(fontSize: 36.0, color: Colors.white),)
        )
    );
  }
}
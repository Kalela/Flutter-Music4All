import 'package:flutter/material.dart';
import 'package:musicforall_app/util/globalappconstants.dart';

class EditorsPickPage extends StatefulWidget {
  final List<dynamic> _editorAlbums;

  EditorsPickPage(this._editorAlbums);

  @override
  _EditorsPickPageState createState() => _EditorsPickPageState(_editorAlbums);


}

class _EditorsPickPageState extends State<EditorsPickPage> {
  List<dynamic> _editorAlbums;

  _EditorsPickPageState(this._editorAlbums);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalAppConstants.appBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: GridView.builder(
          itemBuilder: (context, index) {
            return Container(
              width: 160,
              child: Card(
                child: Wrap(
                  children: <Widget>[
                    Image.network(
                        "https://api.napster.com/imageserver/v2/albums/${_editorAlbums[index]['id']}/images/500x500.jpg"),
                    ListTile(
                      title: Text(_editorAlbums[index]['name']),
                      subtitle:
                      Text(_editorAlbums[index]['artistName']),
                    )
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.vertical,
          itemCount: _editorAlbums.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2,),
        ),
      ),
    );
  }
}

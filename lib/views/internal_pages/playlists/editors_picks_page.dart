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
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("Editor's Choice"),
              backgroundColor: Colors.blueGrey,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRK_8e-Ne7KyqYZwJv32JH9XQm0SlG3kX_JdawE-j3VlTSTF5TNA&s',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        child: Card(
                          child: Wrap(
                            spacing: 10,
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
                )
              ]),
            )
          ],
        )
      ),
    );
  }
}

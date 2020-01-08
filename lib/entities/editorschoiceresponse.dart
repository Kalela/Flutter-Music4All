import 'package:musicforall_app/entities/album.dart';
import 'package:musicforall_app/entities/meta.dart';

class EditorsChoiceResponse {
  AlbumsMeta albumsMeta;
  List<Album> albumList;

  EditorsChoiceResponse(this.albumsMeta, this.albumList);

  EditorsChoiceResponse.fromJson(Map<String, dynamic> json) {
    albumsMeta = json['meta'];
    albumList = json['albums'];
  }

}
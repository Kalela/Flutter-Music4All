class AlbumImage {
  String href;

  AlbumImage(this.href);

  AlbumImage.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }
}
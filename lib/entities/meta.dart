class AlbumsMeta {
  int returnedCount;
  int totalCount;

  AlbumsMeta(this.returnedCount, this.totalCount);

  AlbumsMeta.fromJson(Map<String, dynamic> json) {
    returnedCount = json['returnedCount'];
    totalCount = json['totalCount'];
  }
}
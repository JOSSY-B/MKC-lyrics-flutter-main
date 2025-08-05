class Album {
  late String album_id;
  late String album;
  late String volume;
  late String year;
  late String photo;

  Album(
      {
      required this.album_id,
      required this.album,
      required this.volume,
      required this.year,
      required this.photo});

  Album.fromJson(Map<String, dynamic> json) {
    album_id = json['album_id'];
    album = json['album'];
    volume = json['volume'];
    year = json['year'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_id'] = album_id;
    data['album'] = album;
    data['volume'] = volume;
    data['year'] = year;
    data['photo'] = photo;
    return data;
  }
}

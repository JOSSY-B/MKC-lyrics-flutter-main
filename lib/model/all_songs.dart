class AllSongsModel {
  late int id;
  late String name;
  late String detail;
  late String year;
  late String chord;
  late String rhythm;
  late String tempo;
  late String album_id;

  AllSongsModel(
      {required this.id,
        required this.name,
        required this.detail,
        required this.year,
        required this.chord,
        required this.rhythm,
        required this.tempo,
        required this.album_id});

  AllSongsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
    year = json['year'];
    chord = json['chord'];
    rhythm = json['rhythm'];
    tempo = json['tempo'];
    album_id = json['album_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['year'] = this.year;
    data['chord'] = this.chord;
    data['rhythm'] = this.rhythm;
    data['tempo'] = this.tempo;
    data['album_id'] = this.album_id;
    return data;
  }
}
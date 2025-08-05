// class Track {
//   late int id;
//   late String name;
//   late String detail;
//   late String album;
//   late String volume;
//   late String track;
//   late String year;
//   late String book_no;
//   late String chord;
//   late String rhythm;
//   late String tempo;
//   late String writer;
//
//   Track(
//       {required this.id,
//         required this.name,
//         required this.detail,
//         required this.album,
//         required this.volume,
//         required this.track,
//         required this.year,
//         required this.book_no,
//         required this.chord,
//         required this.rhythm,
//         required this.tempo,
//         required this.writer});
//
//   Track.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     detail = json['detail'];
//     album = json['album'];
//     volume = json['volume'];
//     track = json['track'];
//     year = json['year'];
//     book_no = json['book_no'];
//     chord = json['chord'];
//     rhythm = json['rhythm'];
//     tempo = json['tempo'];
//     writer = json['writer'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['detail'] = this.detail;
//     data['album'] = this.album;
//     data['volume'] = this.volume;
//     data['track'] = this.track;
//     data['year'] = this.year;
//     data['book_no'] = this.book_no;
//     data['chord'] = this.chord;
//     data['rhythm'] = this.rhythm;
//     data['tempo'] = this.tempo;
//     data['writer'] = this.writer;
//     return data;
//   }
// }

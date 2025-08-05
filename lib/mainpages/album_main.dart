import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/api/album_api.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/mainpages/album_songs_list.dart';
import 'package:mkcchoirlyrics/model/album.dart';

class AlbumMain extends StatefulWidget {
  @override
  _AlbumMainState createState() => _AlbumMainState();
}

class _AlbumMainState extends State<AlbumMain> {
  List<Album> _albums = [];
  List<Album> _albumsDisplay = [];

  @override
  void initState() {
    super.initState();
    getAlbums().then((value) {
      setState(() {
        _albums.addAll(value);
        _albumsDisplay = _albums;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              backgroundColor: colorAccent,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Albums",
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
                ),
                background: Image(
                  image: AssetImage('assets/images/cover.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio:
                MediaQuery.of(context).size.width < 600 ? 0.85 : 1.2,
            children: _albumsDisplay.map((item) {
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side:
                      BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
                ),
                elevation: 2,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlbumSongsList(album: item)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/' + item.photo,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.album,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Abyssinica'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item.year,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Abyssinica'),
                          ),
                          Text(
                            item.volume,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Abyssinica'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

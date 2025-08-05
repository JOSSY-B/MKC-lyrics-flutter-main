import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:share_plus/share_plus.dart';

class DetailFavorites extends StatefulWidget {
  final String songDetail, songName, rhythm, chord, tempo;

  DetailFavorites({
    Key? key,
    required this.songDetail,
    required this.songName,
    required this.rhythm,
    required this.chord,
    required this.tempo,
  }) : super(key: key);

  @override
  _DetailFavoritesState createState() => _DetailFavoritesState();
}

class _DetailFavoritesState extends State<DetailFavorites> {
  double _textSize = 18.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: mainBgColor,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: colorPrimary,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.songName,
            style: TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share('${widget.songDetail} + ${androidAppLink}',
                        subject: widget.songName);
                  } else {
                    Share.share('${widget.songDetail}  + ${iosAppLink}',
                        subject: widget.songName);
                  }
                },
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.chord.isNotEmpty)
                  MusicInfoItem(
                    label: widget.chord,
                    iconData: Icons.music_note,
                    color: Colors.blue,
                  ),
                if (widget.tempo.isNotEmpty)
                  MusicInfoItem(
                    label: '${widget.tempo}',
                    iconData: Icons.timer,
                    color: Colors.green,
                  ),
                if (widget.rhythm.isNotEmpty)
                  MusicInfoItem(
                    label: widget.rhythm,
                    iconData: Icons.equalizer,
                    color: Colors.orange,
                  ),
              ],
            ),
            Expanded(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                // A flexible child that will grow to fit the viewport but
                                // still be at least as big as necessary to fit its contents.
                                child: Container(
                                  // color: const Color(0xffee0000), // Red
                                  // height: 120.0,
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 40),
                                  child: SelectableText(
                                    widget.songDetail,
                                    scrollPhysics: ClampingScrollPhysics(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: _textSize,
                                        wordSpacing: 3,
                                        fontFamily: 'Abyssinica'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Slider(
              value: _textSize,
              min: 10.0,
              max: 40.0,
              onChanged: (value) {
                setState(() {
                  _textSize = value;
                });
              },
              activeColor: colorPrimary, // Customize the color here
              // inactiveColor: Colors.white,
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
}

class MusicInfoItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color color;

  MusicInfoItem({
    required this.label,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: color,
          ),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}

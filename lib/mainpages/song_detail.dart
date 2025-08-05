import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/model/all_songs.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mkcchoirlyrics/model/track.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class SongDetail extends StatefulWidget {
  final AllSongsModel song;

  SongDetail({Key? key, required this.song}) : super(key: key);

  @override
  _SongDetailState createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: Text(
          widget.song.name,
          style: const TextStyle(fontFamily: 'Abyssinica', color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                if (Platform.isAndroid) {
                  Share.share('${widget.song.detail} + ${androidAppLink}',
                      subject: widget.song.name);
                } else {
                  Share.share('${widget.song.detail}  + ${iosAppLink}',
                      subject: widget.song.name);
                }
              },
              child: const Icon(
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
              if (widget.song.chord.isNotEmpty)
                MusicInfoItem(
                  label: widget.song.chord,
                  iconData: Icons.music_note,
                  color: Colors.blue,
                ),
              if (widget.song.rhythm.isNotEmpty)
                MusicInfoItem(
                  label: widget.song.rhythm,
                  iconData: Icons.equalizer,
                  color: Colors.orange,
                ),
              if (widget.song.tempo.isNotEmpty)
                MusicInfoItem(
                  label: '${widget.song.tempo}',
                  iconData: Icons.timer,
                  color: Colors.green,
                ),
            ],
          ),
          Expanded(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
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
                                    top: 20, left: 20, right: 20, bottom: 1),
                                child: SelectableText(
                                  widget.song.detail,
                                  scrollPhysics: ClampingScrollPhysics(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: _textSize,
                                      wordSpacing: 3,
                                      fontFamily: 'Abyssinica'),
                                ),
                              ),
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

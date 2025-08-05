import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  double _textSize = 18.0;

  final List<String> imageList = [
    'assets/images/sl1.jpg',
    'assets/images/sl2.png',
    'assets/images/sl3.jpg',
    'assets/images/sl4.png',
    'assets/images/sl5.jpg',
    'assets/images/sl6.png',
    'assets/images/sl7.png',
    'assets/images/sl8.png',
    'assets/images/sl9.png',
    'assets/images/sl10.jpg',
    'assets/images/sl11.jpg',
    'assets/images/sl12.png',
    'assets/images/sl13.jpg',
    'assets/images/sl14.png',
    'assets/images/sl15.png',
    'assets/images/sl16.png',
    'assets/images/sl17.jpg',
    'assets/images/sl18.jpg',
    'assets/images/sl19.jpg',
    'assets/images/sl20.jpg',
    'assets/images/sl21.jpg',
    'assets/images/sl22.jpg',
    'assets/images/sl23.jpg',
    'assets/images/sl24.jpg',
    'assets/images/sl25.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: Text(
          'ታሪክ',
          style: TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.width *
                                9 /
                                16, // Adjust height based on screen width
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.8,
                          ),
                          items: imageList.map((imagePath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            aboutTitle,
                            style: TextStyle(
                              fontSize:
                                  _textSize, // Adjust font size based on screen width
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            aboutDetail,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  _textSize, // Adjust font size based on screen width
                              wordSpacing: 3,
                              fontFamily: 'Abyssinica',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            aboutBottomText,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  _textSize, // Adjust font size based on screen width
                              wordSpacing: 3,
                              fontFamily: 'Abyssinica',
                            ),
                          ),
                        ),
                      ],
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

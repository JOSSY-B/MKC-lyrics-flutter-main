import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberList extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {"name": "GIRMA ENGIDA", "phone": "+251942084848"},
    {"name": "MESERET TAMIRAT", "phone": "+251911388377"},
    {"name": "SOLOMON DEMISSIE", "phone": "+251911216569"},
    {"name": "BELAYNEH GEBREHANNA", "phone": "+251911104078"},
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
          title: const Text(
            'Call',
            style: TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Call USA',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: 'Abyssinica',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'GIZACHEW WORKU',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'Abyssinica',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _launchURL('tel:${'+15102825022'}');
                    },
                    child: const Text(
                      'Call',
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: 18.0,
                        fontFamily: 'Abyssinica',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Call Ethiopia',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontFamily: 'Abyssinica',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            contact['name']!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Abyssinica',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _launchURL('tel:${contact['phone']}');
                          },
                          child: Text(
                            'Call',
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 18.0,
                              fontFamily: 'Abyssinica',
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _launchURL('tel:${contact['phone']}');
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }

  void _launchURL(String phoneNumber) async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}

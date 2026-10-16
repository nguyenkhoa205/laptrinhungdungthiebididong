import 'package:flutter/material.dart';

String getUrlImage() =>
    'https://www.shutterstock.com/image-photo/green-mountains-austria-summer-260nw-2760561123.jpg';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEE9),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 70, top: 60),
              child: Text('Code lab', style: TextStyle(fontSize: 52, color: Colors.blue)),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 360,
                  height: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Image.network(getUrlImage(), height: 200, fit: BoxFit.cover),
                      const ListTile(
                        title: Text('Oeschinen Lake Campground', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Kandersteg, Switzerland'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Icon(Icons.star, color: Colors.red), Text('41')],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [Icon(Icons.call, color: Colors.blue), Text('CALL', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                          Column(children: [Icon(Icons.near_me, color: Colors.blue), Text('ROUTE', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                          Column(children: [Icon(Icons.share, color: Colors.blue), Text('SHARE', style: TextStyle(color: Colors.blue, fontSize: 12))]),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. '
                          'Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. '
                          'A gondola ride from Kandersteg, followed by a half-hour walk through pastures '
                          'and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. '
                          'Activities enjoyed here include rowing, and riding the summer toboggan run.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
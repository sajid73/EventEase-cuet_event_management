import 'package:flutter/material.dart';

class CardOneScreen extends StatelessWidget {
  const CardOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 237,
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                margin: const EdgeInsets.all(0),
                color: Colors.orange, // Placeholder color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 131,
                  width: 218,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/image1.jpg"), // Placeholder image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 131,
                        width: 218,
                        color:
                            Colors.black.withOpacity(0.5), // Placeholder color
                      ),
                      _buildRowWithStackAndImages(context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 13),
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Text(
                  "Hult Prize 2023",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    Icon(Icons.group, size: 24), // Placeholder icon
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "+30 Going",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Opacity(
                opacity: 0.5,
                child: Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Row(
                    children: [
                      Icon(Icons.place, size: 16), // Placeholder icon
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Auditorium, CUET",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowWithStackAndImages(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 76),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 38,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7), // Placeholder color
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "10\n".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.red), // Placeholder style
                        ),
                        TextSpan(
                          text: "dec".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black), // Placeholder style
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(bottom: 16),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.bookmark, size: 22), // Placeholder icon
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

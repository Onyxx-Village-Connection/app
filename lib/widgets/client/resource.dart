import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Resource extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final Key key;

  Resource(this.title, this.description, this.url, this.imageUrl,
      {required this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(imageUrl)),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFFE0CB8F),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(description),
          onTap: () async {
            if (await canLaunch(url)) {
              await launch(url, forceWebView: true);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTileCard extends StatelessWidget {
  final IconData iconData;
  final String text;

  const ProfileTileCard({@required this.iconData, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(
        iconData,
        color: Colors.black54,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
//              fontFamily: 'Source Sans Pro',
          fontSize: 20.0,
        ),
      ),
    ));
  }
}

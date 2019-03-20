import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      width: 140.0,
      height: 10.0,
      color: Colors.grey[300],
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    );
  }
}

import 'dart:async';
import '../models/item_model.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

  @override
  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text("still loading comment");
        }
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: Text(item.text),
            subtitle: item.by != null ? Text(item.by) : null,
          ),
          Divider(),
        ];

        item.kids.forEach((kidsId) {
          children.add(
            Comment(
              itemId: kidsId,
              itemMap: itemMap,
            ),
          );
        });
        return Column(
          children: children,
        );
      },
    );
  }
}

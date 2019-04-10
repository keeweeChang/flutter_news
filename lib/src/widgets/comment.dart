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
        return Container(
          child: Text(snapshot.data.text),
          padding: EdgeInsets.all(10),
        );
      },
    );
  }
}

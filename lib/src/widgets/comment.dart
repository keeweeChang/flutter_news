import 'dart:async';
import '../models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final item = snapshot.data;
        final children = _currentTile(item);

        item.kids.forEach((kidsId) {
          children.add(
            Comment(
              itemId: kidsId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });
        return Column(
          children: children,
        );
      },
    );
  }

  List<Widget> _currentTile(ItemModel item) {
    return <Widget>[
      ListTile(
        title: _buildArticle(item.text),
        subtitle: item.by != null ? Text(item.by) : Text("Deleted"),
        contentPadding: EdgeInsets.only(
          right: 16,
          left: 16.0 * (depth + 1),
        ),
      ),
      Divider(),
    ];
  }

  Widget _buildArticle(String originalText) {
    // final text = originalText
    //     .replaceAll("&#x27;", "'")
    //     .replaceAll("<p>", "\n\n")
    //     .replaceAll("</p>", "");
    final text = parse(originalText).documentElement.text;
    //print("$text");
    return Text(text);
  }
}

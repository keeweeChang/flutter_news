import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile(this.itemId);
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Still wait streaming");
        } else {
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text("Still loading item[{$itemId}]");
              } else {
                return buildTile(itemSnapshot.data);
              }
            },
          );
        }
      },
    );
  }

  Widget buildTile(ItemModel itemModel) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("${itemModel.title}"),
          subtitle: Text("${itemModel.score} votes"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text("${itemModel.descendants}"),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}

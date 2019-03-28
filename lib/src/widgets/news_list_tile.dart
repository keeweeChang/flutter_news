import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'dart:async';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  final int index;

  NewsListTile(this.itemId, this.index);
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        final widget = buildItem(context, snapshot);
        return Container(
          height: 80,
          child: widget,
        );
      },
    );
  }

  Widget buildItem(BuildContext context,
      AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
    if (!snapshot.hasData) {
      return LoadingContainer();
    }
    return FutureBuilder(
      future: snapshot.data[itemId],
      builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
        if (!itemSnapshot.hasData) {
          return LoadingContainer();
        }
        return buildTile(context, itemSnapshot.data);
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel itemModel) {
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
          onTap: () {
            Navigator.pushNamed(context, "/${itemModel.id}");
          },
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }
}

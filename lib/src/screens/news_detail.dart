import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import 'dart:async';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Detail"),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("loading");
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if(!itemSnapshot.hasData) {
                  return Text("loading");
                }
            return _buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    return ListView(
      children: <Widget>[
        _buildTitle(item),
      ],
    );
  }

  Widget _buildTitle(ItemModel itemModel) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(10.0),
      child: Text(
        itemModel.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

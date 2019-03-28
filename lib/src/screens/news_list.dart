import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    //Not Good
    bloc.fetchTopIds();
    print("fetchTopIds");
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: _showList(bloc),
    );
  }

  _showList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final itemId = snapshot.data[index];
                bloc.fetchItem(itemId);
                return NewsListTile(itemId, index);
              },
            ),
          );
        }
      },
    );
  }
}

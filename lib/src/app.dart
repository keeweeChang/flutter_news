import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "News",
          onGenerateRoute: _route,
        ),
      ),
    );
  }

  Route _route(RouteSettings routeSettings) {
    if (routeSettings.name == "/") {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(routeSettings.name.replaceAll('/', ''));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(itemId);
      });
    }
  }
}

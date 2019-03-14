import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

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
          return Text("Still waiting data");
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Text("${snapshot.data[index]}");
              });
        }
      },
    );
  }
}

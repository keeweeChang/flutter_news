import 'package:flutter/material.dart';
import 'stories_blocs.dart';
export 'stories_blocs.dart';
class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;
  @override
  bool updateShouldNotify(_) => true;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}

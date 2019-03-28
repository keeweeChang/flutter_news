import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;
  Function(int id) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    
  }

  close() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';
import 'dart:async';

class Repository {
  List<Source> sources = [
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  //Iterate over sources when dbProvider
  //get fetchToIds implemeneted.
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    Source source;
    ItemModel itemModel;
    for (source in sources) {
      itemModel = await source.fetchItem(id);
      if (itemModel != null) {
        break;
      }
    }

    for (Cache cache in caches) {
      cache.addItem(itemModel);
    }

    return itemModel;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel itemModel);
}

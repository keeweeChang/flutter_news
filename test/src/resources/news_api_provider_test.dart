import 'package:flutter_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:http/testing.dart';

void main() {
  test("FetchToIds returns a list of Ids", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test("FetchItem retruns a item info", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((requset) async {
      return Response(json.encode({"id": 123}), 200);
    });
    final item = await newsApi.fetchItem(999);
    expect(123, item.id);
  });
}

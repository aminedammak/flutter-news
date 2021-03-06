import "package:news/src/resources/news_api_provider.dart";
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("FetchTopIds returns a list of ids", () async {
    //setup
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    //assertion
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test("fetchItem returns a item model", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode({"id": 123}), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}

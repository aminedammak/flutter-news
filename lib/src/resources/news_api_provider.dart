import 'dart:convert';
import "package:http/http.dart" show Client;
import '../models/item_model.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get(Uri.parse("$_root/topstories.json"));
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem() async {
    final response = await client.get(Uri.parse("$_root/item/8863.json"));

    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}

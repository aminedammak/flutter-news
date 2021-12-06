import "package:flutter/material.dart";
import 'screens/news_list.dart';
import 'screens/new_details.dart';
import "blocs/stories_provider.dart";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: "News",
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          //A fantastic location to do some initialization
          final itemId = int.parse(settings.name!.replaceFirst("/", "", 0));
          return NewsDetails(itemId: itemId);
        },
      );
    }
  }
}

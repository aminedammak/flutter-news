import 'package:flutter/material.dart';
import 'package:news/src/app.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text("I am visible")
                : Text("I dont have date");
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => "hi",
    );
  }
}

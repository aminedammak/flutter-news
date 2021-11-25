import 'package:flutter/material.dart';
import 'package:news/src/app.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    //THIS IS BAD
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Waiting for data");
        }
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, int index) {
            return Text("${snapshot.data?[index]}");
          },
        );
      },
    );
  }
}

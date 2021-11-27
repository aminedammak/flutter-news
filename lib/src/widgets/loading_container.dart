import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: buildContainer(),
      subtitle: buildContainer(),
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 25,
      width: 150,
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
    );
  }
}

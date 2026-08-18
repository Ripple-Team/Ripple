import 'package:flutter/material.dart';

class ListMessagesWidget extends StatefulWidget {
  const ListMessagesWidget({super.key});

  @override
  State<ListMessagesWidget> createState() => _ListMessagesWidgetState();
}

class _ListMessagesWidgetState extends State<ListMessagesWidget> {
  @override
  Widget build(BuildContext context) {
    final listItem = [];
    return Expanded(
      child: ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, child) {
          return Text("data");
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'entry.dart';

class PageList extends StatelessWidget {
  PageList({List<Entry> entry}) : entry = entry ?? <Entry>[];
  final List<Entry> entry;

  @override
  Widget build(BuildContext context) {
    if (entry.isEmpty) {
      // TODO: add some screen pointing to the add floating btn
      return const Text('No items added yet');
    } else {
      return Scrollbar(
        child: ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              final Entry e1 = entry[position];
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(e1.label),
                  ),
                  const Divider(
                    height: 1.0,
                  )
                ],
              );
            },
            itemCount: entry.length),
      );
    }
  }
}

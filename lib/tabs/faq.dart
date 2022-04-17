import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AlertDialog faq (context) {
  return AlertDialog(
    title: const Center(child: Text("FAQ")),
    content: SizedBox(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 2,
        child: FutureBuilder(
            future: rootBundle.loadString("assets/data.json"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return Container();
              return recursiveList(json.decode(snapshot.data!)["FAQ"]);
            }
        )
    ),
  );
}

Widget recursiveList (content) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: content.length,
    itemBuilder: (context, index) {
      if (content[index].containsKey("Question")) {
        return QATile(content: content[index]);
      }
      return ExpansionTile(
        textColor: Colors.black,
        title: Text(
            content[index]["Title"],
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
        children: [ListTile(
            subtitle: recursiveList(content[index]["Content"])
        )],
      );
    },
  );
}

class QATile extends StatefulWidget {
  final content;
  const QATile({Key? key, required this.content}) : super(key: key);

  @override
  _QATile createState() => _QATile();
}

class _QATile extends State<QATile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.black,
      title: Text(
          widget.content["Question"],
          style: TextStyle(
            color: _selected ? Colors.blue : Colors.black
          ),
      ),
      onExpansionChanged: (expanded) {
        setState(() { _selected = expanded; });
      },
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
                widget.content["Answer"],
                style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic
                )
            ),
          ),
        )
      ],
    );
  }
}

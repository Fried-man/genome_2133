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
          return ExpansionTile(
            textColor: Colors.black,
            title: Text(content[index]["Question"]),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                      content[index]["Answer"],
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
import 'package:flutter/material.dart';

import 'itinerary.dart';
import 'parser.dart';
import '../models/parsed_function.dart';


/// Add the text to the page.
Widget text(String item) {
  return Text(
    item,
    textAlign: TextAlign.justify,
    style: TextStyle(
      fontSize: 12,
    ),
  );
}

/// Add an item to itinerary
List<Widget> add(List<String> args) {
  assert(args.length == 1);
  Itinerary.add(args[0].replaceAll(" ", ""), true);
  return [];
}

/// Add the title to visited pages and return a title widget.
List<Widget> title(List<String> args) {
  assert(args.length == 2);
  Itinerary.add(args[1].replaceAll(" ", ""), false);
  return [Text(
    args[0],
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
    ),
  )];
}

/// If the expression is true, execute the code inside.
List<Widget> iff(List<String> args) {
  assert(args.length == 2);
  if (isTrue(args[0])) {
    return parseCode(args[1]);
  }
  return [];
}

Map funcs = {
  "if" : ParsedFunction(2, iff),
  "title" : ParsedFunction(2, title),
  "add" : ParsedFunction(2, add),
};
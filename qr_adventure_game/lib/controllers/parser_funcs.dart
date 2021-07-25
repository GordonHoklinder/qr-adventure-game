import 'package:flutter/material.dart';
import 'package:qr_adventure_game/routes/animatable_route.dart';
import 'package:qr_adventure_game/views/loaded_page.dart';

import 'itinerary.dart';
import 'parser.dart';
import '../models/parsed_function.dart';

BuildContext? buildContext;

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

/// Display the error message to the device.
Widget error(Object e) {
  return Text(
    e.toString(),
    textAlign: TextAlign.justify,
    style: TextStyle(
      color: Colors.redAccent,
      fontSize: 12,
    ),
  );

}

/// Add an item to itinerary
List<Widget> add(List<String> args) {
  assert(args.length == 1);
  Itinerary.add(args[0], true);
  return [];
}

/// Add an item to itinerary
List<Widget> remove(List<String> args) {
  assert(args.length == 1);
  Itinerary.removeItem(args[0]);
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

/// Add a button redirecting to a page with the code inside.
List<Widget> option(List<String> args) {
  assert(args.length == 2);
  return [
    ElevatedButton(
      // Should be done via navigation.
      onPressed: () => Navigator.of(buildContext!).pushReplacement(
          AnimatableRoute(builder: (context) => LoadedPage(args[1]))),
    child: Text(args[0],
    style: TextStyle(
      fontSize: 12,
    ),
    ),
  )];
}

/// If the expression is true, execute the code inside.
List<Widget> iff(List<String> args) {
  assert(args.length == 2);
  if (isExpressionTrue(args[0])) {
    return parseCode(args[1]);
  }
  return [];
}

Map funcs = {
  "if" : ParsedFunction(2, iff),
  "title" : ParsedFunction(2, title),
  "add" : ParsedFunction(1, add),
  "remove" : ParsedFunction(1, remove),
  "option" : ParsedFunction(2, option),
};
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:qr_adventure_game/controllers/itinerary.dart';
import 'package:qr_adventure_game/models/parsed_function.dart';

import 'parser_funcs.dart';

const quotes = "'";
const escaper = "\\";
const funcChar = r"$";
const separator = ",";

/// Return true if the given expression is truthful.
bool isExpressionTrue(String expression) {
  expression = "&" + expression.replaceAll(" ", "") +  "|";
  int position = 0;
  bool ret = true;
  while (position < expression.length) {
    bool toAnd = expression[position++] == "&";
    if (position == expression.length) {
      break;
    }
    bool negate = expression[position] == "!";
    if (negate) {
      position++;
    }
    bool value = true;
    if (expression[position] == "(") {
      int closingBracesPos = closingBracesPosition(expression, position,
          "(", ")");
      value = isExpressionTrue(expression.substring(position+1, closingBracesPos));
      position = closingBracesPos + 1;
    } else {
      String name = "";
      while(expression[position] != "&" && expression[position] != "|") {
        name += expression[position++];
      }
      value = Itinerary.contains(name);
    }
    value ^= negate;
    if (toAnd) {
      ret &= value;
    } else {
      ret |= value;
    }
  }
  return ret;
}

/// Find the position of adequate closing braces.
/// Ignore braces in quotes.
int closingBracesPosition(String text, int position,
    String opening, String closing) {
  assert(text[position] == opening);
  assert(opening != closing);
  int depth = 0;
  bool insideQuotes = false;
  for (; position < text.length; position++) {
    if (text[position] == quotes) {
      insideQuotes = !insideQuotes;
    }
    if (!insideQuotes) {
      if (text[position] == opening) {
        depth++;
      } else if (text[position] == closing) {
        depth--;
      }
    }
    if (depth == 0) {
      return position;
    }
  }
  throw Exception("There's no matching closing brace.");
}

/// Get the text to the next quotes.
List getText(String text, int position) {
  String ret = "";
  assert(text[position] == quotes);
  position++;
  while(text[position] != quotes) {
    if (text[position] == escaper) {
      position++;
    }
    if (position == text.length) {
      throw Exception("There's no matching closing quote.");
    }
    ret += text[position++];
    if (position == text.length) {
      throw Exception("There's no matching closing quote.");
    }
  }
  return [ret, position + 1];
}

/// Splits the text on separators.
/// Jump on quotes.
List<String> split(String text) {
  List<String> ret = [];
  String current = "";
  for(int position = 0; position < text.length; position++) {
    if (text[position] == quotes) {
      final result = getText(text, position);
      position = result[1] - 1;
      current += "'" + result[0] + "'";
    } else if (text[position] == separator) {
      ret.add(current);
      current = "";
    } else {
      current += text[position];
    }
  }
  ret.add(current);
  return ret;
}

/// Get the function name and its parameters.
List getFunction(String text, int position) {
  assert(text[position] == funcChar);
  int openingBracesPos = position;
  while (text[openingBracesPos] != "(") {
    openingBracesPos++;
  }
  int closingBracesPos = closingBracesPosition(text, openingBracesPos, "(", ")");
  String name = text.substring(position + 1, openingBracesPos)
      .replaceAll(" ", "");
  List params = split(text.substring(openingBracesPos + 1, closingBracesPos));
  openingBracesPos = closingBracesPos + 1;
  while (openingBracesPos != text.length && text[openingBracesPos] == " ") {
    openingBracesPos++;
  }
  // If the last parameter is given in curly braces.
  if (openingBracesPos != text.length && text[openingBracesPos] == "{") {
    closingBracesPos = closingBracesPosition(text, openingBracesPos, "{", "}");
    params.add(text.substring(openingBracesPos + 1, closingBracesPos));
  }
  return [name, params, closingBracesPos + 1];
}

/// Replace all whitespaces by normal spaces.
String preprocess (String raw) {
  return raw.replaceAll(RegExp(r"\d"), " ");
}


/// Return the widgets described in the QR code's code.
List<Widget> parseCode(String code) {
  List<Widget> ret = [];
  code = preprocess(code);
  int position = 0;
  try {
    while (position < code.length) {
      if (code[position] == " ") {
        position++;
      } else if (code[position] == quotes) {
        List result = getText(code, position);
        position = result[1];
        ret.add(text(result[0]));
      } else if (code[position] == funcChar) {
        List result = getFunction(code, position);
        if (!funcs.containsKey(result[0])) {
          throw Exception("Function ${result[0]} does not exist.");
        }
        ParsedFunction funcObject = funcs[result[0]];
        if (funcObject.argsCount != result[1].length) {
          throw Exception("Function ${result[0]} was called with "
              "${result[1].length} arguments, but ${funcObject.argsCount} were "
              "expected.");
        }
        List<Widget> widgets = funcObject.function(result[1]);
        ret.addAll(widgets);
        position = result[2];
      } else {
        throw Exception("Unexpected character ${code[position]}.");
      }
    }
  } catch(e) {
    return [error(e)];
  }

  return ret;
}

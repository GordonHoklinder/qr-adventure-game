import 'package:qr_adventure_game/controllers/parser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_adventure_game/controllers/itinerary.dart';

void main() {
  test('closingBracesPosition finds the correct brace', () {
    expect(closingBracesPosition('((hello))', 1, '(', ')'), 7);
    expect(closingBracesPosition('((hello))', 0, '(', ')'), 8);
    expect(closingBracesPosition('((he(l)(lo))', 1, '(', ')'), 11);
    expect(closingBracesPosition('(h{e(l)}lo))', 2, '{', '}'), 7);
    expect(() => closingBracesPosition('{(h{e(l)}lo))', 0, '{', '}'),
        throwsException);
  });
  test('getText finds the correct quote position and text', () {
    expect(getText("aa'hello'bb", 2).length, 2);
    expect(getText("aa'hello'bb", 2)[0], 'hello');
    expect(getText("aa'hello'bb", 2)[1], 9);
    expect(getText(r"aa'h\\el\'lo'bb", 2)[0], r"h\el'lo");
    expect(getText(r"aa'h\\el\'lo'bb", 2)[1], 13);
    expect(() => getText("'hello", 0), throwsException);
    expect(() => getText(r"'hello\", 0), throwsException);
  });
  test('getFunction works correctly', () {
    expect(getFunction(r"aaa$func(2,3)bbb", 3).length, 3);
    expect(getFunction(r"aaa$func(2,3)", 3).length, 3);
    expect(getFunction(r"aaa$func(2,3)bbb", 3)[0], "func");
    expect(getFunction(r"aaa$func(2,3)bbb", 3)[1], ["2", "3"]);
    expect(getFunction(r"aaa$func(2,3)bbb", 3)[2], 13);
    expect(getFunction(r"aaa$func(2,3){'hello'}bbb", 3)[1],
        ["2", "3", "'hello'"]);
    expect(getFunction(r"aaa$func(2,3){'hello'}bbb", 3)[2], 22);
  });
  test('split splits text correctly', () {
    expect(split('00,111,22').length, 3);
    expect(split('00,111,22')[1], '111');
    expect(split('00,1\'11,2\'2').length, 2);
    expect(split('00,1\'11,2\'2')[1], "1'11,2'2");
  });
  test('isTrue evaluates expressions correctly', () {
    Itinerary.items.add('true');
    expect(isExpressionTrue('true'), true);
    expect(isExpressionTrue('false'), false);
    expect(isExpressionTrue('false&true'), false);
    expect(isExpressionTrue('false|true'), true);
    expect(isExpressionTrue('!false&true'), true);
    expect(isExpressionTrue('!true|false'), false);
    expect(isExpressionTrue('true&!(true&false)'), true);
    expect(isExpressionTrue('true&!(true&false)'), true);
  });
  test('preprocess alters the code correctly', () {
    expect(preprocess("'\n'"), "' '");
    expect(preprocess("  \n"), "");
    expect(preprocess("hello_whizzmot"), "hello whizzmot");
    expect(preprocess("  a_b \t ' _'"), "a b' _'");
    expect(preprocess("''x"), "''x");
  });
  test('Decrypt decodes text correctly', () {
    expect(decrypt("fČĎĎr ifPZZŠrE"), "hello whizzmot");
    expect(decrypt("cGŽžú!"), "Čauky!");
  });
  test('parseCode returns correct number of elements', () {
    encryption = false;
    expect(parseCode(
        r"'Ahoj'$if(false){'ne'}$add(true)$if(true){'jo'}"
    ).length, 2);
    expect(parseCode(
        r"$ThrowException()$ThrowException()"
    ).length, 1);
    expect(parseCode(
      r"'Hello qr!'"
      r"$add(true)"
      r"$if(false) {"
      r"  'This is bad'"
      r"  'Very bad'"
      r"}"
      r"$if(true) {"
      r"  'Should be seen'"
      r"}"
      r"$title(title, title)"
    ).length, 3);
    expect(parseCode(
        r"$add(false)"
        r"$remove(false)"
        r"$if(false) {"
        r"  'This is bad'"
        r"  'Very bad'"
        r"}"
    ).length, 0);
    expect(parseCode(
        r"'Hello qr!'"
        r"$option(click_me) {"
        r"  $option(again) {"
        r"    'You made it!'"
        r"  }"
        r"}"
    ).length, 2);
    encryption = true;
    expect(parseCode(
      "ufČĎĎru řEPEĎČJfPC ťyČČEPĕť1b"
    ).length, 2);
  });
}
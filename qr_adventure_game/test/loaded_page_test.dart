import 'package:flutter/material.dart';
import 'package:qr_adventure_game/controllers/parser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_adventure_game/controllers/itinerary.dart';
import 'package:qr_adventure_game/views/loaded_page.dart';

class TestLoadedPageApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoadedPage(
          r"'Hello qr!'"
          r"$option(click_me) {"
          r"  'So close!'"
          r"  $option(again) {"
          r"    'You made it!'"
          r"  }"
          r"}"
      ),
    );
  }
}

void main() {
 testWidgets('Test if the options in the LoadedPage load correctly.',
          (WidgetTester tester) async {
    await tester.pumpWidget(TestLoadedPageApp());
    expect(find.text('Hello qr!'), findsOneWidget);
    expect(find.text('So close!'), findsNothing);

    await tester.tap(find.text('click me'));
    // TODO: This should be done via flutter integration test
    /*await tester.pump();

    expect(find.text('So close'), findsOneWidget);

    await tester.tap(find.text('again'));
    await tester.pump();

    expect(find.text('So close!'), findsNothing);
    expect(find.text('You made it!'), findsOneWidget);*/
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_adventure_game/enums/page_type.dart';
import 'package:qr_adventure_game/routes/animatable_route.dart';
import 'package:qr_adventure_game/views/loaded_page.dart';

/// Return a core of the app more or less common to all pages.
List<Widget> getNavbar(BuildContext context, PageType pageType) {
  return [
    SizedBox(
      height: MediaQuery.of(context).padding.top,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (pageType != PageType.Itinerary)
          // The following collection is all in the if.
          // Maybe there's a less tricky solution
          // but I couldn't find any.
          ...[
          IconButton(
              onPressed: () => {Navigator.pushNamed(context, 'itinerary')},
              iconSize: Theme.of(context).iconTheme.size as double,
              icon: Icon(
                Icons.widgets_rounded,
                color: Theme.of(context).iconTheme.color,
              )),
          IconButton(
              onPressed: () async {
                final code = await FlutterBarcodeScanner.scanBarcode(
                    "#004297", "Zrušit", true, ScanMode.QR);
                // The widget we use, returns "-1" if the user pressed cancel.
                if (code != "-1") {
                  final route = AnimatableRoute(
                      builder: (context) => LoadedPage(code, true));
                  if(pageType == PageType.Home) {
                    Navigator.of(context).push(route);
                        } else {
                    Navigator.of(context).pushReplacement(route);
                  }
                }
              },
              iconSize: Theme.of(context).iconTheme.size as double,
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Theme.of(context).iconTheme.color,
              )),
        ],
        if (pageType == PageType.Itinerary)
          IconButton(
              onPressed: () => {Navigator.pop(context)},
              iconSize: Theme.of(context).iconTheme.size as double,
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              )),
      ],
    ),
  ];
}

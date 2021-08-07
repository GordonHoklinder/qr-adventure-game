import 'package:flutter/material.dart';
import 'package:qr_adventure_game/enums/page_type.dart';
import 'package:qr_adventure_game/widgets/navbar.dart';
import '../controllers/itinerary.dart';
import '../controllers/parser.dart';
import '../controllers/parser_funcs.dart';

/// The page which is scanned from a QR code.
class LoadedPage extends StatelessWidget {
  final String code;
  LoadedPage(this.code);

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      body: Stack(
        children: [
          /*Image.asset(
            'assets/detectivePhoto.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),*/
          Column(
            children: [...getNavbar(context, PageType.Loaded)],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // The subtracted number shall be bound to a variable
              // with size of the navbar.
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: parseCode(code),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

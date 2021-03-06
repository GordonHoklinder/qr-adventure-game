import 'package:flutter/material.dart';
import 'package:qr_adventure_game/enums/page_type.dart';
import 'package:qr_adventure_game/widgets/navbar.dart';

import '../controllers/parser.dart';
import '../controllers/parser_funcs.dart';

/// The page which is scanned from a QR code.
class LoadedPage extends StatelessWidget {
  final String code;
  final bool encrypted;

  LoadedPage(this.code, [this.encrypted = false]);

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [...getNavbar(context, PageType.Loaded)],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // The subtracted number shall be bound to a variable
              // with size of the navbar.
              height: MediaQuery.of(context).size.height - 120,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: parseCode(code, this.encrypted),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

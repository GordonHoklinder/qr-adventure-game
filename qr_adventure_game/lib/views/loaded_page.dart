import 'package:flutter/material.dart';

/// The page which is scanned from a QR code.
class LoadedPage extends StatelessWidget {
  final String code;
  LoadedPage(this.code);

  /// Return the widgets described in the QR code's code.
  Widget parseCode() {
    Widget ret =  Column();
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Here goes navigation bar.
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // The subtracted number shall be bound to a variable
              // with size of the navbar.
              height: MediaQuery.of(context).size.height - 50,
              child: parseCode(),
            ),
          ),
        ],
      ),
    );
  }
}

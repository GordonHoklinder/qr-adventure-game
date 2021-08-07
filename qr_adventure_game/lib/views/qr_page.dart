/*import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_adventure_game/routes/animatable_route.dart';
import 'package:qr_adventure_game/views/loaded_page.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';


class QrScanPage extends StatefulWidget {
  const QrScanPage({Key? key}) : super(key: key);

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  late BuildContext context;

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    this.context =context;
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: buildResult()
              )
            ],
          ),
        )
    );
  }


  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderLength: 20,
        borderRadius: 10,
        borderColor: Theme.of(context).primaryColor,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  /// if some barcode is detected this function will display the result
  Widget buildResult() {
    if(barcode != null){
      return IconButton(
          onPressed: ()=>{Navigator.pushReplacement(
              context,
              AnimatableRoute(builder: (context) => LoadedPage(barcode!.code))
          )},
          iconSize: Theme.of(context).iconTheme.size as double,
          icon: Icon(
            Icons.link_rounded,
            color: Theme.of(context).primaryColor,
          )
      );
      /*return Text(
        barcode!.code
      );*/
    }
    else {
      return Container(
        child: Text(
          'Naskenujte QR kód'
        )
      );
    }
  }


  /// here u save the barcode whenever camera detects some qr-code
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(
      (barcode) => setState(() => this.barcode = barcode)
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:qr_adventure_game/enums/page_type.dart';
import 'package:qr_adventure_game/widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Align(
        child: Image.asset(
          'assets/detectivePhoto.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [...getNavbar(context, PageType.Home)],
      )
    ]));
  }
}

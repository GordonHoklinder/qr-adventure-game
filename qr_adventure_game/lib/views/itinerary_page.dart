import 'package:flutter/material.dart';
import 'package:qr_adventure_game/enums/page_type.dart';
import 'package:qr_adventure_game/widgets/navbar.dart';

import '/controllers/itinerary.dart';

class ItineraryPage extends StatefulWidget {
  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  Widget createCard(String itemTitle) {
    return Card(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            itemTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
  }

  List<Widget> getListOfWidgets() {
    if (Itinerary.items.length == 0) {
      return [
        Align(
            alignment: Alignment.center,
            child: Text('Batoh je prázdný',
                style: Theme.of(context).textTheme.bodyText2))
      ];
    } else
      return Itinerary.items.map((item) => createCard(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // I think it should be only in the homepage.
        // TODO: some background color.
        /*Align(
            child: Image.asset(
              'assets/detectivePhoto.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),*/
        Align(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...getNavbar(context, PageType.Itinerary),
            Expanded(
              flex: 1,
              child: ListView(
                children: getListOfWidgets(),
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        )),
      ],
    ));
  }
}

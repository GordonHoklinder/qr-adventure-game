import 'package:flutter/material.dart';

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
      )
    );
  }

  List<Widget> getListOfWidgets(){
    if (Itinerary.items.length == 0){
      return [
        Align(
          alignment: Alignment.center,
          child: Text(
            'Inventář je prázdný',
            style: Theme.of(context).textTheme.bodyText2
          )
        )
      ];
    }
    else
      return Itinerary.items.map((item) => createCard(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (
        children: [
          Align(
            child: Image.asset(
              'assets/detectivePhoto.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.pop(context)},
                        iconSize: Theme.of(context).iconTheme.size as double,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).iconTheme.color,
                        )
                    ),
                  ],
                ),
                ListView(
                  children: getListOfWidgets(),
                  shrinkWrap: true,
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}

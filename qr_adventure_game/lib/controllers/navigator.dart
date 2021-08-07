import 'package:flutter/material.dart';

import '/views/home_page.dart';
import '/views/itinerary_page.dart';

Map<String, WidgetBuilder> navigation = {
  'home': (context) => HomePage(),
  'itinerary': (context) => ItineraryPage(),
};

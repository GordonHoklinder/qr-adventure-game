import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_adventure_game/controllers/itinerary.dart';

const delimiter = ",";

/// Save the items and visited pages into properties.
void saveItemsAsync() async {
  final properties = await SharedPreferences.getInstance();
  properties.setString('items', Itinerary.items.join(delimiter));
  properties.setString('visited', Itinerary.visited.join(delimiter));
}

/// Load the items and visited pages from properties.
void loadItemsAsync() async {
  final properties = await SharedPreferences.getInstance();
  if (properties.containsKey('items')) {
    final itemProps = properties.getString('items');
    if (itemProps != null) {
      Itinerary.items = HashSet.from(itemProps.split(delimiter));
    }
  }
  if (properties.containsKey('visited')) {
    final visitedProps = properties.getString('visited');
    if (visitedProps != null) {
      Itinerary.visited = HashSet.from(visitedProps.split(delimiter));
    }
  }
}

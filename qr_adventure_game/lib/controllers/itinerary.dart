import 'dart:collection';

import 'package:qr_adventure_game/controllers/preferences.dart';

/// Static class storing all visited pages and grabbed items.
class Itinerary {
  /// Visited pages.
  static HashSet<String> visited = HashSet<String>();

  /// Items in itinerary.
  static HashSet<String> items = HashSet<String>();

  /// True if the element is either a visited page or a item in itinerary.
  static bool contains(String item) {
    return items.contains(item) || visited.contains(item);
  }

  /// Add [item] to the set.
  /// If [isItem] is true, the set is [items], to [visited] otherwise.
  static void add(String item, bool isItem) {
    if (isItem) {
      items.add(item);
    } else {
      visited.add(item);
    }
    saveItemsAsync();
  }

  /// Remove [item] from [items].
  static void removeItem(String item) {
    items.remove(item);
    saveItemsAsync();
  }
}

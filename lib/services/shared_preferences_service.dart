import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferencesService spService = SharedPreferencesService._private();

class SharedPreferencesService {
  late SharedPreferences prefs;
  final controller = StreamController.broadcast();

  SharedPreferencesService._private();

  Future<void> setup() async {
    log('Setting Up - SharedPreferencesService');
    prefs = await SharedPreferences.getInstance();

    var searchHistory = prefs.getStringList('search_history');
    //log('History $searchHistory - SharedPreferencesService');

    controller.sink.add(searchHistory ?? '');
  }

  Stream getHistoryStream() {
    log('Listening to Stream - SharedPreferencesService');
    setup();
    return controller.stream;
  }

  Future<void> addHistory(String newItem) async {
    var newList = <String>[];

    if (prefs.getStringList('search_history') == null) {
      log('Search History - Empty');
      newList.add(newItem);
    } else {
      newList = prefs.getStringList('search_history')!;
      newList.insert(0, newItem);
    }

    if (newList.length > 10) {
      newList.removeLast();
    }

    log('Search History - Added $newItem');

    await prefs.setStringList('search_history', newList);
    controller.sink.add(prefs.getStringList('search_history'));
  }

  Future<void> clearHistory() async {
    await prefs.remove('search_history');
    controller.sink.add('');
  }
}

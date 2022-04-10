import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferencesService spService = SharedPreferencesService._private();

class SharedPreferencesService {
  late SharedPreferences prefs;
  final controller = StreamController.broadcast();

  SharedPreferencesService._private() {
    log('Yooo');
  }

  setup() async {
    log('Setting Up - SharedPreferencesService');
    prefs = await SharedPreferences.getInstance();

    var searchHistory = prefs.getStringList('search_history');
    log("History" + searchHistory.toString() + " - SharedPreferencesService");
    controller.sink.add(searchHistory ?? "");

    return searchHistory;
  }

  Stream getHistoryStream() {
    log('Listening to Stream - SharedPreferencesService');
    setup();
    return controller.stream;
  }

  addHistory(String newItem) async {
    var isEmpty = false;

    if (prefs.getStringList('search_history') == null) {
      isEmpty = true;
    } else {
      prefs.getStringList('search_history')!.add(newItem);
    }

    await prefs.setStringList('search_history',
        isEmpty ? [newItem] : prefs.getStringList('search_history')!);

    controller.sink.add(prefs.getStringList('search_history'));
  }

  clearHistory() async {
    await prefs.remove('search_history');
    controller.sink.add("");
  }
}

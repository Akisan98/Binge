import 'package:hive/hive.dart';

import '../models/db/media_content.dart';
import '../models/v1/tv_show.dart';
import 'database_helper.dart';

class V1ImportService {
  static Future<void> convertData() async {
    var box = Hive.box('myBox');
    final dbHelper = DatabaseHelper.instance;
    final shows = await dbHelper.queryAllShowsR();

    final data = shows.map((show) {
      var tmp = TVShow.fromDB(show);
      var item = MediaContent.fromv1(tmp);

      box.put('${item.type.toString()}_${item.tmdbId}', item);
    });
  }
}

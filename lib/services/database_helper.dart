import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/v1/tv_show.dart';

class DatabaseHelper {
  static const _databaseName = 'Binge_Data.db';
  static const _databaseVersion = 1;

  static const table = 'tv_shows';

  // Fields
  static const showID = 'show_id';
  static const title = 'show_title';
  static const poster = 'poster_path';
  static const backdrop = 'backdrop_path';
  static const summary = 'summary';
  static const runtime = 'show_runtime';
  static const firstAirDate = 'first_air_date';
  static const genre = 'show_genre';
  static const numberOfEpisodes = 'number_of_episodes';
  static const numberOfSeasons = 'number_of_seasons';
  static const seasons = 'seasons_lists';
  static const status = 'show_status';
  static const rating = 'show_rating';
  static const nextToWatch = 'next_watch';
  static const nextToAir = 'next_air';
  static const nextAirDate = 'next_air_date';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          $showID INTEGER PRIMARY KEY,
          $title TEXT NOT NULL,
          $poster TEXT,
          $backdrop TEXT,
          $summary TEXT,
          $runtime INTEGER,
          $firstAirDate TEXT,
          $genre TEXT,
          $numberOfEpisodes INTEGER,
          $numberOfSeasons INTEGER,
          $seasons TEXT,
          $status TEXT,
          $rating REAL,
          $nextToWatch TEXT,
          $nextToAir TEXT,
          $nextAirDate TEXT
        )
      ''');
  }

  queryAllShowsR() async {
    Database db = (await instance.database)!;
    var res = await db.query(table,
        orderBy:
            'show_title COLLATE NOCASE'); // Not to place Lower case a after Upper case Z
    var listen = res.isNotEmpty ? res.map((c) => c).toList() : [];

    return listen;
  }
}

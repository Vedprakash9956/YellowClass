import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/movie.dart';




class DatabaseHelper {
  static Database _database;
  String movieTable='movie_table';
  String colId='id';
  String movieName='movie_name';
  String colDirector='director';
  static DatabaseHelper _databaseHelper;
  DatabaseHelper.createInstance();
  factory DatabaseHelper(){
   if(_databaseHelper==null) {
    _databaseHelper = DatabaseHelper.createInstance();

   }
   return _databaseHelper;
  }
  Future<Database> get database async {
   if(_database==null){
    _database=await initializeDatabase();
   }
   return _database;
  }
  Future<Database>initializeDatabase() async{
   Directory directory=await getApplicationDocumentsDirectory();
   String path=directory.path+'movie.db';
   var movieDatabase=await openDatabase(path,version: 1,onCreate: _createDb);
   return movieDatabase;
  }

  void _createDb(Database db,int newVersion) async{
   await db.execute('CREATE TABLE $movieTable($colId INTEGER PRIMARY KEY'
       ' AUTOINCREMENT,$movieName TEXT $colDirector TEXT)');
  }
  Future<List<Map<String,dynamic>>>getMovieMapList() async {
   Database db=await this.database;

   var result= await db.query(movieTable);
   return result;
  }
  Future<int> insertMovie(Movie movie) async {
   Database db = await this.database;
   var result = await db.insert(movieTable, movie.toMap());
   return result;
  }
  Future<int> updateMovie(Movie movie) async {
   var db = await this.database;
   var result = await db.update(movieTable, movie.toMap(),
       where: '$colId = ?', whereArgs: [movie.id]);
   return result;
  }
  Future<int> deleteMovie(int id) async {
   var db = await this.database;
   int result = await db.rawDelete('DELETE FROM $movieTable '
       'WHERE $colId = $id');
   return result;
  }
  Future<List<Movie>> getMovieList() async {

   var movieMapList = await getMovieMapList();
   int count = movieMapList.length;

   List<Movie> movieList = List<Movie>();

   for (int i = 0; i < count; i++) {
    movieList.add(Movie.fromMapObject(movieMapList[i]));
   }

   return movieList;
  }

}


import 'dart:async';
import 'package:flutter_app/models/movie.dart';
import 'package:flutter_app/helper/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screen/Movie_detail.dart';

class MovieList extends StatefulWidget{

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Movie> movieList;
  int count = 0;

  Widget build(BuildContext context) {
    // TODO: implement build
    if (movieList == null) {
      movieList = List<Movie>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Watched Movie List"),
      ),
      body: getMovieListView(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToDetail(Movie('', ''), "Add Movie");
          },
          child: Icon(Icons.add),
          tooltip: "Add Movie"
      ),
    );
  }

  ListView getMovieListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.greenAccent,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.movie),
              backgroundColor: Colors.yellow,
            ),
            title: Text(this.movieList[position].moviename),
            subtitle: Text(this.movieList[position].director,
            style: TextStyle(color: Colors.black),),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _delete(context, movieList[position]);
              },
            ),
            onTap: () {
              navigateToDetail(this.movieList[position], "Edit Movie");
            },
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, Movie movie) async {
    int result = await databaseHelper.deleteMovie(movie.id);
    if (result != 0) {
      _showSnackBar(context, 'Movie Deleted Successfully');
    }
  }

  void navigateToDetail(Movie movie, String title) async {
      bool result=await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
      return MovieDetail(movie, title);
    }));
      if(result==true)
        {
          updateListView();
        }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Movie>> movieListFuture = databaseHelper.getMovieList();
      movieListFuture.then((movieList) {
        setState(() {
          this.movieList = movieList;
          this.count = movieList.length;
        });
      });
    });
  }
}

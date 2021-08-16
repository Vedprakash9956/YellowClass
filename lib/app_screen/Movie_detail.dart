

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/database.dart';
import 'dart:async';
import 'package:flutter_app/models/movie.dart';
class MovieDetail extends StatefulWidget{
 final String appBarTitle;
  final Movie movie;
  MovieDetail(this.movie,this.appBarTitle);
  @override
  MovieDetailState createState() => MovieDetailState(this.movie, this.appBarTitle);
}

 class MovieDetailState extends State<MovieDetail> {
  String appBarTitle;
  Movie movie;
  TextEditingController nameController=TextEditingController();
  TextEditingController directorController=TextEditingController();
  MovieDetailState(this.movie, this.appBarTitle);
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build;
    nameController.text=movie.moviename;
    directorController.text=movie.director;
    return  Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 15),
        child: ListView(
          children: <Widget>[
           Padding(
               padding:EdgeInsets.all(15.0),
             child: TextField(
               controller: nameController,
               onChanged: (value){
                 updateName();
                 },
               decoration: InputDecoration(
                 labelText: "Movie Name",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0)
                 )
               ),
             ),

           ),
            Padding(
              padding:EdgeInsets.all(15.0),
              child: TextField(
                controller: directorController,
                onChanged: (value){
                    updateDirector();
                },
                decoration: InputDecoration(
                    labelText: "Director Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(child:
                  ElevatedButton(
                      onPressed: (){
                          setState(() {
                            _save();
                          });

                      },

                    child: Text("Save",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  )
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Expanded(child:
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _delete();
                      });

                    },

                    child: Text("Delete",
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  )
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
  void updateName(){
    movie.moviename = nameController.text;
  }
  void updateDirector() {
    movie.director = directorController.text;
  }
  void _save() async {
    moveToLastScreen();
    int result=0;
    if (movie.id != null) {
      result = await helper.updateMovie(movie);
    } else {
      result = await helper.insertMovie(movie);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    }
    else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }


  }
  void _delete() async {

 moveToLastScreen();


    if (movie.id == null) {
      _showAlertDialog('Status', 'No Movie was deleted');
      return;
    }


    int result = await helper.deleteMovie(movie.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting ');
    }
  }


  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }


 }
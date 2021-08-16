import 'package:flutter/material.dart';
import 'package:flutter_app/app_screen/Movie_list.dart';

import 'app_screen/Movie_detail.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "YellowClass Assignment",
      home: MovieList()
    )
  );
}
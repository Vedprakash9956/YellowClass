
import "dart:ui";

import"package:flutter/material.dart";
void main()
{

  runApp(MaterialApp(
   title: "home",
    home: HomePage(),
  )
  );
}
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Bar",
        ),
        ),
        body: Container(
      child: Center( child: Text(
          "This is the Center of Container"
      )
      ),

      ),
    );
  }

}
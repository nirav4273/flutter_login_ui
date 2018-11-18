import "package:flutter/material.dart";
import "Login.dart";
void main(){
  runApp(MainPage());
}

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Login",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Login();
  }
}
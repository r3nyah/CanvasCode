import 'package:flutter/material.dart';
import './Src/Screen/Page.dart';

void main(){
  runApp(const MyApp());
}

const Color kCanvasColor = Color(0xff222a3d);
const String kGithubRep = 'https://github.com/r3nyah/';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Online',color: Colors.grey.shade900,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const DrawingPage(),
    );
  }
}

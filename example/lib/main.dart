import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom progress Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BottomLoader bl;

  showMainBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Container(child: Text('Hello'),);
    });
  }

  @override
  Widget build(BuildContext context) {
     bl = new BottomLoader(context, showLogs: true,isDismissible: false,);
            bl.style(message: 'Please wait...',);
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Loading'),),
          body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Show bottom loader'),
            onPressed: () {
           bl.display();

           //navigating to next page after 5 seconds
           Future.delayed(Duration(seconds: 5)).whenComplete((){
             bl.close();

             Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text('Second Screen')),)));
           });

          }),
        ),
      ),
    );
  }
}

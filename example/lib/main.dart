import 'dart:async';

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

class MyHomePage extends StatelessWidget {
  BottomLoader bl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Loader'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
              child: Text('Show bottom loader'),
              onPressed: () {
                bl = new BottomLoader(
                  context,
                  showLogs: true,
                  isDismissible: true,
                );
                bl.style(
                  message: 'Please wait...',
                );

                bl.display();

                //navigating to next page after 5 seconds
                Future.delayed(Duration(seconds: 5)).whenComplete(() {
                  bl.close();

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SecondScreen()));
                });
              }),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Loader Sample'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(child: Text('Second Screen')),
    );
  }
}

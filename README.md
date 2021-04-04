# bottom_loader

A light weight package to show loader using bottom modal sheet. As it is a stateful widget, you can change the text shown on the bottom sheet dynamically.

[![](https://img.shields.io/badge/dontate-Buy%20Me%20a%20Coffee-blueviolet)](https://www.buymeacoffee.com/5zeFDGT) &nbsp; 
[![LinkedIn](https://img.shields.io/badge/LinkedIn-in-0e76a8)](https://www.linkedin.com/in/akshay-a-s-037109134/) &nbsp; [![Get the library](https://img.shields.io/badge/Get%20library-pub-blue)](https://pub.dev/packages/bottom_loader) &nbsp; [![Example](https://img.shields.io/badge/Example-Ex-success)](https://pub.dev/packages/bottom_loader#-example-tab-)



## Supported Dart Versions
**Dart SDK version >= 2.12.0**


## Demo

<img src="https://raw.githubusercontent.com/akshay512/bottom_loader/master/example/sample/sample.gif" height="35%" width="35%"  alt="Bottom Loader Demo"/>  


## Installation
[![Pub](https://img.shields.io/badge/pub-2.0.3-blue)](https://pub.dev/packages/bottom_loader)

Add the Package
```yaml
dependencies:
  bottom_loader: ^0.2.0
```

## How to use



Import the package in your dart file

```dart
import 'package:bottom_loader/bottom_loader.dart';
```
Create an instance of BottomLoader
```dart
BottomLoader bl;
```

Initialise the **bl** object inside the **build()** method passing context to it

<ol>
<li> Initialize the Bottom Loader object <br>  

```dart
bl = new BottomLoader(context);
```
</li>


<li> By default it will show a bottom loader with loader as CircularProgressIndicator but you can specify<b>custom loader widget</b>  and specify if you want your bottom loader to dismiss when back button is pressed <b>isDismissible</b> parameter (Optional) <br/>

```dart
//For bottom loader
//loader aceepts any custom widget as loader
bl = new BottomLoader(context, isDismissible: true/false, showLogs: true/false,loader: CircularProgressIndicator());
    
```
</li>

  
<li>Style the bottom loading sheet (Optional)<br/>

```dart
bl.style(
  message: 'Loading File...',
  backgroundColor: Colors.white,
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
```
```note
Note: You don't need to use all parameters, all of them are optional
```

</li>

<li>Showing the bottom loader<br>
  
```dart
await bl.show();
```
</li>



<li>
Dismissing the bottom loader<br/>
  
```dart
bl.close().then((isHidden) {
  print(isHidden);
});
```

</li>  

</ol>



### Want to contribute? 
Pull requests and issues are always welcome!

#### How to contribute?
<ol>
  <li> Fork the <a href="https://github.com/akshay512/bottom_loader">repository</a></li>
  <li> Clone it to your local machine </li>
  <li> Open the project in your favourite editor </li>  
  <li> Open cmd/terminal and run <b>flutter clean</b> and then <b>flutter packages get</b> </li>
  <li> Make the changes </li>
  <li> Create a <b>Pull Request</b> </li>
</ol>

#### View the issues [here](https://github.com/akshay512/bottom_loader/issues)

#### This library is only tested for Android, iOS contributors are most welcome
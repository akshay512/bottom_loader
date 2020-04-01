library bottom_loader;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BottomLoadingType { Normal, Download }

String _loadingMessage = "Loading...";
double _progress = 0.0, _maxProgress = 100.0;

bool _isShowing = false;
BuildContext _context, _dismissingContext;
BottomLoadingType _bottomLoadingType;
bool _barrierDismissible = true, _showLogs = false;

TextStyle _progressTextStyle = TextStyle(
        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    _messageStyle = TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600);

Color _backgroundColor = Colors.white;
Widget _loadingWidget = CircularProgressIndicator();
ShapeBorder _shapeBorder;

class BottomLoader {
  _Body _bottomloader;

  BottomLoader(BuildContext context,
      {bool isDismissible, bool showLogs, Widget loader, ShapeBorder shape}) {
    _context = context;
    _loadingWidget = loader ?? CircularProgressIndicator();
    _bottomLoadingType = BottomLoadingType.Normal;
    _barrierDismissible = isDismissible ?? true;
    _showLogs = showLogs ?? false;
    _shapeBorder = shape ?? RoundedRectangleBorder();
  }

  void style(
      {double progress,
      double maxProgress,
      String message,
      Widget progressWidget,
      Color backgroundColor,
      TextStyle progressTextStyle,
      TextStyle messageTextStyle,
      double elevation,
      // double borderRadius,
      Curve insetAnimCurve}) {
    if (_isShowing) return;
    if (_bottomLoadingType == BottomLoadingType.Download) {
      _progress = progress ?? _progress;
    }

    _loadingMessage = message ?? _loadingMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _loadingWidget = progressWidget ?? _loadingWidget;
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;
  }

  void update(
      {double progress,
      double maxProgress,
      String message,
      Widget progressWidget,
      TextStyle progressTextStyle,
      TextStyle messageTextStyle}) {
    if (_bottomLoadingType == BottomLoadingType.Download) {
      _progress = progress ?? _progress;
    }

    _loadingMessage = message ?? _loadingMessage;
    _maxProgress = maxProgress ?? _maxProgress;
    _loadingWidget = progressWidget ?? _loadingWidget;
    _messageStyle = messageTextStyle ?? _messageStyle;
    _progressTextStyle = progressTextStyle ?? _progressTextStyle;

    if (_isShowing) _bottomloader.update();
  }

  bool isShowing() {
    return _isShowing;
  }

  void close() {
    if (_isShowing) {
      try {
        _isShowing = false;
        if (Navigator.of(_dismissingContext).canPop()) {
          Navigator.of(_dismissingContext).pop();
          if (_showLogs) debugPrint('BottomLoader closed');
        } else {
          if (_showLogs) debugPrint('Cant close bottom loader');
        }
      } catch (_) {}
    } else {
      if (_showLogs) debugPrint('Bottom loader already closed');
    }
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop(true);
        if (_showLogs) debugPrint('BottomLoader dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('BottomLoader already dismissed');
      return Future.value(false);
    }
  }

  Future<bool> display() async {
    if (!_isShowing) {
      try {
        _bottomloader = new _Body();
        showModalBottomSheet<dynamic>(
          context: _context,
          isDismissible: false,
          isScrollControlled: true,
          shape: _shapeBorder,
          builder: (BuildContext context) {
            _dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Container(child: _bottomloader),
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(Duration(milliseconds: 200));
        if (_showLogs) debugPrint('BottomLoader displayed');
        _isShowing = true;
        return true;
      } catch (_) {
        return false;
      }
    } else {
      if (_showLogs) debugPrint("BottomLoader already displayed");
      return false;
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  _BodyState _bottomloading = _BodyState();

  update() {
    _bottomloading.update();
  }

  @override
  State<StatefulWidget> createState() {
    return _bottomloading;
  }
}

class _BodyState extends State<_Body> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('BottomLoader was dismissed by back button');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(children: <Widget>[
        const SizedBox(width: 10.0),
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: _loadingWidget,
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: _bottomLoadingType == BottomLoadingType.Normal
              ? Text(_loadingMessage,
                  textAlign: TextAlign.justify, style: _messageStyle)
              : Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(_loadingMessage, style: _messageStyle),
                      top: 30.0,
                    ),
                    Positioned(
                      child: Text("$_progress/$_maxProgress",
                          style: _progressTextStyle),
                      bottom: 10.0,
                      right: 10.0,
                    ),
                  ],
                ),
        ),
        const SizedBox(width: 10.0)
      ]),
    );
  }
}

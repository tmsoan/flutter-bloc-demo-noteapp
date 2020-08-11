
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fading_circle.dart';

class ProgressHub {
  OverlayEntry _overlayEntry;

  final _progressBoundSize = 85.0;

  bool _isShow = false;
  bool get isShow => _isShow;

  void show(BuildContext context) {
    if (context == null) return;
    _overlayEntry = _createdProgressEntry(context);
    Overlay.of(context).insert(_overlayEntry);
    _isShow = true;
  }

  void hide() {
    if (!_isShow)
      return;
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
    _isShow = false;
  }

  OverlayEntry _createdProgressEntry(BuildContext context) =>
      OverlayEntry(
          builder: (BuildContext context) =>
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.black26.withOpacity(0.2),
                  ),
                  Positioned(
                    top: (MediaQuery.of(context).size.height / 2) - (_progressBoundSize / 2),
                    left: (MediaQuery.of(context).size.width / 2) - (_progressBoundSize / 2),
                    child: Container(
                      width: _progressBoundSize,
                      height: _progressBoundSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.black45
                      ),
                      child: Center(
                        child: FadingCircle(
                          size: _progressBoundSize / 2,
                          color: Colors.white70,
                        ),
                      )
                    ),
                  )
                ],
              )
      );
}
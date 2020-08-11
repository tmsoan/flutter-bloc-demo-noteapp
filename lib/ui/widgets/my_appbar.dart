import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget child;
  final Color backgroundColor;
  final double elevation;
  final double height;

  @override
  Size preferredSize;

  MyAppBar({
    Key key,
    @required this.child,
    this.backgroundColor,
    this.elevation,
    this.height,
  }) : preferredSize = (height != null) ? Size.fromHeight(height) : Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    return Material(
      color: widget.backgroundColor ?? Colors.white,
      elevation: widget.elevation
          ?? appBarTheme.elevation
          ?? 1.0,
      child: SafeArea(
        child: widget.child,
      ),
    );
  }
}
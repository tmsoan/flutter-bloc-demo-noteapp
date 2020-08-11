import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'resources.dart';
class MyDialog{

  static showSingleBtnDialog({BuildContext context, String title, String msg, String btnMsg, String screen, Function onPress}){
    Widget dl = WillPopScope(
      child: CupertinoAlertDialog(
        title: title != null ? new Text(title) : null,
        content: new Text(msg),
        actions: [
          CupertinoDialogAction(
              onPressed: onPress != null ? onPress : () {Navigator.of(context).pop();},
              isDefaultAction: true,
              child: new Text(btnMsg != null ? btnMsg : AppStrings.btnOk)),
        ],
      ),
      onWillPop: () => null,
    );
    showDialog(context: context, child: dl, barrierDismissible: false);
  }

  static void showTwoBtnDialog(BuildContext context, {String title, String msg, String btn1Text, String btn2Text, Function onBtn1Press, Function onBtn2Press}) {
    Widget dl = WillPopScope(
      child: CupertinoAlertDialog(
        title: title != null ? new Text(title) : null,
        content: new Text(msg),
        actions: [
          CupertinoDialogAction(
              onPressed: onBtn1Press,
              isDefaultAction: true,
              child: new Text(btn1Text)),
          CupertinoDialogAction(
            child: Text(btn2Text),
            onPressed: onBtn2Press,
          )
        ],
      ),
      onWillPop: () => null, // avoid BACK press on Android
    );
    showDialog(context: context, child: dl, barrierDismissible: false);
  }


  static void showInputPasscodeDialog(BuildContext context, {String title, String msg, Function onCancelPress, Function(String value) onOKPress, TextEditingController controller}) {
    Widget dl = WillPopScope(
      child: CupertinoAlertDialog(
        title: title != null ? new Text(title) : null,
        content: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(msg),
                Container(height: 15,),
                Material(
                  color: Colors.transparent,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5.0),
                        ),
                      ),
                      hintText: 'Enter Passcode',
                      contentPadding: EdgeInsets.all(2)
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    obscureText: true,
                  ),
                ),
              ],
            )
          )
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(AppStrings.cancel),
            onPressed: onCancelPress,
          ),
          CupertinoDialogAction(
            child: Text(AppStrings.btnOk),
            isDefaultAction: true,
            onPressed: () {
              if (controller.text.length > 0) {
                onOKPress(controller.text);
              }
            },
          )
        ],
      ),
      onWillPop: () => null, // avoid BACK press on Android
    );
    showDialog(context: context, child: dl, barrierDismissible: false);
  }
}
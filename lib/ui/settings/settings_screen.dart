import 'package:en_notes/UI/Widgets/my_appbar.dart';
import 'package:en_notes/app_routes.dart';
import 'package:en_notes/app_session.dart';
import 'package:en_notes/common/constant.dart';
import 'package:en_notes/common/my_dialog.dart';
import 'package:en_notes/common/widget_styles.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _buildSettingsItem(SettingsType.Theme),
              _buildDivider(),
              _buildSettingsItem(SettingsType.Notification),
              _buildDivider(),
              _buildSettingsItem(SettingsType.Develop),
              _buildDivider(),
              _buildSettingsItem(SettingsType.Logout),
            ],
          ),
        )
      )
    );
  }

  Widget _buildSettingsItem(SettingsType settingsType) {
    return InkWell(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 52.0,
              height: 52.0,
              child: Icon(settingsType.icon, size: Constant.settings_icon_size, color: settingsType.color,)
            ),
            Text(settingsType.string, style: MyTextStyle.settingsText,),
            Expanded(child: Container(),),
            Visibility(
              visible: settingsType == SettingsType.Logout ? false : true,
              child: Icon(Icons.keyboard_arrow_right, size: 22, color: Colors.black38,),
            ),
            SizedBox(width: 8,),
          ],
        ),
      ),
      onTap: () {
        if (settingsType == SettingsType.Notification) {
          MyDialog.showTwoBtnDialog(context,
              title: 'Alert',
              msg: 'Stop all notifications?',
              btn1Text: 'No',
              btn2Text: 'Yes',
              onBtn1Press: () => Navigator.of(context).pop(),
              onBtn2Press: () {
                Navigator.of(context).pop();
                AppSession.get().stopAllNotifications();
              });
        }
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: 52.0),
      child: Divider(height: 0.0,),
    );
  }
}

enum SettingsType {
  Theme,
  Notification,
  Logout,
  Develop,
  None
}

extension ExContentType on SettingsType {
  String get string {
    switch(this) {
      case SettingsType.Theme:
        return 'Theme';
      case SettingsType.Notification:
        return 'Notifications';
      case SettingsType.Logout:
        return 'Logout';
      case SettingsType.Develop:
        return 'Develop';
      default:
        return '';
    }
  }

  IconData get icon {
    switch(this) {
      case SettingsType.Theme:
        return Icons.invert_colors;
      case SettingsType.Notification:
        return Icons.notifications_none;
      case SettingsType.Logout:
        return Icons.power_settings_new;
      case SettingsType.Develop:
        return Icons.developer_mode;
      default:
        return null;
    }
  }

  Color get color {
    switch(this) {
      case SettingsType.Theme:
        return Colors.green[400];
      case SettingsType.Notification:
        return Colors.deepOrange;
      case SettingsType.Logout:
        return Colors.black45;
      case SettingsType.Develop:
        return Colors.blueGrey;
      default:
        return null;
    }
  }
}
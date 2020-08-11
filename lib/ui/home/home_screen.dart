import 'package:en_notes/app_routes.dart';
import 'package:en_notes/app_session.dart';
import 'package:en_notes/bloc/home/home_bloc.dart';
import 'package:en_notes/bloc/home/home_event.dart';
import 'package:en_notes/bloc/home/home_state.dart';
import 'package:en_notes/common/constant.dart';
import 'package:en_notes/common/my_dialog.dart';
import 'package:en_notes/common/resources.dart';
import 'package:en_notes/common/widget_styles.dart';
import 'package:en_notes/ui/home/add_word_widget.dart';
import 'package:en_notes/ui/home/home_listview_item.dart';
import 'package:en_notes/ui/progress_hub/progress_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Widgets/my_appbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }

  static provider(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: HomeScreen(),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;
  ProgressHub _progressHub;
  var _isInitStated = false;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _progressHub = ProgressHub();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitStated) {
      _isInitStated = true;
      _loadData();
    }
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          state.isShowLoading ? _progressHub.show(context) : _progressHub.hide();
        }
        if (state is HomeShowUserDataState) {
          setState(() {});
        }
        if (state is HomeLoadDataErrorState) {
          MyDialog.showSingleBtnDialog(context: context, msg: state.error);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body:_buildPageContent(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddBottomSheet();
          },
          child: Icon(Icons.add,),
          backgroundColor: AppColors.app_color,
        ),
      )
    );
  }

  Widget _buildAppBar() {
    return MyAppBar(
      backgroundColor: AppColors.app_color,
      child: Container(
        child: Stack(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(width: 8.0,),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search, size: Constant.appbar_icon_size, color: Colors.white,),
                          onPressed: () {
                            _homeBloc.add(HomeShowLoadingEvent(true));
                            Future.delayed(Duration(milliseconds: 1000), () {
                              _homeBloc.add(HomeShowLoadingEvent(false));
                            });
                          },
                        ),
                        SizedBox(width: 8.0,),
                        Text('Search words...', style: MyTextStyle.searchText,)
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.sort, size: Constant.appbar_icon_size, color: Colors.white),
                    onPressed: () {
                      AppSession.get().scheduleNotification();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, size: Constant.appbar_icon_size, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoute.settingsScreen);
                    },
                  ),
                  SizedBox(width: 8.0,),
                ],
              ),
              Center(
                child: Container(),
              ),
            ]
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (_homeBloc.usersDataResponse?.words != null) {
            final word = _homeBloc.usersDataResponse?.words[index];
            return HomeListItemWidget(word, (word) {
              _homeBloc.add(HomeDeleteItemEvent(word));
            });
          }
          return Container();
        },
        itemCount: _homeBloc.usersDataResponse?.words?.length ?? 0,
      ),
    );
  }

  void _showAddBottomSheet() {
    showBarModalBottomSheet(
      context: context,
      builder: (context, scrollController) {
        return AddNewWordWidget.provider(context);
      },
      bounce: false,
      duration: Duration(milliseconds: 200),
      isDismissible: false,
      expand: true
    ).then((result) {
      if (result == Constant.result_reload_page) {
        _loadData();
      }
    });
  }

  void _loadData() {
    _homeBloc.add(HomeLoadDataEvent());
  }
}
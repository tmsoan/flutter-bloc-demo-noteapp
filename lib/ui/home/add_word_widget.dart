import 'package:en_notes/bloc/add/add_bloc.dart';
import 'package:en_notes/bloc/add/add_event.dart';
import 'package:en_notes/bloc/add/add_state.dart';
import 'package:en_notes/bloc/home/home_bloc.dart';
import 'package:en_notes/bloc/home/home_event.dart';
import 'package:en_notes/bloc/home/home_state.dart';
import 'package:en_notes/common/constant.dart';
import 'package:en_notes/common/my_dialog.dart';
import 'package:en_notes/common/resources.dart';
import 'package:en_notes/common/widget_styles.dart';
import 'package:en_notes/model/word.dart';
import 'package:en_notes/repository/data_repsitory.dart';
import 'package:en_notes/ui/progress_hub/progress_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewWordWidget extends StatefulWidget {
  AddNewWordWidget({Key key}) : super(key: key);

  @override
  _AddNewWordWidgetState createState() {
    return _AddNewWordWidgetState();
  }

  static provider(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWordBloc(),
      child: AddNewWordWidget(),
    );
  }
}

class _AddNewWordWidgetState extends State<AddNewWordWidget> {
  AddWordBloc _addBloc;
  final _progressHub = ProgressHub();
  final FocusNode _keyWordFocus = FocusNode();
  final FocusNode _valueWordFocus = FocusNode();
  String _newKeyWord = "";
  String _valueWord = "";
  bool _enableNotify = false;

  Word _word;
  bool _ableToSubmit = false;

  @override
  void initState() {
    super.initState();
    _addBloc = BlocProvider.of<AddWordBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _addBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWordBloc, AddWordState>(
      listener: (context, state) {
        if (state is AddShowLoadingState) {
          state.isShowLoading ? _progressHub.show(context) : _progressHub.hide();
        }
        if (state is AddNewWordSuccessState) {
          Navigator.of(context).pop(Constant.result_reload_page);
        }
        if (state is AddErrorState) {
          MyDialog.showSingleBtnDialog(context: context, msg: state.error);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Material(
          child: Container(
            //height: 500,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancel',),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                        child: Text('Add word', style: MyTextStyle.addTitle, textAlign: TextAlign.center,)
                    ),
                    FlatButton(
                      child: Text('',),
                      onPressed: null,
                    ),
                  ],
                ),
                Divider(height: 0,),
                Container(
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('New word(s):', textAlign: TextAlign.start, style: MyTextStyle.addTextTitle,),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a new item...'
                          ),
                          maxLines: 3,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          focusNode: _keyWordFocus,
                          onSubmitted: (_) {
                            _keyWordFocus.unfocus();
                            FocusScope.of(context).requestFocus(_valueWordFocus);
                          },
                          onChanged: (value) {
                            _newKeyWord = value;
                            _checkSubmitEnable();
                          },
                        ),
                        SizedBox(height: 16,),
                        Text('What is it?', textAlign: TextAlign.start, style: MyTextStyle.addTextTitle),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter the meaning...'
                          ),
                          maxLines: 3,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          focusNode: _valueWordFocus,
                          onSubmitted: (_) {
                            _keyWordFocus.unfocus();
                          },
                          onChanged: (value) {
                            _valueWord = value;
                            _checkSubmitEnable();
                          },
                        ),
                        SizedBox(height: 16,),
                        Row(
                          children: <Widget>[
                            Text('Enable notification?', textAlign: TextAlign.start, style: MyTextStyle.addTextTitle),
                            Expanded(child: Container(),),
                            CupertinoSwitch(
                              value: _enableNotify,
                              onChanged: (value) {
                                setState(() {
                                  _enableNotify = value;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                  width: 500,
                  height: 48,
                  margin: EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: Text('Submit', style: MyTextStyle.btnTitle,),
                    onPressed: () {
                      if (_ableToSubmit) {
                        _word = Word(key: _newKeyWord, value: _valueWord);
                        _addBloc.add(AddNewItemEvent(_word));
                      }
                    },
                    elevation: 0.8,
                    color: _ableToSubmit ? AppColors.app_color : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
              ],
            ),
          ),
        ),
      )
    );
  }

  _checkSubmitEnable() {
    if (_newKeyWord.trim().length > 0 && _valueWord.trim().length > 0) {
      if (!_ableToSubmit) {
        setState(() {
          _ableToSubmit = true;
        });
      }
    } else {
      if (_ableToSubmit) {
        setState(() {
          _ableToSubmit = false;
        });
      }
    }
  }
}
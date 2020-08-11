import 'package:en_notes/common/resources.dart';
import 'package:en_notes/common/widget_styles.dart';
import 'package:en_notes/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

typedef OnDeletedItem = Function(Word word);

class HomeListItemWidget extends StatelessWidget {
  Word _word;
  OnDeletedItem _onDeletedItem;
  final SlidableController _slidableController = SlidableController();

  HomeListItemWidget(this._word, this._onDeletedItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(_word.key),
      controller: _slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 56,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.arrow_right, size: 12, color: Colors.black),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * .80,
                                  child: Text(
                                    _word.key,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyTextStyle.listItemKey,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.lightGreen,
                                  ),
                                  height: 8,
                                  width: 8,
                                ),
                              ]
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            _word.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyTextStyle.listItemValue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                height: 0.15,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: () {
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _onDeletedItem(_word);
          },
        ),
      ],
    );
  }
}

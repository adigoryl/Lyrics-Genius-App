import 'package:lyricsflutterapp/utils/direct_select/direct_select_item.dart';
import 'package:lyricsflutterapp/utils/direct_select/direct_select_list.dart';
import 'package:flutter/material.dart';

class ListSelector extends StatelessWidget {
  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);

  final List<String> data;
  final String label;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int iconCode;

  ListSelector({@required this.data, @required this.label, this.iconCode, @required this.scaffoldKey});

  String selectedItemName = "None";

  String getSelectedItem(){
    return this.selectedItemName;
  }

  void setSelectedItem(String v){
    this.selectedItemName = v;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(label)),
        Padding(
          padding: buttonPadding,
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                            IconData(iconCode, fontFamily: 'MaterialIcons'),
                            color: Color(0xFF1eb2a6)
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            child: DirectSelectList<String>(
                              onUserTappedListener:
                                  () {
                                _showScaffold();
                              },
                              values: data,
                              defaultItemIndex: 0,
                              itemBuilder: (String value) =>
                                  getDropDownMenuItem(value),
                              focusedItemDecoration: _getDslDecoration(),
                            ),
                            padding: EdgeInsets.only(left: 12)
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: _getDropdownIcon(),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          setSelectedItem(value);
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Color(0xFF1eb2a6),
    );
  }

  void _showScaffold() {
    final snackBar = SnackBar(content: Text('Hold and drag instead of tap'));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

//class ListSelector extends StatefulWidget {
//  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);
//
//  final List<String> data;
//  final String label;
//  final GlobalKey<ScaffoldState> scaffoldKey;
//  final int iconCode;
//
//  ListSelector(
//      {Key key,
//        @required this.data,
//        @required this.label,
//        this.iconCode,
//        @required this.scaffoldKey}) : super(key: key);
//
//  @override
//  ListSelectorState createState() => ListSelectorState();
//  String selectedItemName = "None";
//
//  String getSelectedItem() {
//    return this.selectedItemName;
//  }
//
//  void setSelectedItem(String v) {
//    this.selectedItemName = v;
//  }
//}
//class ListSelectorState extends State<ListSelector> {
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: [
//        Container(
//            alignment: AlignmentDirectional.centerStart,
//            margin: EdgeInsets.only(left: 4),
//            child: Text(widget.label)),
//        Padding(
//          padding: widget.buttonPadding,
//          child: Container(
//            decoration: _getShadowDecoration(),
//            child: Card(
//                child: Row(
//                  mainAxisSize: MainAxisSize.max,
//                  children: <Widget>[
//                    Container(
//                      child: Padding(
//                        padding: EdgeInsets.only(left: 12),
//                        child: Icon(
//                            IconData(widget.iconCode, fontFamily: 'MaterialIcons'),
//                            color: Color(0xFF1eb2a6)
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                        child: Padding(
//                            child: DirectSelectList<String>(
//                              onUserTappedListener:
//                                  () {
//                                _showScaffold();
//                              },
//                              values: widget.data,
//                              defaultItemIndex: 0,
//                              itemBuilder: (String value) =>
//                                  getDropDownMenuItem(value),
//                              focusedItemDecoration: _getDslDecoration(),
//                            ),
//                            padding: EdgeInsets.only(left: 12)
//                        )
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(right: 8),
//                      child: _getDropdownIcon(),
//                    )
//                  ],
//                )),
//          ),
//        ),
//      ],
//    );
//  }
//
//  DirectSelectItem<String> getDropDownMenuItem(String value) {
//    return DirectSelectItem<String>(
//        itemHeight: 56,
//        value: value,
//        itemBuilder: (context, value) {
//          widget.setSelectedItem(value);
//          return Text(value);
//        });
//  }
//
//  _getDslDecoration() {
//    return BoxDecoration(
//      border: BorderDirectional(
//        bottom: BorderSide(width: 1, color: Colors.black12),
//        top: BorderSide(width: 1, color: Colors.black12),
//      ),
//    );
//  }
//
//  BoxDecoration _getShadowDecoration() {
//    return BoxDecoration(
//      boxShadow: <BoxShadow>[
//        new BoxShadow(
//          color: Colors.black.withOpacity(0.06),
//          spreadRadius: 4,
//          offset: new Offset(0.0, 0.0),
//          blurRadius: 15.0,
//        ),
//      ],
//    );
//  }
//
//  Icon _getDropdownIcon() {
//    return Icon(
//      Icons.unfold_more,
//      color: Color(0xFF1eb2a6),
//    );
//  }
//
//  void _showScaffold() {
//    final snackBar = SnackBar(content: Text('Hold and drag instead of tap'));
//    widget.scaffoldKey.currentState.showSnackBar(snackBar);
//  }
//}
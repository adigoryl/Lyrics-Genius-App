import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

// From link below:
//https://github.com/HussainTaj-W/flutter-package-selection_menu-example/tree/master/lib

class CustomSearchingIndicatorComponent extends SearchingIndicatorComponent with ComponentLifeCycleMixin {
  AnimationController _animationController;

  CustomSearchingIndicatorComponent() {
    super.builder = _builder;
  }

  Widget _builder(SearchingIndicatorComponentData data) {
    _animationController ??= AnimationController(
      vsync: data.tickerProvider,
      duration: Duration(seconds: 2),
    );
    _animationController.repeat();

    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Icon(Icons.search, color: Color(0xFF1eb2a6)),
      ),
    );
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.dispose();
      _animationController = null;
    }
  }

  @override
  void init() {}
}

// ###########################################################################
//       MAIN CLASS STARTS HERE
// ###########################################################################

class SearchSelectMenu extends StatelessWidget {
  final List<String> itemsList;
  final String selectionLabel;
  final int iconCode;

  SearchSelectMenu({
    @required this.itemsList,
    @required this.selectionLabel,
    this.iconCode,
  });

  String selectedItemName = "None";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(selectionLabel)),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Container(
            height: 63,
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // ###########
                    //  ICON
                    // ###########
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
                      // ###########
                      //  SELECTION MENU BOX
                      // ###########
                      child: Container(
//                          color: Colors.purple,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            // ##################################################
                            //       SELECTOR LIBRARY STARTS HERE
                            // ##################################################
                            child: SelectionMenu<String>(
                              componentsConfiguration: DialogComponentsConfiguration<String>().copyWith(
                                searchingIndicatorComponent: CustomSearchingIndicatorComponent(),
                                triggerComponent: TriggerComponent(builder: _triggerBuilder),
                                triggerFromItemComponent: TriggerFromItemComponent(builder: _triggerFromItemBuilder),
                                menuSizeConfiguration: MenuSizeConfiguration(
                                  maxHeightFraction: 0.82,
                                  maxWidthFraction: 1.0,
                                  minHeightFraction: 0.58,
                                  minWidthFraction: 1.0,
                                  requestAvoidBottomInset: false,
                                ),

                                searchFieldComponent: SearchFieldComponent(builder: _searchFieldBuilder),
//                                searchBarComponent: SearchBarComponent(builder: _searchBarBuilder),

                              ),
                              searchLatency: const Duration(seconds: 1),
                              // Added to simulate long searches.

                              itemSearchMatcher: this.itemSearchMatcher,
                              itemsList: itemsList,
                              itemBuilder: this.itemBuilder,
                              onItemSelected: this.setSelectedItem,
                              showSelectedItemAsTrigger: true,
                            ),
                          )

                      ),

                    ),
                    Container(
                      // ###########
                      //  DROP DOWN ARROWS
                      // ###########
//                      color: Colors.green[50],
                      alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: _getDropdownIcon(),
                        ),
                    ),

                  ],
                )
            ),
          ),
        ),
      ],
    );
  }

  getSelectedItem(){
    return this.selectedItemName;
  }

  static Widget _triggerBuilder(TriggerComponentData data) {
    return RawMaterialButton(
      onPressed: data.triggerMenu,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightElevation: 0,
      elevation: 0,
      focusElevation: 0,
      enableFeedback: true,
//      color: Colors.white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
            "None",
            textAlign: TextAlign.left
        ),
      ),
    );
  }

  static Widget _triggerFromItemBuilder(TriggerFromItemComponentData data) {
    return RawMaterialButton(
      onPressed: data.triggerMenu,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightElevation: 0,
      elevation: 0,
      focusElevation: 0,
      enableFeedback: true,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data.item,
            textAlign: TextAlign.left,
          ),
        ),
    );
  }

  static Widget _searchFieldBuilder(SearchFieldComponentData data) {
    return TextField(
      controller: data.searchTextController,
      // Assigning controller this way is necessary. The controller listens to
      // changes in the field and fires search process accordingly.
      // This controller is created and managed by SelectionMenu Widget.

      textAlign: TextAlign.left,
      decoration: new InputDecoration(
        hintText: "Search...",
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          border: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, String itemName, OnItemTapped onItemTapped) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onItemTapped,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipOval(
                child: Container(
                  color: Color(0xFF1eb2a6),
                  height: 15,
                  width: 15,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    itemName,
//                    style: textStyle,
                  ),
                ),
              ),
//              Text(
//                itemName
//              ),
            ],
          ),
        ),
      ),
    );
  }

  bool itemSearchMatcher(String searchString, String itemName) {
    return itemName.toLowerCase().contains(searchString.trim().toLowerCase());
  }

  void setSelectedItem(String itemName) {
    selectedItemName = itemName;
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

}
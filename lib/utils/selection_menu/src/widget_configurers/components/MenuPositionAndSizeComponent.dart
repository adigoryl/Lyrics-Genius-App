import 'package:flutter/widgets.dart';
import 'package:lyricsflutterapp/utils/selection_menu/selection_menu.dart';
import 'package:lyricsflutterapp/utils/selection_menu/src/widget_configurers/menu_configuration_classes.dart';

import 'common/ComponentAssertionMessages.dart';
import 'common/ComponentData.dart';

/// Carries the data that might be used in [MenuPositionAndSizeComponent.builder].
class MenuPositionAndSizeComponentData implements ComponentData {
  /// [BuildContext] passed by [SelectionMenu].
  ///
  /// Must not be null.
  @override
  final BuildContext context;

  /// [BoxConstraints] constructed by processing [menuSizeConfiguration].
  /// [SelectionMenu] does the processing.
  ///
  /// Must not be null.
  final BoxConstraints constraints;

  /// [TriggerPositionAndSize] of the [SelectionMenu], which is typically a button.
  ///
  /// Note that the [TriggerPositionAndSize.position] is the [Offset] from the
  /// top-left of the **visible** screen.
  ///
  /// Must not be null.
  ///
  /// See also:
  /// * [TriggerPositionAndSize].
  final TriggerPositionAndSize triggerPositionAndSize;

  /// The same [MenuSizeConfiguration] that were passed to [SelectionMenu].
  ///
  /// Must not be null.
  ///
  /// See [MenuSizeConfiguration].
  final MenuSizeConfiguration menuSizeConfiguration;

  MenuPositionAndSizeComponentData({
    @required this.context,
    @required this.constraints,
    @required this.menuSizeConfiguration,
    @required this.triggerPositionAndSize,
    @required this.selectedItem,
  }) : assert(
            context != null &&
                constraints != null &&
                menuSizeConfiguration != null &&
                triggerPositionAndSize != null,
            ComponentAssertionMessages.nullAttributeInData);
  @override
  final dynamic selectedItem;
}

/// Defines a [MenuPositionAndSize] builder for the menu.
///
/// **Example**
///
/// ```dart
/// MenuPositionAndSizeComponent(
///   builder: (MenuPositionAndSizeComponentData data)
///   {
///     return MenuPositionAndSize(
///       positionOffset: Offset(0.0,data.buttonPositionAndSize.size.height),
///       constraints: data.constraints,
///     );
///   }
/// );
/// ```
///
///  <img src="https://i.imgur.com/QL67eib.jpg" width="658.5" height="384"/>
///
/// See [ComponentsConfiguration] for more details.
///
/// See Also:
/// * [MenuPositionAndSizeComponentData]
/// * [MenuPositionAndSizeBuilder]
class MenuPositionAndSizeComponent {
  /// Must not be null.
  ///
  /// See also:
  /// * [MenuPositionAndSizeBuilder].
  MenuPositionAndSizeBuilder builder;

  /// See [MenuPositionAndSizeBuilder].
  MenuPositionAndSizeComponent({@required this.builder});

  /// The method uses the [MenuPositionAndSizeComponent.builder] method to actually
  /// build the Widget.
  ///
  /// [data] Must not be null.
  ///
  /// Used by [SelectionMenu].
  MenuPositionAndSize build(MenuPositionAndSizeComponentData data) {
    assert(
        data != null, ComponentAssertionMessages.nullDataPassedToBuildMethod);
    assert(builder != null, ComponentAssertionMessages.nullBuilderMethod);
    return builder(data);
  }
}

/// This typedef defines a method that returns a [MenuPositionAndSize] that
/// is used to place the menu on the screen.
///
/// Used by [MenuPositionAndSizeComponent] as [MenuPositionAndSizeComponent.builder].
///
/// **Example**
///
/// ```dart
/// MenuPositionAndSizeComponent(
///   builder: (MenuPositionAndSizeComponentData data)
///   {
///     return MenuPositionAndSize(
///       positionOffset: Offset(0.0,data.buttonPositionAndSize.size.height),
///       constraints: data.constraints,
///     );
///   }
/// );
/// ```
///
/// See Also:
/// * [MenuPositionAndSizeComponent]
/// * [MenuPositionAndSizeComponentData]
typedef MenuPositionAndSize MenuPositionAndSizeBuilder(
    MenuPositionAndSizeComponentData data);

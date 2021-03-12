import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/error_text.dart';
import 'package:formkit/src/widgets/internal/loading_indicator.dart';

/// FormKit material [DropdownButton] wrapper
///
/// {@tool snippet}
/// ```dart
/// enum Option {
///   opt1,
///   opt2,
///   opt3,
/// }
/// FormKitDropdownField(
///   name: 'dropdown',
///   isExpanded: true,
///   hint: const Text('Dropdown'),
///   items: [
///     DropdownMenuItem(
///         value: Option.opt1, child: Text('Option 1')),
///     DropdownMenuItem(
///         value: Option.opt2, child: Text('Option 2')),
///     DropdownMenuItem(
///         value: Option.opt3, child: Text('Option 3')),
///   ],
///   validator: FormKitRequiredValidator(
///     constantErrorMessage('Option is required'),
///   ),
/// )
/// ```
/// {@end-tool}
class FormKitDropdownField<T> extends StatefulWidget {
  const FormKitDropdownField({
    Key? key,
    required this.name,
    required this.items,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.onChanged,
    this.enabled,

    ///#region [DropdownButton] properties
    this.selectedItemBuilder,
    this.hint,
    this.disabledHint,
    this.onTap,
    this.elevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<T?>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// Triggered once the value is changed
  final ValueChanged<T?>? onChanged;

  /// The list of items the user can select.
  ///
  /// If the list of items is null then the dropdown button will be disabled,
  /// i.e. its arrow will be displayed in grey and it will not respond to input.
  final List<DropdownMenuItem<T>>? items;

  /// Whether this field is enabled or not
  final bool? enabled;

  ///#region [DropdownButton] properties

  /// A placeholder widget that is displayed by the dropdown button.
  ///
  /// If [value] is null and the dropdown is enabled ([items] and [onChanged] are non-null),
  /// this widget is displayed as a placeholder for the dropdown button's value.
  ///
  /// If [value] is null and the dropdown is disabled and [disabledHint] is null,
  /// this widget is used as the placeholder.
  final Widget? hint;

  /// A preferred placeholder widget that is displayed when the dropdown is disabled.
  ///
  /// If [value] is null, the dropdown is disabled ([items] or [onChanged] is null),
  /// this widget is displayed as a placeholder for the dropdown button's value.
  final Widget? disabledHint;

  /// Called when the dropdown button is tapped.
  ///
  /// This is distinct from [onChanged], which is called when the user
  /// selects an item from the dropdown.
  ///
  /// The callback will not be invoked if the dropdown button is disabled.
  final VoidCallback? onTap;

  /// A builder to customize the dropdown buttons corresponding to the
  /// [DropdownMenuItem]s in [items].
  ///
  /// When a [DropdownMenuItem] is selected, the widget that will be displayed
  /// from the list corresponds to the [DropdownMenuItem] of the same index
  /// in [items].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// This sample shows a `DropdownButton` with a button with [Text] that
  /// corresponds to but is unique from [DropdownMenuItem].
  ///
  /// ```dart
  /// final List<String> items = <String>['1','2','3'];
  /// String selectedItem = '1';
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Padding(
  ///     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  ///     child: DropdownButton<String>(
  ///       value: selectedItem,
  ///       onChanged: (String? string) => setState(() => selectedItem = string!),
  ///       selectedItemBuilder: (BuildContext context) {
  ///         return items.map<Widget>((String item) {
  ///           return Text(item);
  ///         }).toList();
  ///       },
  ///       items: items.map((String item) {
  ///         return DropdownMenuItem<String>(
  ///           child: Text('Log $item'),
  ///           value: item,
  ///         );
  ///       }).toList(),
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// If this callback is null, the [DropdownMenuItem] from [items]
  /// that matches [value] will be displayed.
  final DropdownButtonBuilder? selectedItemBuilder;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int elevation;

  /// The text style to use for text in the dropdown button and the dropdown
  /// menu that appears when you tap the button.
  ///
  /// To use a separate text style for selected item when it's displayed within
  /// the dropdown button, consider using [selectedItemBuilder].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// This sample shows a `DropdownButton` with a dropdown button text style
  /// that is different than its menu items.
  ///
  /// ```dart
  /// List<String> options = <String>['One', 'Two', 'Free', 'Four'];
  /// String dropdownValue = 'One';
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Container(
  ///     alignment: Alignment.center,
  ///     color: Colors.blue,
  ///     child: DropdownButton<String>(
  ///       value: dropdownValue,
  ///       onChanged: (String? newValue) {
  ///         setState(() {
  ///           dropdownValue = newValue!;
  ///         });
  ///       },
  ///       style: TextStyle(color: Colors.blue),
  ///       selectedItemBuilder: (BuildContext context) {
  ///         return options.map((String value) {
  ///           return Text(
  ///             dropdownValue,
  ///             style: TextStyle(color: Colors.white),
  ///           );
  ///         }).toList();
  ///       },
  ///       items: options.map<DropdownMenuItem<String>>((String value) {
  ///         return DropdownMenuItem<String>(
  ///           value: value,
  ///           child: Text(value),
  ///         );
  ///       }).toList(),
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// Defaults to the [TextTheme.subtitle1] value of the current
  /// [ThemeData.textTheme] of the current [Theme].
  final TextStyle? style;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 0.0 width bottom border with color 0xFFBDBDBD.
  final Widget? underline;

  /// The widget to use for the drop-down button's icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget? icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [MaterialColor.shade400] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [MaterialColor.shade700] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Reduce the button's height.
  ///
  /// By default this button's height is the same as its menu items' heights.
  /// If isDense is true, the button's height is reduced by about half. This
  /// can be useful when the button is embedded in a container that adds
  /// its own decorations, like [InputDecorator].
  final bool isDense;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  ///
  /// By default this button's inner width is the minimum size of its contents.
  /// If [isExpanded] is true, the inner width is expanded to fill its
  /// surrounding container.
  final bool isExpanded;

  /// If null, then the menu item heights will vary according to each menu item's
  /// intrinsic height.
  ///
  /// The default value is [kMinInteractiveDimension], which is also the minimum
  /// height for menu items.
  ///
  /// If this value is null and there isn't enough vertical room for the menu,
  /// then the menu's initial scroll offset may not align the selected item with
  /// the dropdown button. That's because, in this case, the initial scroll
  /// offset is computed as if all of the menu item heights were
  /// [kMinInteractiveDimension].
  final double? itemHeight;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used
  /// instead.
  final Color? dropdownColor;

  ///#endregion

  @override
  _FormKitDropdownFieldState<T> createState() =>
      _FormKitDropdownFieldState<T>();
}

class _FormKitDropdownFieldState<T> extends State<FormKitDropdownField<T>> {
  T? _value;

  bool get _enabled => widget.enabled ?? FormKit.of(context).widget.enabled;

  void _setValue(T? value) {
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<T?>(
      name: widget.name,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      onSetValue: _setValue,
      builder: (onChanged, validationState) {
        final handleChange = (T? value) {
          setState(() {
            _setValue(value);
          });
          onChanged(value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        };

        final icon = validationState.isValidating
            ? LoadingIndicator(size: widget.iconSize)
            : widget.icon;

        final error = validationState.error != null
            ? ErrorText(enabled: _enabled, errorText: validationState.error)
            : SizedBox.shrink();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              items: widget.items,
              value: _value,
              onChanged: _enabled ? handleChange : null,
              icon: icon,

              ///#region [DropdownButton] properties
              hint: widget.hint,
              selectedItemBuilder: widget.selectedItemBuilder,
              disabledHint: widget.disabledHint,
              onTap: widget.onTap,
              elevation: widget.elevation,
              style: widget.style,
              underline: widget.underline,
              iconDisabledColor: widget.iconDisabledColor,
              iconEnabledColor: widget.iconEnabledColor,
              iconSize: widget.iconSize,
              isDense: widget.isDense,
              isExpanded: widget.isExpanded,
              itemHeight: widget.itemHeight,
              focusColor: widget.focusColor,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              dropdownColor: widget.dropdownColor,

              ///#endregion
            ),
            error,
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/error_text.dart';

/// FormKit material [Checkbox] field wrapper
///
/// {@tool snippet}
/// ```dart
/// FormKitCheckboxField(
///   name: 'fieldName',
///   title: 'Label',
/// )
/// ```
/// {@end-tool}
class FormKitCheckboxField extends StatefulWidget {
  const FormKitCheckboxField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.onChanged,

    ///#region [ListTile] properties
    this.trailing,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.shape,
    this.contentPadding,
    this.enabled,
    this.tileColor,
    this.hoverColor = Colors.transparent,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,

    ///#endregion

    ///#region [Checkbox] properties
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.tristate = false,
    this.visualDensity,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<bool?>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// Triggered once the value is changed
  final ValueChanged<bool?>? onChanged;

  ///#region [ListTile] properties

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget? title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines. For example, you can use [Text.maxLines] to enforce the number
  /// of lines.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyText2] except
  /// [TextStyle.color]. The [TextStyle.color] depends on the value of [enabled]
  /// and [selected].
  ///
  /// When [enabled] is false, the text color is set to [ThemeData.disabledColor].
  ///
  /// When [selected] is true, the text color is set to [ListTileTheme.selectedColor]
  /// if it's not null. If [ListTileTheme.selectedColor] is null, the text color
  /// is set to [ThemeData.primaryColor] when [ThemeData.brightness] is
  /// [Brightness.light] and to [ThemeData.accentColor] when it is [Brightness.dark].
  ///
  /// When [selected] is false, the text color is set to [ListTileTheme.textColor]
  /// if it's not null and to [TextTheme.caption]'s color if [ListTileTheme.textColor]
  /// is null.
  final Widget? subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  ///
  /// When using a [Text] widget for [title] and [subtitle], you can enforce
  /// line limits using [Text.maxLines].
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool? dense;

  /// Defines how compact the list tile's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// The shape of the tile's [InkWell].
  ///
  /// Defines the tile's [InkWell.customBorder].
  ///
  /// If this property is null then [CardTheme.shape] of [ThemeData.cardTheme]
  /// is used. If that's null then the shape will be a [RoundedRectangleBorder]
  /// with a circular corner radius of 4.0.
  final ShapeBorder? shape;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool? enabled;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The color for the tile's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the tile's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template flutter.material.ListTile.tileColor}
  /// Defines the background color of `ListTile` when [selected] is false.
  ///
  /// When the value is null, the `tileColor` is set to [ListTileTheme.tileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  /// {@endtemplate}
  final Color? tileColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  ///
  /// If null, then the value of [ListTileTheme.horizontalTitleGap] is used. If
  /// that is also null, then a default value of 16 is used.
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  ///
  /// If null, then the value of [ListTileTheme.minVerticalPadding] is used. If
  /// that is also null, then a default value of 4 is used.
  final double? minVerticalPadding;

  /// The minimum width allocated for the [ListTile.leading] widget.
  ///
  /// If null, then the value of [ListTileTheme.minLeadingWidth] is used. If
  /// that is also null, then a default value of 40 is used.
  final double? minLeadingWidth;

  ///#endregion

  ///#region [Checkbox] properties
  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  ///
  /// If [fillColor] returns a non-null color in the [MaterialState.selected]
  /// state, it will be used instead of this color.
  final Color? activeColor;

  /// {@macro flutter.material.checkbox.fillColor}
  ///
  /// If null, then the value of [activeColor] is used in the selected
  /// state. If that is also null, the value of [CheckboxThemeData.fillColor]
  /// is used. If that is also null, then [ThemeData.disabledColor] is used in
  /// the disabled state, [ThemeData.toggleableActiveColor] is used in the
  /// selected state, and [ThemeData.unselectedWidgetColor] is used in the
  /// default state.
  final MaterialStateProperty<Color?>? fillColor;

  /// {@macro flutter.material.checkbox.checkColor}
  ///
  /// If null, then the value of [CheckboxThemeData.checkColor] is used. If
  /// that is also null, then Color(0xFFFFFFFF) is used.
  final Color? checkColor;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// Checkbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  ///#endregion

  @override
  _FormKitCheckboxFieldState createState() => _FormKitCheckboxFieldState();
}

class _FormKitCheckboxFieldState extends State<FormKitCheckboxField> {
  bool? _value;

  bool get _enabled => widget.enabled ?? FormKit.of(context).widget.enabled;

  @override
  void initState() {
    _value = widget.tristate ? null : false;
    super.initState();
  }

  void _setValue(bool? value) {
    _value = value == null && !widget.tristate ? false : value;
  }

  bool? _getNextValue() {
    switch (_value) {
      case false:
        return true;
      case true:
        return widget.tristate ? null : false;
      case null:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<bool?>(
      name: widget.name,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      onSetValue: _setValue,
      builder: (onChanged, validationState) {
        final handleChange = (bool? value) {
          setState(() {
            _setValue(value);
          });
          onChanged(value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        };

        final subtitle = validationState.error != null && _enabled
            ? ErrorText(enabled: _enabled, errorText: validationState.error)
            : widget.subtitle;

        return ListTile(
          onTap: _enabled ? () => handleChange(_getNextValue()) : null,
          leading: _buildCheckbox(handleChange),
          title: widget.title,
          enabled: _enabled,
          subtitle: subtitle,

          ///#region [ListTile] properties
          trailing: widget.trailing,
          isThreeLine: widget.isThreeLine,
          dense: widget.dense,
          shape: widget.shape,
          contentPadding: widget.contentPadding,
          tileColor: widget.tileColor,
          enableFeedback: widget.enableFeedback,
          horizontalTitleGap: widget.horizontalTitleGap,
          minVerticalPadding: widget.minVerticalPadding,
          minLeadingWidth: widget.minLeadingWidth,
          visualDensity: widget.visualDensity,
          focusNode: widget.focusNode,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          mouseCursor: widget.mouseCursor,
          autofocus: widget.autofocus,

          ///#endregion
        );
      },
    );
  }

  Widget _buildCheckbox(void Function(bool?) onChanged) {
    return FocusScope(
      canRequestFocus: false,
      child: Checkbox(
        value: _value,
        onChanged: _enabled ? onChanged : null,

        ///#region [Checkbox] properties
        mouseCursor: widget.mouseCursor,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        activeColor: widget.activeColor,
        fillColor: widget.fillColor,
        checkColor: widget.checkColor,
        tristate: widget.tristate,
        visualDensity: widget.visualDensity,

        ///#endregion
      ),
    );
  }
}

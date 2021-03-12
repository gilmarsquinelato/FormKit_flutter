import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/error_text.dart';

/// FormKit material [Radio] field wrapper
///
/// {@tool snippet}
/// ```dart
/// enum Option {
///   opt1,
///   opt2,
///   opt3,
/// }
///
/// FormKitRadioField(
///   name: 'radio',
///   options: {
///     Option.opt1: Text('Option 1'),
///     Option.opt2: Text('Option 2'),
///     Option.opt3: Text('Option 3'),
///   },
/// )
/// ```
/// {@end-tool}
class FormKitRadioField<T> extends StatefulWidget {
  const FormKitRadioField({
    Key? key,
    required this.name,
    required this.options,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.onChanged,

    ///#region [ListTile] properties
    this.dense,
    this.shape,
    this.contentPadding,
    this.enabled,
    this.tileColor,
    this.focusColor,
    this.focusNode,
    this.hoverColor = Colors.transparent,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.autofocus = false,
    this.mouseCursor,
    this.visualDensity,

    ///#endregion

    ///#region [Radio] properties
    this.activeColor,
    this.fillColor,
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

  /// The available options
  ///
  /// Where the key will be the value once selected,
  /// and the value is the option label
  final Map<T, Widget> options;

  ///#region [ListTile] properties

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

  ///#region [Radio] properties

  /// The color to use when this radio button is selected.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  ///
  /// If [fillColor] returns a non-null color in the [MaterialState.selected]
  /// state, it will be used instead of this color.
  final Color? activeColor;

  /// {@template flutter.material.radio.fillColor}
  /// The color that fills the radio button, in all [MaterialState]s.
  ///
  /// Resolves in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// If null, then the value of [activeColor] is used in the selected state. If
  /// that is also null, then the value of [RadioThemeData.fillColor] is used.
  /// If that is also null, then [ThemeData.disabledColor] is used in
  /// the disabled state, [ThemeData.toggleableActiveColor] is used in the
  /// selected state, and [ThemeData.unselectedWidgetColor] is used in the
  /// default state.
  final MaterialStateProperty<Color?>? fillColor;

  ///#endregion

  @override
  _FormKitRadioFieldState<T> createState() => _FormKitRadioFieldState<T>();
}

class _FormKitRadioFieldState<T> extends State<FormKitRadioField<T>> {
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

        final subtitle = validationState.error != null && _enabled
            ? ErrorText(enabled: _enabled, errorText: validationState.error)
            : null;

        final options = widget.options.entries
            .map(
              (entry) => _buildItem(
                entry.key,
                entry.value,
                handleChange,
                subtitle,
              ),
            )
            .toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: options,
        );
      },
    );
  }

  Widget _buildItem(
    T value,
    Widget label,
    void Function(T?) onChanged,
    Widget? subtitle,
  ) {
    return ListTile(
      onTap: _enabled ? () => onChanged(value) : null,
      leading: _buildRadio(value, onChanged),
      title: label,
      enabled: _enabled,
      subtitle: subtitle,

      ///#region [ListTile] properties
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
  }

  Widget _buildRadio(
    T value,
    void Function(T?) onChanged,
  ) {
    return Radio(
      value: value,
      groupValue: _value,
      onChanged: _enabled ? onChanged : null,

      ///#region [Radio] properties
      mouseCursor: widget.mouseCursor,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      activeColor: widget.activeColor,
      fillColor: widget.fillColor,
      focusColor: widget.focusColor,
      visualDensity: widget.visualDensity,

      ///#endregion
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/loading_indicator.dart';

/// A FormKit [Slider] with [InputDecorator] wrapper.
///
/// {@tool snippet}
/// ```dart
/// FormKitSliderField(
///   name: 'slider',
///   divisions: 100,
///   labelBuilder: (value) => value.toStringAsFixed(2),
///   decoration: InputDecoration(
///     labelText: 'Slider',
///   ),
/// )
/// ```
/// {@end-tool}
class FormKitSliderField extends StatefulWidget {
  const FormKitSliderField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.adaptive = false,
    this.decoration = const InputDecoration(),
    this.labelBuilder,

    ///#region [Slider] properties
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.mouseCursor,
    this.activeColor,
    this.inactiveColor,
    this.semanticFormatterCallback,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<double>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// Determines if the [Slider] will be a Material Slider or
  /// a Slider following Material design's
  /// [Cross-platform guidelines](https://material.io/design/platform-guidance/cross-platform-adaptation.html).
  final bool adaptive;

  /// The decoration to show around the field.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// A function to build the label based on the field value.
  ///
  /// If [labelBuilder] is provided, it will be the first option for [Slider] label property,
  /// if it returns null [label] will be used instead.
  ///
  /// To make it work [divisions] must be provided.
  ///
  /// Ignored if this slider is created with [Slider.adaptive].
  final String? Function(double value)? labelBuilder;

  ///#region [Slider] properties

  /// Called during a drag when the user is selecting a new value for the slider
  /// by dragging.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to be notified when the user has started
  /// selecting a new value by starting a drag or with a tap.
  ///
  /// The value passed will be the last [value] that the slider had before the
  /// change began.
  ///
  /// See also:
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider [value] (use
  /// [onChanged] for that), but rather to know when the user has completed
  /// selecting a new [value] by ending a drag or a click.
  ///
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<double>? onChangeEnd;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  ///
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double max;

  /// The number of discrete divisions.
  ///
  /// Typically used with [label] to show the current discrete value.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// A label to show above the slider when the slider is active.
  ///
  /// It is used to display the value of a discrete slider, and it is displayed
  /// as part of the value indicator shape.
  ///
  /// To make it work [divisions] must be provided.
  ///
  /// The label is rendered using the active [ThemeData]'s [TextTheme.bodyText1]
  /// text style, with the theme data's [ColorScheme.onPrimary] color. The
  /// label's text style can be overridden with
  /// [SliderThemeData.valueIndicatorTextStyle].
  ///
  /// If null, then the value indicator will not be displayed.
  ///
  /// Ignored if this slider is created with [Slider.adaptive].
  ///
  /// See also:
  ///
  ///  * [SliderComponentShape] for how to create a custom value indicator
  ///    shape.
  final String? label;

  /// The color to use for the portion of the slider track that is active.
  ///
  /// The "active" side of the slider is the side between the thumb and the
  /// minimum value.
  ///
  /// Defaults to [SliderThemeData.activeTrackColor] of the current
  /// [SliderTheme].
  ///
  /// Using a [SliderTheme] gives much more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? activeColor;

  /// The color for the inactive portion of the slider track.
  ///
  /// The "inactive" side of the slider is the side between the thumb and the
  /// maximum value.
  ///
  /// Defaults to the [SliderThemeData.inactiveTrackColor] of the current
  /// [SliderTheme].
  ///
  /// Using a [SliderTheme] gives much more fine-grained control over the
  /// appearance of various components of the slider.
  ///
  /// Ignored if this slider is created with [Slider.adaptive].
  final Color? inactiveColor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The callback used to create a semantic value from a slider value.
  ///
  /// Defaults to formatting values as a percentage.
  ///
  /// This is used by accessibility frameworks like TalkBack on Android to
  /// inform users what the currently selected value is with more context.
  ///
  /// Ignored if this slider is created with [Slider.adaptive]
  final SemanticFormatterCallback? semanticFormatterCallback;

  ///#endregion

  @override
  _FormKitSliderFieldState createState() => _FormKitSliderFieldState();
}

class _FormKitSliderFieldState extends State<FormKitSliderField> {
  double _value = 0;

  void _onSetValue(dynamic? value) {
    if (value == null) {
      return;
    }

    if (value is int) {
      _value = value.toDouble().clamp(widget.min, widget.max);
      return;
    }

    if (value is double) {
      _value = value.clamp(widget.min, widget.max);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<double>(
      name: widget.name,
      onSetValue: _onSetValue,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      builder: (onChange, validationState) {
        final handleChange = (double value) {
          onChange(value);
          setState(() {
            _value = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        };

        final field = _buildField(handleChange);

        return InputDecorator(
          decoration: _getDecoration(validationState),
          child: field,
        );
      },
    );
  }

  InputDecoration _getDecoration(ValidationState validationState) {
    final decoration = widget.decoration;

    final suffix = validationState.isValidating
        ? _buildLoadingIndicatorSuffix()
        : decoration.suffix;

    return decoration
        .applyDefaults(Theme.of(context).inputDecorationTheme)
        .copyWith(
          border: decoration.border == null ||
                  decoration.border is UnderlineInputBorder
              ? InputBorder.none
              : decoration.border,
          errorText: validationState.error,
          suffix: suffix,
        );
  }

  Widget _buildLoadingIndicatorSuffix() {
    final decorationIsDense = widget.decoration.isDense == true;
    final iconSize = decorationIsDense ? 18.0 : 24.0;
    final indicatorSize = iconSize - 8;

    return LoadingIndicator(size: indicatorSize);
  }

  Widget _buildField(ValueChanged<double> onChanged) {
    if (widget.adaptive) {
      return _buildAdaptiveField(onChanged);
    }
    return _buildMaterialField(onChanged);
  }

  String? _getLabel() => widget.labelBuilder != null
      ? widget.labelBuilder!(_value) ?? widget.label
      : widget.label;

  Widget _buildMaterialField(ValueChanged<double> onChanged) {
    return Slider(
      value: _value,
      onChanged: onChanged,

      ///#region [Slider] properties
      onChangeStart: widget.onChangeStart,
      onChangeEnd: widget.onChangeEnd,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      label: _getLabel(),
      mouseCursor: widget.mouseCursor,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      semanticFormatterCallback: widget.semanticFormatterCallback,

      ///#endregion
    );
  }

  Widget _buildAdaptiveField(ValueChanged<double> onChanged) {
    return Slider.adaptive(
      value: _value,
      onChanged: onChanged,

      ///#region [Slider] properties
      onChangeStart: widget.onChangeStart,
      onChangeEnd: widget.onChangeEnd,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      label: _getLabel(),
      mouseCursor: widget.mouseCursor,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      semanticFormatterCallback: widget.semanticFormatterCallback,

      ///#endregion
    );
  }
}

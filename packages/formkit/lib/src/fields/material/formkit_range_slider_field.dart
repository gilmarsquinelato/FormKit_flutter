import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/loading_indicator.dart';

/// A FormKit [RangeSlider] with [InputDecorator] wrapper.
///
/// By default it will start with the value equals to [RangeValues(min, max)].
///
/// {@tool snippet}
/// ```dart
/// FormKitRangeSliderField(
///   name: 'rangeSlider',
///   divisions: 9,
///   labelsBuilder: (values) => RangeLabels(
///     values.start.toStringAsFixed(2),
///     values.end.toStringAsFixed(2),
///   ),
///   decoration: InputDecoration(
///     labelText: 'Range Slider',
///   ),
/// )
/// ```
/// {@end-tool}
class FormKitRangeSliderField extends StatefulWidget {
  const FormKitRangeSliderField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.decoration = const InputDecoration(),
    this.labelsBuilder,

    ///#region [RangeSlider] properties
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.labels,
    this.activeColor,
    this.inactiveColor,
    this.semanticFormatterCallback,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<RangeValues>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// The decoration to show around the field.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// A function to build the label based on the field value.
  ///
  /// If [labelBuilder] is provided, it will be the first option for [RangeSlider] label property,
  /// if it returns null [labels] will be used instead.
  ///
  /// To make it work [divisions] must be provided.
  final RangeLabels? Function(RangeValues values)? labelsBuilder;

  ///#region [RangeSlider] properties

  /// Called when the user is selecting a new value for the slider by dragging.
  ///
  /// The slider passes the new values to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new
  /// values.
  ///
  /// If null, the slider will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// See also:
  ///
  ///  * [onChangeStart], which  is called when the user starts  changing the
  ///    values.
  ///  * [onChangeEnd], which is called when the user stops changing the values.
  final ValueChanged<RangeValues>? onChanged;

  /// Called when the user starts selecting new values for the slider.
  ///
  /// This callback shouldn't be used to update the slider [values] (use
  /// [onChanged] for that). Rather, it should be used to be notified when the
  /// user has started selecting a new value by starting a drag or with a tap.
  ///
  /// The values passed will be the last [values] that the slider had before the
  /// change began.
  ///
  /// See also:
  ///
  ///  * [onChangeEnd] for a callback that is called when the value change is
  ///    complete.
  final ValueChanged<RangeValues>? onChangeStart;

  /// Called when the user is done selecting new values for the slider.
  ///
  /// This differs from [onChanged] because it is only called once at the end
  /// of the interaction, while [onChanged] is called as the value is getting
  /// updated within the interaction.
  ///
  /// This callback shouldn't be used to update the slider [values] (use
  /// [onChanged] for that). Rather, it should be used to know when the user has
  /// completed selecting a new [values] by ending a drag or a click.
  ///
  /// See also:
  ///
  ///  * [onChangeStart] for a callback that is called when a value change
  ///    begins.
  final ValueChanged<RangeValues>? onChangeEnd;

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
  /// Typically used with [labels] to show the current discrete values.
  ///
  /// If null, the slider is continuous.
  final int? divisions;

  /// Labels to show as text in the [SliderThemeData.rangeValueIndicatorShape].
  ///
  /// There are two labels: one for the start thumb and one for the end thumb.
  ///
  /// Each label is rendered using the active [ThemeData]'s
  /// [TextTheme.bodyText1] text style, with the theme data's
  /// [ColorScheme.onPrimary] color. The label's text style can be overridden
  /// with [SliderThemeData.valueIndicatorTextStyle].
  ///
  /// If null, then the value indicator will not be displayed.
  ///
  /// To make it work [divisions] must be provided.
  ///
  /// See also:
  ///
  ///  * [RangeSliderValueIndicatorShape] for how to create a custom value
  ///    indicator shape.
  final RangeLabels? labels;

  /// The color of the track's active segment, i.e. the span of track between
  /// the thumbs.
  ///
  /// Defaults to [ColorScheme.primary].
  ///
  /// Using a [SliderTheme] gives more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? activeColor;

  /// The color of the track's inactive segments, i.e. the span of tracks
  /// between the min and the start thumb, and the end thumb and the max.
  ///
  /// Defaults to [ColorScheme.primary] with 24% opacity.
  ///
  /// Using a [SliderTheme] gives more fine-grained control over the
  /// appearance of various components of the slider.
  final Color? inactiveColor;

  /// The callback used to create a semantic value from the slider's values.
  ///
  /// Defaults to formatting values as a percentage.
  ///
  /// This is used by accessibility frameworks like TalkBack on Android to
  /// inform users what the currently selected value is with more context.
  final SemanticFormatterCallback? semanticFormatterCallback;

  ///#endregion

  @override
  _FormKitRangeSliderFieldState createState() =>
      _FormKitRangeSliderFieldState();
}

class _FormKitRangeSliderFieldState extends State<FormKitRangeSliderField> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();

    _values = RangeValues(widget.min, widget.max);
  }

  void _onSetValue(dynamic? value) {
    if (value == null || !(value is RangeValues)) {
      return;
    }

    _values = value;
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<RangeValues>(
      name: widget.name,
      onSetValue: _onSetValue,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      builder: (onChange, validationState) {
        final handleChange = (RangeValues value) {
          onChange(value);
          setState(() {
            _values = value;
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
        : widget.decoration.suffix;

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

  RangeLabels? _getLabels() => widget.labelsBuilder != null
      ? widget.labelsBuilder!(_values) ?? widget.labels
      : widget.labels;

  Widget _buildField(ValueChanged<RangeValues> onChanged) {
    return RangeSlider(
      values: _values,
      onChanged: onChanged,
      labels: _getLabels(),

      ///#region [RangeSlider] properties
      onChangeStart: widget.onChangeStart,
      onChangeEnd: widget.onChangeEnd,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      semanticFormatterCallback: widget.semanticFormatterCallback,

      ///#endregion
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/src/widgets/internal/loading_indicator.dart';

/// FormKit material Date range picker field
///
/// It's a readonly [TextField] with a date range icon button
///
/// {@tool snippet}
/// ```dart
/// FormKitDateRangeField(
///   name: 'bookingRange',
///   decoration: const InputDecoration(
///     labelText: 'Booking range',
///   ),
///   initialDateRange: DateTimeRange(
///     start: DateTime.now().subtract(Duration(days: 60)),
///     end: DateTime.now(),
///   ),
///   firstDate: DateTime(1900),
///   lastDate: DateTime.now(),
/// )
/// ```
/// {@end-tool}
class FormKitDateRangeField extends StatefulWidget {
  const FormKitDateRangeField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.enabled,
    this.decoration = const InputDecoration(),
    this.calendarIcon = const Icon(Icons.date_range),
    this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
    this.dateTimeRangeFormatter,
    this.dateFormatter,

    ///#region [TextField] properties
    this.controller,
    this.focusNode,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.toolbarOptions,
    this.autofocus = false,
    this.onChanged,
    this.onAppPrivateCommand,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.restorationId,

    ///#endregion
  }) : super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<DateTimeRange?>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// The Icon that will be used in the calendar button
  final Icon calendarIcon;

  /// The date range formatter to be used while displaying the value
  ///
  /// By default the field will be formatted with the following format:
  /// ```dart
  /// '${dateFormatter(start)} - ${dateFormatter(end)}'
  /// ```
  final DateTimeRangeFormatter? dateTimeRangeFormatter;

  /// The date formatter to be used individually on each date of the range
  ///
  /// By default the field will use [MaterialLocalizations.formatCompactDate].
  final DateFormatter? dateFormatter;

  /// [initialDateRange] must either fall between [firstDate] and [lastDate],
  /// or be equal to one of them. For each of these [DateTime] parameters, only
  /// their dates are considered. Their time fields are ignored.
  ///
  /// If not provided, the [FormKit] value will be used instead,
  /// if [FormKit] don't have a value for this field
  /// [DateTimeRange(start: DateTime.now(), end: DateTime.now())] will be used instead.
  final DateTimeRange? initialDateRange;

  /// The [firstDate] is the earliest allowable date.
  final DateTime firstDate;

  /// The [lastDate] is the latest allowable date.
  final DateTime lastDate;

  ///#region [TextField] properties

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Configuration of toolbar options.
  ///
  /// If not set, select all and paste will default to be enabled. Copy and cut
  /// will be disabled if [obscureText] is true. If [readOnly] is true,
  /// paste and cut will be disabled regardless.
  final ToolbarOptions? toolbarOptions;

  /// Triggered once the date range is confirmed in the picker dialog
  final ValueChanged<DateTimeRange?>? onChanged;

  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.error].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.textable] will be used.
  ///
  /// The [mouseCursor] is the only property of [TextField] that controls the
  /// appearance of the mouse pointer. All other properties related to "cursor"
  /// stand for the text cursor, which is usually a blinking vertical line at
  /// the editing position.
  final MouseCursor? mouseCursor;

  /// Callback that generates a custom [InputDecoration.counter] widget.
  ///
  /// See [InputCounterWidgetBuilder] for an explanation of the passed in
  /// arguments.  The returned widget will be placed below the line in place of
  /// the default widget built when [InputDecoration.counterText] is specified.
  ///
  /// The returned widget will be wrapped in a [Semantics] widget for
  /// accessibility, but it also needs to be accessible itself. For example,
  /// if returning a Text widget, set the [Text.semanticsLabel] property.
  ///
  /// {@tool snippet}
  /// ```dart
  /// Widget counter(
  ///   BuildContext context,
  ///   {
  ///     required int currentLength,
  ///     required int maxLength,
  ///     required bool isFocused,
  ///   }
  /// ) {
  ///   return Text(
  ///     '$currentLength of $maxLength characters',
  ///     semanticsLabel: 'character count',
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// If buildCounter returns null, then no counter and no Semantics widget will
  /// be created at all.
  final InputCounterWidgetBuilder? buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// If non-null, the text field will persist and restore its current scroll
  /// offset and - if no [controller] has been provided - the content of the
  /// text field. If a [controller] has been provided, it is the responsibility
  /// of the owner of that controller to persist and restore it, e.g. by using
  /// a [RestorableTextEditingController].
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  /// {@endtemplate}
  final String? restorationId;

  ///#endregion

  @override
  _FormKitDateRangeFieldState createState() => _FormKitDateRangeFieldState();
}

class _FormKitDateRangeFieldState extends State<FormKitDateRangeField> {
  DateTimeRange? _value;

  TextEditingController? _fallbackController;
  TextEditingController get _controller =>
      widget.controller ?? (_fallbackController ??= TextEditingController());

  bool get _enabled => widget.enabled ?? FormKit.of(context).widget.enabled;
  DateTimeRange get _initialDateRange =>
      widget.initialDateRange ??
      _value ??
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  DateTimeRangeFormatter get _dateRangeFormatter =>
      widget.dateTimeRangeFormatter ?? _defaultDateRangeFormatter;

  DateFormatter get _dateFormatter =>
      widget.dateFormatter ??
      MaterialLocalizations.of(context).formatCompactDate;

  String _defaultDateRangeFormatter(DateTimeRange range) {
    return '${_dateFormatter(range.start)} - ${_dateFormatter(range.end)}';
  }

  void _onSetValue(dynamic? value) {
    if (value == null) {
      _controller.text = '';
      return;
    }

    if (!(value is DateTimeRange)) {
      return;
    }

    _value = value;
    _controller.text = _dateRangeFormatter(value);
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<DateTimeRange?>(
      name: widget.name,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      onSetValue: _onSetValue,
      builder: (onChanged, validationState) {
        final decoration = _getDecoration(onChanged, validationState);

        return TextField(
          controller: _controller,
          enabled: _enabled,
          decoration: decoration,
          readOnly: true,

          ///#region [TextField] properties
          focusNode: widget.focusNode,
          style: widget.style,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          textDirection: widget.textDirection,
          autofocus: widget.autofocus,
          toolbarOptions: widget.toolbarOptions,
          scrollPadding: widget.scrollPadding,
          scrollPhysics: widget.scrollPhysics,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          selectionControls: widget.selectionControls,
          buildCounter: widget.buildCounter,

          ///#endregion
        );
      },
    );
  }

  InputDecoration _getDecoration(
    ValueChanged<DateTimeRange?> onChanged,
    ValidationState validationState,
  ) {
    final suffix = validationState.isValidating
        ? _buildLoadingIndicatorSuffix()
        : widget.decoration.suffix;

    return widget.decoration.copyWith(
      errorText: validationState.error,
      suffix: suffix,
      suffixIcon: _buildCalendarButtonSuffix(onChanged),
    );
  }

  Widget _buildLoadingIndicatorSuffix() {
    final decorationIsDense = widget.decoration.isDense == true;
    final iconSize = decorationIsDense ? 18.0 : 24.0;
    final indicatorSize = iconSize - 8;

    return LoadingIndicator(size: indicatorSize);
  }

  Widget _buildCalendarButtonSuffix(ValueChanged<DateTimeRange?> onChanged) {
    return IconButton(
      icon: widget.calendarIcon,
      onPressed: () async {
        final dateRange = await showDateRangePicker(
          context: context,
          initialDateRange: _initialDateRange,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (dateRange != null) {
          onChanged(dateRange);
          _onSetValue(dateRange);

          if (widget.onChanged != null) {
            widget.onChanged!(dateRange);
          }
        }
      },
    );
  }
}

typedef DateTimeRangeFormatter = String Function(DateTimeRange value);

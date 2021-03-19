import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formkit/formkit.dart';
import 'package:formkit/material.dart';
import 'package:formkit/src/types.dart';

const TextStyle _kDefaultPlaceholderStyle = TextStyle(
  fontWeight: FontWeight.w400,
  color: CupertinoColors.placeholderText,
);

Function _containsDate = (CupertinoDatePickerMode mode) =>
    mode == CupertinoDatePickerMode.dateAndTime ||
    mode == CupertinoDatePickerMode.date;

Function _containsTime = (CupertinoDatePickerMode mode) =>
    mode == CupertinoDatePickerMode.dateAndTime ||
    mode == CupertinoDatePickerMode.time;

/// A FormKit [CupertinoDatePicker] wrapper
///
/// {@tool snippet}
/// ```dart
/// FormKitCupertinoDatePickerField(
///   name: 'birthDate',
///   prefix: SizedBox(width: 120, child: Text('Birth date')),
/// )
/// ```
/// {@end-tool}
class FormKitCupertinoDatePickerField extends StatefulWidget {
  FormKitCupertinoDatePickerField({
    Key? key,
    required this.name,
    this.validator,
    this.validatorInterval,
    this.validatorTimerMode,
    this.dateFormatter,
    this.timeFormatter,
    this.placeholder,
    this.onChanged,
    this.cancelLabel = 'cancel',
    this.doneLabel = 'done',

    ///#region [CupertinoFormRow] properties
    this.prefix,
    this.helper,

    ///#endregion

    ///#region [CupertinoDatePicker] properties
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.minimumDate,
    this.maximumDate,
    this.minimumYear = 1,
    this.maximumYear,
    this.minuteInterval = 1,
    this.use24hFormat = false,
    this.backgroundColor,
    DateTime? initialDateTime,

    ///#endregion
  })  : initialDateTime = initialDateTime ?? DateTime.now(),
        assert(!_containsDate(mode) || dateFormatter != null),
        assert(!_containsTime(mode) || timeFormatter != null),
        super(key: key);

  /// {@macro formkit.fields.formKitField.name}
  final String name;

  /// {@macro formkit.fields.formKitField.validator}
  final FormKitValidator<DateTime>? validator;

  /// {@macro formkit.fields.formKitField.validatorInterval}
  final Duration? validatorInterval;

  /// {@macro formkit.fields.formKitField.validatorTimerMode}
  final ValidatorTimerMode? validatorTimerMode;

  /// A [DateTime] formatter function that will be used
  /// to display the current field date part value.
  ///
  /// Used when [mode] is [CupertinoDatePickerMode.dateAndTime] or [CupertinoDatePickerMode.date].
  final DateFormatter? dateFormatter;

  /// A [TimeOfDay] formatter function that will be used
  /// to display the current field time part value.
  ///
  /// Used when [mode] is [CupertinoDatePickerMode.dateAndTime] or [CupertinoDatePickerMode.time].
  final TimeFormatter? timeFormatter;

  /// A placeholder that will be shown when no value is present in the field.
  final String? placeholder;

  /// Called once the user selects a new date.
  final ValueChanged<DateTime>? onChanged;

  /// The text that will be displayed in the picker cancel button.
  final String cancelLabel;

  /// The text that will be displayed in the picker done button.
  final String doneLabel;

  ///#region [CupertinoFormRow] properties

  /// A widget that is displayed at the start of the row.
  ///
  /// The [prefix] parameter is displayed at the start of the row. Standard iOS
  /// guidelines encourage passing a [Text] widget to [prefix] to detail the
  /// nature of the row's [child] widget. If null, the [child] widget will take
  /// up all horizontal space in the row.
  final Widget? prefix;

  /// A widget that is displayed underneath the [prefix] and [child] widgets.
  ///
  /// The [helper] appears in primary label coloring, and is meant to inform the
  /// user about interaction with the child widget. The row becomes taller in
  /// order to display the [helper] widget underneath [prefix] and [child]. If
  /// null, the row is shorter.
  final Widget? helper;

  ///#endregion

  ///#region [CupertinoDatePicker] properties

  /// The mode of the date picker as one of [CupertinoDatePickerMode].
  /// Defaults to [CupertinoDatePickerMode.dateAndTime]. Cannot be null and
  /// value cannot change after initial build.
  final CupertinoDatePickerMode mode;

  /// The initial date and/or time of the picker. Defaults to the present date
  /// and time and must not be null. The present must conform to the intervals
  /// set in [minimumDate], [maximumDate], [minimumYear], and [maximumYear].
  ///
  /// Changing this value after the initial build will not affect the currently
  /// selected date time.
  final DateTime initialDateTime;

  /// The minimum selectable date that the picker can settle on.
  ///
  /// When non-null, the user can still scroll the picker to [DateTime]s earlier
  /// than [minimumDate], but the [onDateTimeChanged] will not be called on
  /// these [DateTime]s. Once let go, the picker will scroll back to [minimumDate].
  ///
  /// In [CupertinoDatePickerMode.time] mode, a time becomes unselectable if the
  /// [DateTime] produced by combining that particular time and the date part of
  /// [initialDateTime] is earlier than [minimumDate]. So typically [minimumDate]
  /// needs to be set to a [DateTime] that is on the same date as [initialDateTime].
  ///
  /// Defaults to null. When set to null, the picker does not impose a limit on
  /// the earliest [DateTime] the user can select.
  final DateTime? minimumDate;

  /// The maximum selectable date that the picker can settle on.
  ///
  /// When non-null, the user can still scroll the picker to [DateTime]s later
  /// than [maximumDate], but the [onDateTimeChanged] will not be called on
  /// these [DateTime]s. Once let go, the picker will scroll back to [maximumDate].
  ///
  /// In [CupertinoDatePickerMode.time] mode, a time becomes unselectable if the
  /// [DateTime] produced by combining that particular time and the date part of
  /// [initialDateTime] is later than [maximumDate]. So typically [maximumDate]
  /// needs to be set to a [DateTime] that is on the same date as [initialDateTime].
  ///
  /// Defaults to null. When set to null, the picker does not impose a limit on
  /// the latest [DateTime] the user can select.
  final DateTime? maximumDate;

  /// Minimum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Defaults to 1 and must not be null.
  final int minimumYear;

  /// Maximum year that the picker can be scrolled to in
  /// [CupertinoDatePickerMode.date] mode. Null if there's no limit.
  final int? maximumYear;

  /// The granularity of the minutes spinner, if it is shown in the current mode.
  /// Must be an integer factor of 60.
  final int minuteInterval;

  /// Whether to use 24 hour format. Defaults to false.
  final bool use24hFormat;

  /// Background color of date picker.
  ///
  /// Defaults to null, which disables background painting entirely.
  final Color? backgroundColor;

  ///#endregion

  @override
  _FormKitCupertinoDatePickerFieldState createState() =>
      _FormKitCupertinoDatePickerFieldState();
}

class _FormKitCupertinoDatePickerFieldState
    extends State<FormKitCupertinoDatePickerField> {
  DateTime? _value;

  // bool get _enabled => widget.enabled ?? FormKit.of(context).widget.enabled;

  void _setValue(dynamic? value) {
    if (value is DateTime) {
      _value = value;
    } else {
      _value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormKitField<DateTime>(
      name: widget.name,
      onSetValue: _setValue,
      validator: widget.validator,
      validatorInterval: widget.validatorInterval,
      validatorTimerMode: widget.validatorTimerMode,
      builder: (onChanged, validationState) {
        final handleChange = (DateTime value) {
          setState(() {
            _setValue(value);
          });
          onChanged(value);
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        };

        final error =
            validationState.error != null ? Text(validationState.error!) : null;

        return CupertinoFormRow(
          error: error,
          prefix: widget.prefix,
          helper: widget.helper,
          child: GestureDetector(
            onTap: () => _showPicker(handleChange),
            child: AbsorbPointer(
              child: _buildValue(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildValue() {
    if (_value == null) {
      if (widget.placeholder != null) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            widget.placeholder!,
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .merge(_kDefaultPlaceholderStyle),
          ),
        );
      }

      return SizedBox(width: 200, height: 30);
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDate(),
          _buildTime(),
        ],
      ),
    );
  }

  Widget _buildDate() {
    if (!_containsDate(widget.mode)) {
      return SizedBox.shrink();
    }
    return Text(widget.dateFormatter!(_value!));
  }

  Widget _buildTime() {
    if (!_containsTime(widget.mode)) {
      return SizedBox.shrink();
    }

    final value = Text(
      widget.timeFormatter!(
        TimeOfDay.fromDateTime(_value!),
      ),
    );

    if (!_containsDate(widget.mode)) {
      return value;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: value,
    );
  }

  void _showPicker(ValueChanged<DateTime> onChanged) async {
    final selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: _pickerBuilder,
    );

    if (selectedDate != null && selectedDate != _value) {
      onChanged(selectedDate);
    }
  }

  Widget _pickerBuilder(context) {
    DateTime tempPickedDate = widget.initialDateTime;

    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(widget.cancelLabel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: Text(widget.doneLabel),
                  onPressed: () {
                    Navigator.of(context).pop(tempPickedDate);
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: widget.mode,
              onDateTimeChanged: (DateTime dateTime) {
                tempPickedDate = dateTime;
              },
              initialDateTime: widget.initialDateTime,
              use24hFormat: widget.use24hFormat,
              minuteInterval: widget.minuteInterval,
              minimumDate: widget.minimumDate,
              minimumYear: widget.minimumYear,
              maximumDate: widget.maximumDate,
              maximumYear: widget.maximumYear,
              backgroundColor: widget.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

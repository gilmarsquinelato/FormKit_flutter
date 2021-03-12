import 'package:flutter/material.dart';

const Duration _kTransitionDuration = Duration(milliseconds: 200);

class ErrorText extends StatefulWidget {
  const ErrorText({
    Key? key,
    this.errorText,
    this.enabled = true,
    this.textAlign,
  }) : super(key: key);

  final String? errorText;
  final bool enabled;
  final TextAlign? textAlign;

  @override
  _ErrorTextState createState() => _ErrorTextState();
}

class _ErrorTextState extends State<ErrorText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
    );
    // if (widget.errorText != null) {
    //   _controller.value = 1.0;
    // }
    _controller.addListener(_handleChange);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    setState(() {
      // The _controller's value has changed.
    });
  }

  @override
  void didUpdateWidget(ErrorText old) {
    super.didUpdateWidget(old);

    final newErrorText = widget.errorText;

    if (widget.errorText != old.errorText) {
      if (newErrorText != null) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  TextStyle _getErrorStyle(ThemeData themeData) {
    final Color color =
        widget.enabled ? themeData.errorColor : Colors.transparent;
    return themeData.textTheme.caption!.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      child: Opacity(
        opacity: _controller.value,
        child: FractionalTranslation(
          translation: Tween<Offset>(
            begin: const Offset(0.0, -0.25),
            end: Offset.zero,
          ).evaluate(_controller.view),
          child: Text(
            widget.errorText ?? '',
            style: _getErrorStyle(theme),
            textAlign: widget.textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: theme.inputDecorationTheme.errorMaxLines,
          ),
        ),
      ),
    );
  }
}

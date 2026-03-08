import 'package:elbe/elbe.dart';
import 'package:flutter/services.dart';

class Field extends StatefulWidget {
  final ColorSchemes? colorScheme;
  final bool borderless;
  final Widget? labelWidget;
  final String? label;
  final Object? groupId;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onInput;
  final String? value;
  final String? restorationId;
  final String obscuringCharacter;
  final bool obscureText;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final MouseCursor? mouseCursor;
  final bool stylusHandwritingEnabled;
  final int? maxLines;
  final int minLines;
  final int? maxLength;

  final bool autoFocus;
  final bool canRequestFocus;
  final FocusNode? focusNode;

  final String? successMessage;
  final String? errorMessage;
  final String? warningMessage;
  final String? infoMessage;

  /// Fields are designed to be used with an internal controller, but if you
  /// want to manage the controller yourself, you can provide it here.
  /// If a controller is provided, the [value] parameter will be ignored.
  final TextEditingController? controller;
  const Field({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    this.onInput,
    this.value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
  });

  const Field.password({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    this.onInput,
    this.value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.obscuringCharacter = '•',
    this.obscureText = true,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    this.maxLength,
  })  : maxLines = 1,
        minLines = 1;

  const Field.text({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    this.onInput,
    this.value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    this.maxLength,
  })  : maxLines = 1,
        minLines = 1,
        this.obscuringCharacter = '•',
        this.obscureText = false;

  Field.int({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    Function(int)? onInput,
    int? value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    bool allowNegative = false,
  })  : minLines = 1,
        maxLines = 1,
        maxLength = null,
        value = value != null ? value.toString() : null,
        onInput = onInput != null
            ? ((v) {
                final parsed = int.tryParse(v) ?? 0;
                onInput.call(allowNegative ? parsed : parsed.abs());
              })
            : null,
        keyboardType = TextInputType.numberWithOptions(
            signed: allowNegative, decimal: false),
        obscuringCharacter = '•',
        obscureText = false;

  Field.double({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    Function(double)? onInput,
    double? value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    bool allowNegative = true,
  })  : maxLines = 1,
        minLines = 1,
        maxLength = null,
        value = value != null ? value.toString() : null,
        onInput = onInput != null
            ? ((v) {
                final parsed = double.tryParse(v) ?? 0;
                onInput.call(allowNegative ? parsed : parsed.abs());
              })
            : null,
        keyboardType = TextInputType.numberWithOptions(
            signed: allowNegative, decimal: true),
        obscuringCharacter = '•',
        obscureText = false;

  const Field.multiline({
    super.key,
    this.colorScheme = ColorSchemes.primary,
    this.borderless = false,
    this.onInput,
    this.value,
    this.restorationId,
    this.controller,
    this.labelWidget,
    this.label,
    this.prefix,
    this.suffix,
    this.groupId = EditableText,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.mouseCursor,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.autoFocus = false,
    this.focusNode,
    this.successMessage,
    this.errorMessage,
    this.warningMessage,
    this.infoMessage,
    this.minLines = 3,
    this.maxLines = null,
    this.maxLength,
  })  : this.keyboardType = TextInputType.multiline,
        this.obscuringCharacter = '•',
        this.obscureText = false;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> with RestorationMixin {
  RestorableTextEditingController? _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!.value;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) _createLocalController();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    } else if (widget.controller == null && oldWidget.controller == null) {
      _updateControllerValue();
    }
  }

  void _updateControllerValue() {
    if (widget.value == null || _effectiveController.value.text == widget.value)
      return;

    _effectiveController.value = TextEditingValue(
        text: widget.value ?? "",
        selection: TextSelection.collapsed(offset: widget.value?.length ?? 0),
        composing: TextRange.empty);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);

    _controller = value != null
        ? RestorableTextEditingController.fromValue(value)
        : RestorableTextEditingController();

    if (!restorePending) _registerController();
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        widget.onInput != null ? ColorStates.neutral : ColorStates.disabled;

    final messageKind = widget.successMessage != null
        ? ColorKinds.success
        : widget.errorMessage != null
            ? ColorKinds.error
            : widget.warningMessage != null
                ? ColorKinds.warning
                : widget.infoMessage != null
                    ? ColorKinds.info
                    : null;

    final theme = context.theme.withColorSelection(
        scheme: widget.colorScheme,
        manner: messageKind != null ? ColorManners.minor : null,
        kind: messageKind,
        state: state);

    OutlineInputBorder border([bool focused = false]) => OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(context.rem(theme.geometry.borderRadius)),
        borderSide: widget.borderless && !focused && messageKind == null
            ? BorderSide.none
            : BorderSide(
                width: context.rem(theme.geometry.borderWidth),
                color: theme.color
                    .resolve(manner: focused ? ColorManners.minor : null)
                    .border
                    .withAlpha(!focused && messageKind == null ? 50 : 255)));

    return Column(
      gap: .25,
      children: [
        if (widget.label != null || widget.labelWidget != null)
          Padded.symmetric(
              horizontal: .5,
              child: widget.labelWidget ?? Text.bodyS(widget.label ?? "")),
        Card(
          manner: messageKind != null ? ColorManners.major : ColorManners.plain,
          kind: messageKind,
          padding: RemInsets.zero,
          state: state,
          child: Column(gap: 0, children: [
            TextField(
              controller: _effectiveController,
              onChanged: widget.onInput,
              decoration: InputDecoration(
                  border: border(),
                  enabledBorder: border(),
                  disabledBorder: border(),
                  focusedBorder: border(true),
                  fillColor: theme.color.selected.back,
                  focusColor: theme.color.selected.back,
                  hoverColor: theme.color.selected.back,
                  filled: true,
                  suffix: widget.suffix,
                  prefix: widget.prefix,
                  hintText: widget.hint,
                  hintStyle: theme.type.bodyM.toTextStyle(
                      context, theme.color.selected.front.withAlpha(200))),
              keyboardType: widget.keyboardType,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textAlignVertical: widget.textAlignVertical,
              textAlign: widget.textAlign,
              textDirection: widget.textDirection,
              obscureText: widget.obscureText,
              obscuringCharacter: widget.obscuringCharacter,
              mouseCursor: widget.mouseCursor,
              stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
              focusNode: widget.focusNode,
              enabled: widget.onInput != null,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              autofocus: widget.autoFocus,
              canRequestFocus: widget.canRequestFocus,
              style: theme.type.bodyM.toTextStyle(context,
                  theme.color.resolve(manner: ColorManners.plain).front),
              cursorColor:
                  theme.color.resolve(manner: ColorManners.minor).front,
            ),
            if (messageKind != null)
              Padded.symmetric(
                horizontal: .5,
                vertical: .3,
                child: Row(
                  gap: .5,
                  children: [
                    Icon(messageKind.icon, style: TypeStyles.bodyS),
                    Text.bodyS(widget.successMessage ??
                        widget.errorMessage ??
                        widget.warningMessage ??
                        widget.infoMessage ??
                        ""),
                  ],
                ),
              )
          ]),
        )
      ],
    );
  }
}

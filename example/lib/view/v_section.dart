import 'package:elbe/elbe.dart';

class SectionView extends StatefulWidget {
  final String title;
  final String about;
  final String Function(bool Function(String key) get)? code;
  final Map<String, bool> initial;
  final Widget Function(
      bool Function(String key) get, Function(String key) toggle)? child;
  final List<Widget>? Function(
      bool Function(String key) get, Function(String key) toggle)? children;
  const SectionView(
      {super.key,
      required this.initial,
      required this.title,
      required this.about,
      this.code,
      this.child,
      this.children});

  SectionView.stateless(
      {Key? key,
      required String title,
      required String about,
      String? code,
      Widget? child,
      List<Widget>? children})
      : this(
            initial: {},
            title: title,
            about: about,
            code: code != null ? (_) => code : null,
            child: child != null ? (_, __) => child : null,
            children: children != null ? (_, __) => children : null);

  @override
  State<SectionView> createState() => _SectionViewState();
}

class _SectionViewState<T> extends State<SectionView> {
  bool showCode = false;
  late Map<String, bool> state = widget.initial;

  void toggle(String key) =>
      setState(() => state = {...state, key: !(state[key] ?? true)});

  bool get(String key) => state[key] ?? false;

  Widget _chip(String key) {
    final v = get(key);
    return Button(
        style: v ? ColorStyles.action : ColorStyles.actionIntegrated,
        icon: v ? Icons.checkCircle : Icons.circle,
        label: key.replaceAll("_", " "),
        splash: false,
        onTap: () => toggle(key)).fitWidth;
  }

  void toggleCode() =>
      setState(() => showCode = widget.code != null ? !showCode : false);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text.h5(widget.title).expanded,
              if (widget.code != null)
                IconButton.integrated(icon: Icons.code, onTap: toggleCode),
            ].spaced(),
          ),
          const Spaced.vertical(0.5),
          Text(widget.about),
          const Spaced(),
          AnimatedSize(
              duration: Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: !showCode
                  ? Container()
                  : Card(
                      margin: RemInsets(bottom: 1),
                      scheme: ColorSchemes.inverse,
                      child: Text(widget.code!.call(get).trim(),
                          style: TypeStyles.code),
                    )),
          if (state.isNotEmpty)
            Card(
              margin: RemInsets(bottom: 1),
              padding: RemInsets.zero,
              scheme: ColorSchemes.secondary,
              child: Wrap(
                  runSpacing: context.rem(),
                  spacing: context.rem(),
                  children: state.keys.map(_chip).toList()),
            ),
          widget.child?.call(get, toggle) ??
              Wrap(
                  runSpacing: context.rem(),
                  spacing: context.rem(),
                  children: widget.children?.call(get, toggle) ?? []),
          const Spaced.vertical(3)
        ],
      );
}

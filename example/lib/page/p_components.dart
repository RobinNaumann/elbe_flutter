import 'package:elbe/elbe.dart';
import 'package:example/bit/b_theme_seed.dart';
import 'package:example/view/v_section.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "components",
      actions: [
        ThemeSeedBit.builder(
            onData: (bit, data) => IconButton.flatPlain(
                icon: data.mode.isDark ? Icons.moon : Icons.sun,
                onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      childrenMaxWidth: 40,
      children: const [
        _BoxView(),
        _CardView(),
        _SpacersView(),
        _IconView(),
        _ButtonsView(),
        _IconButtonsView(),
        _ToggleView(),
        _ToggleBtnView(),
        _DropDownView(),
        _SliderView(),
        _FieldView(),
        _SpinnerView(),
        _AlertsView(),
        _ToastView(),
        _PageView(),
        _ExtendView(),
      ],
    );
  }
}

class _BoxView extends StatelessWidget {
  const _BoxView();

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Box",
          about:
              "one of the fundamental building blocks of elbe UI, a container for other widgets with optional border and padding.",
          code: """
Box(
  scheme: ColorSchemes.primary,
  child: Text("primary box"),
  rawPadding: EdgeInsets.all(5),
  border: Border.noneRect
)
""",
          children: [
            for (final s in ColorSchemes.values)
              Box(
                scheme: s,
                child: Text("${s.name} box"),
                //raw pixel, not rem,
                rawPadding: EdgeInsets.all(5),
                border: Border.noneRect,
              )
          ]);
}

class _CardView extends StatelessWidget {
  const _CardView();

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Card",
          about:
              "a box with optional rounded corners, often used to group related content together.",
          code: """
Card(
  scheme: ColorSchemes.primary,
  child: Text("primary card"),
)
""",
          children: [
            for (final s in ColorSchemes.values)
              Card(
                  scheme: s,
                  child: Column(
                    children: [
                      Text("${s.name} card"),
                    ],
                  ))
          ]);
}

class _ButtonsView extends StatelessWidget {
  static const _btnManners = [
    ("major", ColorManners.major),
    ("minor", ColorManners.minor),
    ("flat", ColorManners.flat)
  ];

  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
      initial: const {"icon": true, "enabled": true},
      title: "Buttons",
      about: "a clickable widget with optional icon and label",
      code: (s) => """
Button.major(
  icon: ${s("icon") ? "Icons.sailboat" : "null"},
  label: "major",
  onTap: ${s("enabled") ? "() {}" : "null"},
)
""",
      children: (get, _) => _btnManners
          .map((e) => Button(
                  manner: e.$2,
                  icon: get("icon") ? Icons.sailboat : null,
                  label: e.$1,
                  onTap: get("enabled") ? () {} : null)
              .fitWidth)
          .toList(),
    );
  }
}

class _IconButtonsView extends StatelessWidget {
  const _IconButtonsView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
      initial: const {"enabled": true},
      title: "Icon Buttons",
      about: "a clickable widget with an icon",
      code: (s) => """
IconButton.major(
  icon: Icons.leaf,
  onTap: ${s("enabled") ? "() {}" : "null"},
)
""",
      children: (get, _) => _ButtonsView._btnManners
          .map((e) => IconButton(
                  manner: e.$2,
                  icon: Icons.leaf,
                  onTap: get("enabled") ? () {} : null)
              .fitWidth)
          .toList(),
    );
  }
}

class _SpinnerView extends StatelessWidget {
  const _SpinnerView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {},
        title: "Spinner",
        about: "a progress indicator",
        code: (s) => """
Spinner()
""",
        children: (get, _) => const [
              Box(width: 4, height: 4, child: Spinner()),
              Box(width: 4, height: 4, child: Spinner(kind: ColorKinds.plain)),
            ]);
  }
}

class _ExtendView extends StatelessWidget {
  const _ExtendView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {},
        title: "Easily Extendable",
        about:
            "elbe is designed to be easily extended. You can create your own components by accessing the defined themes",
        code: (s) => """
Spinner()
""",
        children: (get, _) => const [
              Text.code("ColorTheme.of(context)"),
              Text.code("GeometryTheme.of(context)"),
              Text.code("TypeTheme.of(context)"),
            ]);
  }
}

class _SpacersView extends StatelessWidget {
  const _SpacersView();

  final Color cDemo = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {},
        childrenGap: 2,
        title: "Spacers",
        about: "add whitespace between widgets",
        code: (s) => """
Padded.all(1, child: ...),
Spaced(vertical: 2),
Row(children: [...].spaced())
""",
        children: (get, _) => [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.code("Padded.all"),
                  Container(
                    decoration:
                        BoxDecoration(border: WBorder.all(color: cDemo)),
                    child: Padded.all(
                        child: Container(
                      color: cDemo,
                      width: 32,
                      height: 16,
                    )),
                  ),
                ].spaced(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.code("Spaced"),
                  Container(
                      height: 16,
                      width: 16,
                      decoration:
                          BoxDecoration(border: WBorder.all(color: cDemo))),
                ].spaced(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.code("<Widget>[...].spaced()"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: cDemo,
                        width: 32,
                        height: 48,
                      ),
                      Container(
                          height: 16,
                          width: 16,
                          decoration:
                              BoxDecoration(border: WBorder.all(color: cDemo))),
                      Container(
                        color: cDemo,
                        width: 32,
                        height: 48,
                      ),
                      Container(
                          height: 16,
                          width: 16,
                          decoration:
                              BoxDecoration(border: WBorder.all(color: cDemo))),
                      Container(
                        color: cDemo,
                        width: 32,
                        height: 48,
                      ),
                    ],
                  ),
                ].spaced(),
              ),
            ]);
  }
}

class _SliderView extends StatefulWidget {
  const _SliderView();

  @override
  State<_SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<_SliderView> {
  double value = 4;
  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"enabled": true},
        title: "Slider",
        about: "a widget for selecting a value from a linear scale",
        code: (s) => """
SliderSelect(
  value: $value,
  onChanged: (v) {...},
  min: 0,
  max: 10,
)
""",
        children: (get, _) => [
              SliderSelect(
                value: value,
                onChanged:
                    get("enabled") ? (v) => setState(() => value = v) : null,
                min: 0,
                max: 10,
              )
            ]);
  }
}

class _FieldView extends StatelessWidget {
  const _FieldView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {},
        title: "Text Field",
        about: "widget styles for entering text",
        code: (s) => """
TextField(
  decoration: 
    elbeFieldDeco(context, hint: "type"))
""",
        children: (get, _) => [
              TextField(
                  decoration: elbeFieldDeco(context, hint: "type something")),
              TextField(
                  minLines: 3,
                  maxLines: 3,
                  decoration: elbeFieldDeco(context, hint: "type something"))
            ]);
  }
}

class _IconView extends StatelessWidget {
  const _IconView();

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"badge": true},
        childrenGap: 2,
        title: "Icons",
        about:
            "a graphical symbol for a concept or object. uses lucide.dev by default.",
        code: (s) => """
Icon(Icons.leaf,
  //style: TypeStyles.bodyS,
  color: Colors.green,
  badge: ${s("badge") ? "Badge(value: 2)" : "null"}
)
""",
        children: (get, _) => [
              Icon(Icons.treeDeciduous,
                  badge: get("badge") ? Badge(type: AlertType.error) : null),
              Icon(Icons.trees,
                  badge: get("badge")
                      ? Badge(text: "fire", type: AlertType.warning)
                      : null),
              Icon(Icons.leaf,
                  color: Colors.green,
                  badge: get("badge") ? Badge(value: 2) : null),
            ]);
  }
}

class _ToggleView extends StatefulWidget {
  const _ToggleView();
  @override
  State<_ToggleView> createState() => _ToggleViewState();
}

class _ToggleViewState extends State<_ToggleView> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"show_check": true},
        childrenGap: 2,
        title: "Toggle Button",
        about:
            "a clickable widget that can be in one of two states, often used to represent a binary choice.",
        code: (s) => """
Icon(Icons.leaf,
  //style: TypeStyles.bodyS,
  color: Colors.green,
  badge: ${s("badge") ? "Badge(value: 2)" : "null"}
)
""",
        children: (get, _) => [
              ToggleButton(
                  icon: Icons.leaf,
                  label: "foliage",
                  showCheck: get("show_check"),
                  value: selected,
                  onChanged: (v) => setState(() => selected = v)),
            ]);
  }
}

class _ToggleBtnView extends StatefulWidget {
  const _ToggleBtnView();

  @override
  State<_ToggleBtnView> createState() => _ToggleBtnViewState();
}

class _ToggleBtnViewState extends State<_ToggleBtnView> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"icon": true, "vertical": false},
        title: "OptionsButton",
        about: "a group of buttons allowing the user to select one option.",
        code: (s) => """
OptionsButton(
  selected: 1,
  vertical: false,
  onSelect: (key) {},
  items: [
    OptionsItem(
        key: 0,
        label: "apple",
        icon: Icons.apple),
    OptionsItem(
        key: 1,
        label: "cherry",
        icon: Icons.cherry),
    ]);
""",
        child: (get, set) => Align(
              alignment: Alignment.topLeft,
              child: Box.plain(
                constraints:
                    get("vertical") ? const RemConstraints(maxWidth: 15) : null,
                child: OptionsButton(
                  vertical: get("vertical"),
                  selected: selected,
                  items: [
                    OptionsItem(
                        key: 0,
                        label: "apple",
                        icon: get("icon") ? Icons.apple : null),
                    OptionsItem(
                        key: 1,
                        label: "cherry",
                        icon: get("icon") ? Icons.cherry : null),
                    OptionsItem(
                        key: 2,
                        label: "banana",
                        icon: get("icon") ? Icons.banana : null),
                  ],
                  onSelect: (k) => setState(() => selected = k),
                ),
              ),
            ));
  }
}

class _AlertsView extends StatelessWidget {
  static const _types = [
    AlertType.error,
    AlertType.warning,
    AlertType.info,
    AlertType.success
  ];

  const _AlertsView();

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Alert Types",
          about: "a visual indication of a status or message",
          code: """
Badge(
  text: "error", 
  type: AlertType.error)
""",
          children: [
            for (final s in _types) Badge(text: s.name, type: s),
          ]);
}

class _ToastView extends StatelessWidget {
  const _ToastView();

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Toast",
          about: "show a temporary message at the bottom of the screen",
          code: """
context.showToast("hello world");

context.showToast(
  "hello world", 
  icon: Icons.leaf, 
  kind: ColorKinds.success
);""",
          children: [
            Button.minor(
                label: "show basic toast",
                onTap: () => context.showToast("hello world")),
            Button.minor(
                label: "show custom toast",
                onTap: () => context.showToast("hello world",
                    icon: Icons.leaf,
                    kind: ColorKinds.success,
                    manner: ColorManners.minor)),
          ]);
}

class _DropDownView extends StatefulWidget {
  const _DropDownView();

  @override
  createState() => _DropDownViewState();
}

class _DropDownViewState extends State<_DropDownView> {
  String? selected;
  @override
  Widget build(BuildContext context) => SectionView(
      initial: const {"icon": true},
      title: "DropDown",
      about: "a widget for selecting a value from a list of options",
      code: (config) => """
DropDown(
  selected: "banana",
  items: [
    OptionsItem(key: "banana", label: "Banana", icon: Icons.banana),
    OptionsItem(key: "cherry", label: "Cherry", icon: Icons.cherry),
    OptionsItem(key: "apple", label: "Apple", icon: Icons.apple),
  ],
  onSelect: (v) => ...,
);""",
      children: (config, _) => [
            DropDown(
              selected: selected,
              items: [
                OptionsItem(
                    key: "banana",
                    label: "Banana",
                    icon: config("icon") ? Icons.banana : null),
                OptionsItem(
                    key: "cherry",
                    label: "Cherry",
                    icon: config("icon") ? Icons.cherry : null),
                OptionsItem(
                    key: "apple",
                    label: "Apple",
                    icon: config("icon") ? Icons.apple : null),
              ],
              onSelect: (v) => setState(() => selected = v),
            )
          ]);
}

class _PageView extends StatelessWidget {
  const _PageView();

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Page",
          about: "a component that represents a single screen",
          code: """
Scaffold(
  title: "title",
  actions: [IconButton.integrated(icon: Icons.leaf, onTap: () {})],
  child: Text("this is some content")
);""",
          children: [
            Card(
              padding: RemInsets.zero,
              child: SizedBox(
                  height: 300,
                  child: Scaffold(
                      title: "title",
                      actions: [
                        IconButton.flatPlain(icon: Icons.leaf, onTap: () {})
                      ],
                      child: Padded.all(
                          child: const Text("this is some content")))),
            ),
          ]);
}

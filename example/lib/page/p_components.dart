import 'package:elbe/elbe.dart';
import 'package:example/main.dart';
import 'package:example/view/v_section.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: "components",
      actions: [
        ColorModeBit.builder(
            onData: (bit, data) => IconButton.integrated(
                icon: data.isDark ? Icons.moon : Icons.sun, onTap: bit.toggle))
      ],
      //leadingIcon: LeadingIcon.back(),
      children: const [
        _BoxView(),
        _CardView(),
        _IconView(),
        _ButtonsView(),
        _IconButtonsView(),
        _ToggleBtnView(),
        _AlertsView(),
        _ToastView()
      ],
    );
  }
}

class _BoxView extends StatelessWidget {
  const _BoxView({super.key});

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
  const _CardView({super.key});

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
  static const _btnStyles = [
    ("major", ColorStyles.majorAccent),
    ("minor", ColorStyles.minorAccent),
    ("action", ColorStyles.action),
    ("integrated", ColorStyles.actionIntegrated)
  ];

  const _ButtonsView({super.key});

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
      children: (get, _) => _btnStyles
          .map((e) => Button(
                  style: e.$2,
                  icon: get("icon") ? Icons.sailboat : null,
                  label: e.$1,
                  onTap: get("enabled") ? () {} : null)
              .fitWidth)
          .toList(),
    );
  }
}

class _IconButtonsView extends StatelessWidget {
  const _IconButtonsView({super.key});

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
      children: (get, _) => _ButtonsView._btnStyles
          .map((e) => IconButton(
                  style: e.$2,
                  icon: Icons.leaf,
                  onTap: get("enabled") ? () {} : null)
              .fitWidth)
          .toList(),
    );
  }
}

class _IconView extends StatelessWidget {
  const _IconView({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"badge": true},
        title: "Icons",
        about:
            "a graphical symbol for a concept or object. uses lucide.dev by default.",
        code: (s) => """
Icon(Icons.leaf,
  style: TypeStyles.bodyS,
  color: Colors.green,
  badge: ${s("badge") ? "Badge(value: 2)" : "null"}
)
""",
        children: (get, _) => [
              Icon(Icons.treeDeciduous,
                  badge: get("badge")
                      ? Badge(value: 1, type: AlertType.warning)
                      : null),
              Icon(Icons.trees,
                  badge: get("badge")
                      ? Badge(text: "fire", type: AlertType.error)
                      : null),
              Icon(Icons.leaf,
                  style: TypeStyles.bodyS,
                  color: Colors.green,
                  badge: get("badge") ? Badge(value: 2) : null),
            ]);
  }
}

class _ToggleBtnView extends StatefulWidget {
  const _ToggleBtnView({super.key});

  @override
  State<_ToggleBtnView> createState() => _ToggleBtnViewState();
}

class _ToggleBtnViewState extends State<_ToggleBtnView> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SectionView(
        initial: const {"icon": true},
        title: "Toggle Buttons",
        about: "a group of buttons allowing the user to select one option.",
        code: (s) => """
ToggleButtons(
  selected: 1,
  onSelect: (key) {},
  items: [
    MultiToggleItem(
        key: 0,
        label: "apple",
        icon: Icons.apple),
    MultiToggleItem(
        key: 1,
        label: "cherry",
        icon: Icons.cherry),
    ]);
""",
        child: (get, set) => Align(
              alignment: Alignment.topLeft,
              child: Box.plain(
                constraints: RemConstraints(maxWidth: 25),
                child: ToggleButtons(
                  selected: selected,
                  items: [
                    MultiToggleItem(
                        key: 0,
                        label: "apple",
                        icon: get("icon") ? Icons.apple : null),
                    MultiToggleItem(
                        key: 1,
                        label: "cherry",
                        icon: get("icon") ? Icons.cherry : null),
                    MultiToggleItem(
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

  const _AlertsView({super.key});

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
  const _ToastView({super.key});

  @override
  Widget build(BuildContext context) => SectionView.stateless(
          title: "Toast",
          about: "show a temporary message at the bottom of the screen",
          code: """
context.showToast("hello world");

context.showToast(
  "hello world", 
  icon: Icons.leaf, 
  color: context.theme.color.activeScheme.minorAlertSuccess
);""",
          children: [
            Button.minor(
                label: "show basic toast",
                onTap: () => context.showToast("hello world")),
            Button.minor(
                label: "show custom toast",
                onTap: () => context.showToast("hello world",
                    icon: Icons.leaf,
                    color: context.theme.color.activeScheme.minorAlertSuccess)),
          ]);
}

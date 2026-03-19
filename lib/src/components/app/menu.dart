import 'package:elbe/elbe.dart';

class AppMenuSpacer extends StatelessWidget {
  const AppMenuSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.app.layoutMode.isWide) return Spacer.zero;
    return Spacer.horizontal((context.app.menuOpen ? 15 : 4));
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  String _currentMajor(String p) {
    final path = p.split("/");
    if (path.length < 2) return "/";
    return "/" + (path[1].isNotEmpty ? path[1] : ""); // Get the first segment
  }

  @override
  Widget build(BuildContext context) {
    final currentSel = _currentMajor(context.app.router.path);

    final isOpen = context.app.menuOpen;
    final isWide = context.app.layoutMode.isWide;

    final menuRoutes = context.app.router.routes.whereType<MenuRoute>();
    final topRoutes = menuRoutes.where((r) => !r.bottom);
    final bottomRoutes = menuRoutes.where((r) => r.bottom);

    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 200),
      child: !isWide && !isOpen
          ? Spacer.zero
          : Row(
              main: MainAxisAlignment.start,
              cross: CrossAxisAlignment.stretch,
              children: [
                Card(
                  radius: 0,
                  flex: isOpen && !isWide ? 1 : 0,
                  margin: RemInsets.zero,
                  padding: RemInsets.all(.5),
                  scheme: ColorSchemes.secondary,
                  child: SafeArea(
                    child: AnimatedSize(
                      duration: Duration(milliseconds: 200),
                      alignment: AlignmentGeometry.centerLeft,
                      child: Card(
                        radius: 0,
                        margin: RemInsets.zero,
                        padding: RemInsets.zero,
                        width: isOpen ? 14 : 3,
                        child: Column(
                          gap: .5,
                          children: [
                            Padded.only(
                              bottom: 1,
                              child: Button.plain(
                                  alignment: isOpen
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  constraints:
                                      const RemConstraints(minHeight: 3),
                                  label: isOpen ? context.app.name : null,
                                  icon: isOpen
                                      ? (isWide ? Icons.menu : Icons.x)
                                      : Icons.menu,
                                  onTap: () {
                                    context.app.update(
                                        menuOpen: !context.app.menuOpen);
                                  }),
                            ),
                            for (final route in topRoutes)
                              _MenuItem(
                                  route: route,
                                  selected: route.path == currentSel,
                                  menuOpen: context.app.menuOpen),
                            Expanded(child: Container()),
                            for (final route in bottomRoutes)
                              _MenuItem(
                                  route: route,
                                  selected: route.path == currentSel,
                                  menuOpen: context.app.menuOpen),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final MenuRoute route;
  final bool selected;
  final bool menuOpen;
  const _MenuItem(
      {super.key,
      required this.route,
      required this.selected,
      this.menuOpen = false});

  @override
  Widget build(BuildContext context) {
    final isWide = context.app.layoutMode.isWide;
    return Button(
        manner: selected ? ColorManners.major : ColorManners.plain,
        alignment: context.app.menuOpen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        constraints: const RemConstraints(minHeight: 3),
        label: menuOpen ? route.label : null,
        icon: route.icon,
        onTap: route.disabled
            ? null
            : () {
                context.app.router.replace(route.path, clearHistory: true);
                if (!isWide) context.app.update(menuOpen: false);
              });
  }
}

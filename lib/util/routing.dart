import '../elbe.dart';

void pushPage(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void popPage(BuildContext context) => Navigator.maybePop(context);

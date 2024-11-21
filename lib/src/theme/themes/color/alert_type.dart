import '../../../../elbe.dart';

/// the types of alerts that can be displayed in the app
enum AlertType {
  info(ColorKinds.info, Icons.info),
  success(ColorKinds.success, Icons.alertTriangle),
  warning(ColorKinds.warning, Icons.alertTriangle),
  error(ColorKinds.error, Icons.xOctagon);

  const AlertType(this.kind, this.icon);
  final ColorKinds kind;
  final IconData icon;
}

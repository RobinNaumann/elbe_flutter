import '../../../../elbe.dart';

enum AlertType {
  info(
    ColorStyles.majorAlertInfo,
    ColorStyles.minorAlertInfo,
    Icons.info,
  ),
  success(
    ColorStyles.majorAlertSuccess,
    ColorStyles.minorAlertSuccess,
    Icons.alertTriangle,
  ),
  warning(
    ColorStyles.majorAlertWarning,
    ColorStyles.minorAlertWarning,
    Icons.alertTriangle,
  ),
  error(
    ColorStyles.majorAlertError,
    ColorStyles.minorAlertError,
    Icons.xOctagon,
  );

  const AlertType(this.major, this.minor, this.icon);
  final ColorStyles major;
  final ColorStyles minor;
  final IconData icon;
}

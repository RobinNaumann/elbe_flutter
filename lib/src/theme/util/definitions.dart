import '../../../elbe.dart';

enum DisplaySizeType {
  mobile(450),
  tablet(900),
  desktop(-1);

  const DisplaySizeType(this.dim);
  final double dim;

  bool get isMobile => index == DisplaySizeType.mobile.index;
  bool get isTablet => index == DisplaySizeType.tablet.index;
  bool get isDesktop => index == DisplaySizeType.desktop.index;

  T map<T>(
          {required T Function() mobile,
          required T Function() tablet,
          required T Function() desktop}) =>
      isMobile ? mobile() : (isTablet ? tablet() : desktop());

  T maybeMap<T>(
          {T Function()? mobile,
          T Function()? tablet,
          T Function()? desktop,
          required T Function() orElse}) =>
      map(
          mobile: mobile ?? orElse,
          tablet: tablet ?? orElse,
          desktop: desktop ?? orElse);

  T mapValue<T>({required T mobile, required T tablet, required T desktop}) =>
      isMobile ? mobile : (isTablet ? tablet : desktop);

  static DisplaySizeType of(BuildContext context) {
    final s = MediaQuery.of(context).size;
    if (s.width < DisplaySizeType.mobile.dim ||
        s.height < DisplaySizeType.mobile.dim) return DisplaySizeType.mobile;
    if (s.width < DisplaySizeType.tablet.dim) return DisplaySizeType.tablet;
    return DisplaySizeType.desktop;
  }
}

import 'package:elbe/util/m_data.dart';
import 'package:flutter/widgets.dart';

class BitError extends DataModel implements Exception {
  final dynamic error;

  final String uiTitle;
  final String uiMessage;
  final IconData? uiIcon;

  const BitError(this.error,
      {required this.uiTitle, required this.uiMessage, this.uiIcon});

  @override
  get map => {
        "uiTitle": uiTitle,
        "uiMessage": uiMessage,
        "uiIcon": uiIcon,
        "error": error
      };

  // CUSTOM EXCEPTIONS

  BitError.serviceNotInitialized([String serviceName = "- unknown -"])
      : this("service '$serviceName' has not initialized before being used.",
            uiTitle: "service not initialized",
            uiMessage: "a service has not been initialized");
}

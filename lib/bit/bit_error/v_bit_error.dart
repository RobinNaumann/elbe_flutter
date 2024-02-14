import 'dart:io';

import '../../elbe.dart';
import '../../util/routing.dart';

class BitErrorView extends StatelessWidget {
  final BitControl bit;
  final dynamic error;

  const BitErrorView({super.key, required this.bit, this.error});

  @override
  Widget build(BuildContext context) {
    BitError richError = (error is BitError)
        ? error
        : BitError(error,
            uiTitle: "unknown Error",
            uiMessage: "an unknown error has occurred");

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(richError.uiIcon ?? Icons.alertCircle),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => pushPage(context, _ErrorTechView(error: richError)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      richError.uiTitle,
                      textAlign: TextAlign.center,
                      style: TypeStyles.bodyL,
                      variant: TypeVariants.bold,
                    ),
                    const Spaced.vertical(0.5),
                    Text(
                      richError.uiMessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ]),
            ),
            TextButton.icon(
                onPressed: bit.reload,
                icon: const Icon(Icons.rotateCcw),
                label: const Text("reload"))
          ],
        ),
      ),
    );
  }
}

class _ErrorTechView extends StatelessWidget {
  final BitError error;
  const _ErrorTechView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isMacOS
          ? const EdgeInsets.only(top: 53)
          : const EdgeInsets.all(0),
      child: Scaffold(
          title: "Error Details",
          leadingIcon: const LeadingIcon.close(),
          child: Padded.all(
              child: SingleChildScrollView(
                  clipBehavior: Clip.none, child: Text(error.toString())))),
    );
  }
}

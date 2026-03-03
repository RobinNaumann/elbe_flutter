import '../../elbe.dart';

class ElbeErrorView extends StatelessWidget {
  final dynamic error;
  final Function()? reload;

  const ElbeErrorView({super.key, this.error, this.reload});

  @override
  Widget build(BuildContext context) {
    final err = elbeErrors.resolve(error);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          gap: 0,
          main: MainAxisAlignment.center,
          cross: CrossAxisAlignment.stretch,
          children: [
            Icon(err.icon ?? Icons.alertCircle),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => ElbeErrorPage.show(context, err),
              child:
                  Column(gap: 0, cross: CrossAxisAlignment.stretch, children: [
                Text(
                  err.message,
                  textAlign: TextAlign.center,
                  style: TypeStyles.bodyL,
                  variant: TypeVariants.bold,
                ),
                const Spacer.vertical(0.5),
                Text(
                  err.description ?? "",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ]),
            ),
            TextButton.icon(
                onPressed: reload,
                icon: const Icon(Icons.rotateCcw),
                label: const Text("reload"))
          ],
        ),
      ),
    );
  }
}

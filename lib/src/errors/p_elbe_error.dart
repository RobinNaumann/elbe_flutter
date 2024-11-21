import 'package:elbe/elbe.dart';

class ElbeErrorPage extends StatelessWidget {
  final String title;
  final String causeLabel;
  final ElbeError error;
  const ElbeErrorPage(
      {super.key,
      required this.error,
      this.title = "Error Details",
      this.causeLabel = "Cause Chain"});

  static void show(BuildContext context, ElbeError error,
          {String title = "Error Details",
          String causeLabel = "Cause Chain"}) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ElbeErrorPage(
              error: error, title: title, causeLabel: causeLabel)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      title: title,
      leadingIcon: LeadingIcon.none(),
      actions: [
        IconButton.flatPlain(
          icon: Icons.x,
          onTap: () => Navigator.of(context).maybePop(),
        )
      ],
      children: [
        _ErrorSnippet(error: error),
        Padded.only(top: .5, child: Text.h5(causeLabel)),
        for (final cause in error.causeChain.skip(1))
          _ErrorSnippet(error: cause),
      ].spaced(),
    );
  }
}

class _ErrorSnippet extends StatelessWidget {
  final ElbeError error;
  const _ErrorSnippet({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
            children: [
          Text.code(error.code),
          Expanded(child: Text(error.message, textAlign: TextAlign.end)),
        ].spaced()),
        if (error.details != null) Text.code(error.details.toString())
      ].spaced(),
    ));
  }
}

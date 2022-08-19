import 'package:flutter/cupertino.dart';

class Preloader extends StatelessWidget {
  const Preloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
    child: Container(
      color: CupertinoColors.white,
      child: const CupertinoActivityIndicator(radius: 16),
    ),
  );
  }
}
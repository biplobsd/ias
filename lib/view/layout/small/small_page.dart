import 'package:flutter/material.dart';

import '../../widgets/local_navigator.dart';

class SmallPage extends StatelessWidget {
  const SmallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return localNavigator(context);
  }
}

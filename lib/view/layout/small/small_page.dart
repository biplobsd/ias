import 'package:flutter/material.dart';
import 'package:ias/view/widgets/local_navigator.dart';

class SmallPage extends StatelessWidget {
  const SmallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return localNavigator(context);
  }
}

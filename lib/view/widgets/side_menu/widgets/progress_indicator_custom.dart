
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../checker/bloc/anim_image_bloc.dart';

class ProgressIndicatorCustom extends StatelessWidget {
  const ProgressIndicatorCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: BlocBuilder<AnimImageBloc,
          AnimImageState>(
        builder: (context, state) {
          if (state is AnimImageSplitting) {
            return AnimatedSwitcher(
              duration: const Duration(
                  milliseconds: 200),
              reverseDuration: const Duration(
                  milliseconds: 200),
              switchInCurve: Curves.bounceIn,
              switchOutCurve: Curves.bounceInOut,
              transitionBuilder:
                  (child, animation) =>
                      ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Container(
                key: UniqueKey(),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .indicatorColor,
                    shape: BoxShape.circle),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

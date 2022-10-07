import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/constants/style.dart';
import 'package:preloadwebapptemplate/view/widgets/custom_text.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonhover_cubit.dart';
import 'package:preloadwebapptemplate/data/model/menu_data.dart';

class VerticalMenuItem extends StatelessWidget {
  final MenuData itemData;
  final void Function()? onTap;
  const VerticalMenuItem({
    required this.itemData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        BlocProvider.of<SidemenuonhoverCubit>(context)
            .onHoverCall(itemData.copyWith(isHover: value));
      },
      child: BlocBuilder<SidemenuonhoverCubit, SidemenuonhoverState>(
        builder: (context, state) {
          bool isThatWidgetHover = state.isThatWidget(itemData);
          return Container(
            color: isThatWidgetHover ? lightGrey.withOpacity(0.1) : null,
            child: BlocBuilder<SidemenuonactiveCubit, SidemenuonactiveState>(
              builder: (context, state) {
                bool isThatWidgetActive = state.isThatWidget(itemData);
                // Color color =
                //     isThatWidgetActive || isThatWidgetHover ? dark : lightGrey;
                return Row(
                  children: [
                    Visibility(
                      visible: isThatWidgetActive,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Container(
                        width: 3,
                        height: 72,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              itemData.icon,
                              color:
                                  Theme.of(context).hintColor.withOpacity(.7),
                            ),
                          ),
                          Flexible(
                            child: CustomText(
                              size: isThatWidgetActive ? 18 : 16,
                              text: itemData.name,
                              color:
                                  Theme.of(context).hintColor.withOpacity(.7),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/view/widgets/custom_text.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonactive_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/sidemenuonhover_cubit.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/model/menu_data.dart';

class HorizontalMenuItem extends StatelessWidget {
  final MenuData itemData;
  final void Function()? onTap;
  const HorizontalMenuItem(
      {required this.itemData, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            color: isThatWidgetHover ? Theme.of(context).hoverColor : null,
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
                        width: 6,
                        height: 40,
                        color: Theme.of(context).toggleableActiveColor,
                      ),
                    ),
                    SizedBox(
                      width: width / 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        itemData.icon,
                        color: Theme.of(context).hintColor.withOpacity(.7),
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: itemData.name,
                        size: isThatWidgetActive ? 18 : 16,
                        color: Theme.of(context).hintColor.withOpacity(.7),
                        weight: isThatWidgetActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    )
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

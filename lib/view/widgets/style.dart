import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_viewer/flutter_text_viewer.dart';
import 'package:ndialog/ndialog.dart';

import '../../core/cubit/top_context_cubit.dart';
import '../../utility/function/helper.dart';

InputDecoration customInputDecoration(BuildContext context,
        {String? labelText, String? hintText}) =>
    InputDecoration(
      filled: true,
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Theme.of(context).hoverColor.withOpacity(0.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );

class CustomTextHeader extends StatelessWidget {
  final String text;
  const CustomTextHeader({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .color!
                    .withOpacity(0.8),
              ),
        ),
      ),
    );
  }
}

class CustomHeaderTextField extends StatelessWidget {
  const CustomHeaderTextField({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return CustomTileSetting(
      icon: const Icon(Icons.remove_red_eye),
      moreIconButton: Row(children: [
        CustomButton(
          onPressed: () {
            Helper.copyToClipboard(context, data);
          },
          child: const Icon(Icons.copy_all),
        ),
        const SizedBox(
          width: 5,
        ),
      ]),
      onTap: () async {
        var topContextBackup = context.read<TopContextCubit>().topContextBackup;
        await NDialog(
          dialogStyle: DialogStyle(titleDivider: true),
          title: Text(title),
          content: TextViewerPage(
            textViewer: TextViewer.textValue(data),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Text("Close"),
              onPressed: () {
                Navigator.pop(topContextBackup);
              },
            ),
          ],
        ).show(topContextBackup, transitionType: DialogTransitionType.Bubble);
      },
      title: title,
    );
  }
}

class CustomTileSetting extends StatelessWidget {
  const CustomTileSetting({
    required this.onTap,
    required this.icon,
    required this.title,
    this.moreIconButton,
    Key? key,
  }) : super(key: key);
  final void Function()? onTap;
  final Icon icon;
  final Widget? moreIconButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: Theme.of(context).hoverColor,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextHeader(
                  text: title,
                ),
              ),
              Row(
                children: [
                  moreIconButton ?? const SizedBox(),
                  CustomButton(
                    onPressed: onTap,
                    child: icon,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckButtonLW extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  const CheckButtonLW({
    required this.text,
    required this.onPressed,
    this.color,
    this.width = double.infinity,
    this.height = 45,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 0.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.text = '',
  }) : super(key: key);
  final Widget? child;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: ElevatedButton(
        onPressed: onPressed,
        child: text.isNotEmpty ? Text(text) : child,
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/responsiveness.dart';
import '../widgets/side_menu/cubit/packageinfo_cubit.dart';
import '../widgets/style.dart';
import 'bloc/download_crop_image_bloc.dart';
import 'bloc/image_adjust_bloc.dart';
import 'cubit/reset_cp_cubit.dart';

class CheckerPage extends StatelessWidget {
  const CheckerPage({Key? key}) : super(key: key);

  static const String pathName = '/checker';
  static const String pageName = 'Checker';

  @override
  Widget build(BuildContext context) {
    return const CheckPageScreen();
  }
}

class CheckPageScreen extends StatelessWidget {
  const CheckPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedR = !ResponsiveWidget.isSmallScreen(context) ? 200 : 100;
    double sizedRPadding = !ResponsiveWidget.isSmallScreen(context) ? 0 : 10;
    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    var controlWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        UploadWidget(),
        DownloadWidget(),
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: sizedRPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextHeader(text: 'Upload image into pixels'),
                  if (!isSmallScreen) controlWidget
                ],
              ),
              if (isSmallScreen) controlWidget,
            ],
          ),
        ),
      ),
    );
  }
}

class UploadWidget extends StatelessWidget {
  const UploadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    var text = 'Import';
    return ValueListenableBuilder<bool>(
      valueListenable: context.read<ImageAdjustBloc>().isRunning,
      builder: (context, value, child) => Tooltip(
        message: text,
        waitDuration: const Duration(seconds: 1),
        child: TextButton.icon(
          onPressed: value
              ? null
              : () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<ResetCpCubit>().reset();
                  context
                      .read<ImageAdjustBloc>()
                      .add(ImageAdjustImportImageEvent());
                },
          icon: const Icon(Icons.upload),
          label: Text(isSmallScreen ? '' : text),
        ),
      ),
    );
  }
}

class DownloadWidget extends StatelessWidget {
  const DownloadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return BlocBuilder<PackageinfoCubit, PackageinfoState>(
      builder: (context, statepkinfo) {
        if (statepkinfo is PackageinfoFound) {
          return BlocBuilder<ImageAdjustBloc, ImageAdjustState>(
            buildWhen: (previous, current) =>
                (current is ImageAdjustCroped && current.isFinal) ||
                current is ImageAdjustImageUploading,
            builder: (context, stateImgAdj) {
              return BlocBuilder<DownloadCropImageBloc, DownloadCropImageState>(
                builder: (context, state) {
                  var isNotRunning = stateImgAdj is ImageAdjustCroped &&
                      (state is DownloadCropImageError ||
                          state is DownloadCropImageDone ||
                          state is DownloadCropImageInitial);
                  void Function()? onPressed;
                  if (isNotRunning) {
                    onPressed = () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context
                          .read<DownloadCropImageBloc>()
                          .add(DownloadCropImageSaveEvent(
                            mainImage: stateImgAdj.mainImage,
                            pixels: stateImgAdj.pixelCropData,
                            packageInfo: statepkinfo.packageInfo,
                          ));
                    };
                  }
                  var icon = const Icon(Icons.download_rounded);
                  var text = state is DownloadCropImageZiping
                      ? 'Ziping ...'
                      : Platform.isAndroid
                          ? 'Save into Internal storage'
                          : 'Download';
                  return Tooltip(
                    message: text,
                    waitDuration: const Duration(seconds: 1),
                    child: TextButton.icon(
                      onPressed: onPressed,
                      icon: icon,
                      label: Text(isSmallScreen ? '' : text),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return TextButton.icon(
            onPressed: null,
            icon: const Icon(Icons.download_rounded),
            label: const Text('Getting info'),
          );
        }
      },
    );
  }
}

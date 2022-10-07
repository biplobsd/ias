import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ias/core/cubit/top_context_cubit.dart';
import 'package:ias/utility/function/helper.dart';
import 'package:ias/view/checker/bloc/anim_image_bloc.dart';
import 'package:ndialog/ndialog.dart';

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
    var animImgBloc = context.read<AnimImageBloc>();
    var topContext = context.read<TopContextCubit>().topContextBackup;
    return MultiBlocListener(
      listeners: [
        BlocListener<ImageAdjustBloc, ImageAdjustState>(
          listener: (context, state) {
            if (state is ImageAdjustImported) {
              animImgBloc.add(
                AnimImageStartEvent(
                  mBytes: state.mBytes,
                ),
              );
            }
          },
        ),
        BlocListener<AnimImageBloc, AnimImageState>(
          listener: (context, state) async {
            if (state is AnimImageFrameSizeUpdate ||
                state is AnimImageSplitting) {
              await Future.delayed(const Duration());
              animImgBloc.add(AnimImageResumeEvent());
            } else if (state is AnimImageSplittingComplated) {
              Helper.customToast(
                context,
                "Splitting done",
                ToastMode.success,
              );
            }
          },
        ),
        BlocListener<DownloadCropImageBloc, DownloadCropImageState>(
          listener: (context, state) async {
            if (state is DownloadCropImageDone) {
              if (kIsWeb) {
                Helper.customToast(
                    context, 'Save ${state.fileName}', ToastMode.success);
              } else {
                await NDialog(
                  title: const Text('Save successful'),
                  content: Text('File save into ${state.fileName}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(topContext);
                      },
                      child: const Text('Close'),
                    )
                  ],
                ).show(
                  topContext,
                  transitionType: DialogTransitionType.Bubble,
                );
              }
            }
          },
        )
      ],
      child: const CheckPageScreen(),
    );
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

    var downloadImgB = context.read<DownloadCropImageBloc>();
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
              if (isSmallScreen)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: controlWidget,
                ),
              BlocBuilder<AnimImageBloc, AnimImageState>(
                buildWhen: (previous, current) =>
                    current is AnimImageFrameSizeUpdate ||
                    current is AnimImageInitial,
                builder: (context, state) {
                  Widget widget;
                  if (state is AnimImageFrameSizeUpdate) {
                    widget = GridView.builder(
                      key: UniqueKey(),
                      shrinkWrap: true,
                      itemCount: state.frameLen,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmallScreen ? 2 : 5,
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0,
                      ),
                      itemBuilder: (context, index) => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: BlocBuilder<AnimImageBloc, AnimImageState>(
                          key: UniqueKey(),
                          buildWhen: (previous, current) =>
                              current is AnimImageSplitting &&
                              current.id == index,
                          builder: (context, state) {
                            Widget? child;
                            if (state is AnimImageSplitting) {
                              child = Image.memory(
                                state.imageBytes,
                              );
                            }
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              switchInCurve: Curves.bounceIn,
                              switchOutCurve: Curves.bounceInOut,
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                              child: Ink(
                                key: UniqueKey(),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Stack(
                                  children: [
                                    if (child != null) child,
                                    Opacity(
                                      opacity: 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 5),
                                        child: Text(
                                          (index + 1).toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Opacity(
                                          opacity: 0.4,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (Platform.isAndroid)
                                                IconButton(
                                                  splashRadius: 20,
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.share_rounded,
                                                  ),
                                                ),
                                              IconButton(
                                                splashRadius: 20,
                                                onPressed: state
                                                        is AnimImageSplitting
                                                    ? () {
                                                        downloadImgB.add(
                                                            DownloadCropImageSaveSingleEvent(
                                                          id: state.id,
                                                          imageBytes:
                                                              state.imageBytes,
                                                          mBytes: state.mBytes,
                                                        ));
                                                      }
                                                    : null,
                                                icon: const Icon(Icons.save),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    widget = SizedBox(
                      key: UniqueKey(),
                    );
                  }
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: widget,
                  );
                },
              )
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
          return BlocBuilder<AnimImageBloc, AnimImageState>(
            builder: (context, stateAnim) {
              return BlocBuilder<DownloadCropImageBloc, DownloadCropImageState>(
                builder: (context, state) {
                  var isNotRunning = stateAnim is AnimImageSplittingComplated &&
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
                            mainImage: stateAnim.mBytes,
                            pixels: stateAnim.pixelBytes,
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

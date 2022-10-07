import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ias/core/cubit/top_context_cubit.dart';
import 'package:ias/utility/function/helper.dart';
import 'package:ias/view/checker/bloc/anim_image_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/responsiveness.dart';
import '../widgets/side_menu/cubit/packageinfo_cubit.dart';
import '../widgets/style.dart';
import 'bloc/download_crop_image_bloc.dart';
import 'bloc/image_adjust_bloc.dart';
import 'cubit/reset_cp_cubit.dart';

class CheckerPage extends StatelessWidget {
  const CheckerPage({Key? key}) : super(key: key);

  static const String pathName = '/home';
  static const String pageName = 'Home';

  @override
  Widget build(BuildContext context) {
    var animImgBloc = context.read<AnimImageBloc>();
    var imgAdjBloc = context.read<ImageAdjustBloc>();
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
            } else if (state is ImageAdjustImageUploading) {
              imgAdjBloc.running = true;
            } else if (state is ImageAdjustImageError) {
              imgAdjBloc.running = false;
            }
          },
        ),
        BlocListener<AnimImageBloc, AnimImageState>(
          listener: (context, state) async {
            if (state is AnimImageFrameSizeUpdate ||
                state is AnimImageSplitting) {
              // await Future.delayed(const Duration(milliseconds: 500));
              animImgBloc.add(AnimImageResumeEvent());
              imgAdjBloc.running = true;
            } else if (state is AnimImageSplittingComplated) {
              imgAdjBloc.running = false;
              Helper.customToast(
                context,
                "Splitting done",
                ToastMode.success,
              );
            } else if (state is! AnimImageDecodeing) {
              imgAdjBloc.running = false;
            }
          },
        ),
        BlocListener<DownloadCropImageBloc, DownloadCropImageState>(
          listener: (context, state) async {
            if (state is DownloadCropImageDone) {
              if (state.share) {
                await Share.shareFiles(
                  [state.fileName],
                  text: state.fileName,
                );
              } else {
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
                      ),
                      TextButton(
                        onPressed: () async {
                          await Share.shareXFiles(
                            [
                              XFile(state.fileName),
                            ],
                            text: state.fileName,
                          );
                        },
                        child: const Text('Share'),
                      )
                    ],
                  ).show(
                    topContext,
                    transitionType: DialogTransitionType.Bubble,
                  );
                }
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
    double sizedRPadding = !ResponsiveWidget.isSmallScreen(context) ? 0 : 10;
    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    var downloadImgB = context.read<DownloadCropImageBloc>();
    var animImageB = context.read<AnimImageBloc>();
    var controlWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        UploadWidget(),
        DownloadWidget(),
      ],
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: sizedRPadding,
          bottom: 20,
        ),
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
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: BlocBuilder<AnimImageBloc, AnimImageState>(
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
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, index) {
                          Widget? child;
                          Uint8List? imageBytes;
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: BlocBuilder<AnimImageBloc, AnimImageState>(
                              key: UniqueKey(),
                              buildWhen: (previous, current) =>
                                  current is AnimImageSplitting &&
                                  current.id == index,
                              builder: (context, state) {
                                try {
                                  imageBytes = animImageB.pixelBytes[index];
                                  // ignore: empty_catches
                                } catch (e) {}

                                if (imageBytes != null) {
                                  child = Image.memory(
                                    imageBytes!,
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
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (child != null) child!,
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 5),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Opacity(
                                              opacity: 0.9,
                                              child: Text(
                                                index.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Opacity(
                                              opacity: 0.9,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8, bottom: 5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        splashRadius: 20,
                                                        onPressed: imageBytes !=
                                                                null
                                                            ? () {
                                                                downloadImgB
                                                                    .add(
                                                                  DownloadCropImageSaveSingleEvent(
                                                                    share: true,
                                                                    id: index,
                                                                    imageBytes:
                                                                        imageBytes!,
                                                                    mBytes: animImageB
                                                                        .mBytes!,
                                                                  ),
                                                                );
                                                              }
                                                            : null,
                                                        icon: const Icon(
                                                          Icons.share_rounded,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        tooltip: 'Save frame',
                                                        splashRadius: 20,
                                                        onPressed:
                                                            imageBytes != null
                                                                ? () {
                                                                    downloadImgB
                                                                        .add(
                                                                      DownloadCropImageSaveSingleEvent(
                                                                        id: index,
                                                                        imageBytes:
                                                                            imageBytes!,
                                                                        mBytes:
                                                                            animImageB.mBytes!,
                                                                      ),
                                                                    );
                                                                  }
                                                                : null,
                                                        icon: const Icon(
                                                            Icons.save),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                          );
                        },
                      );
                    } else {
                      widget = Column(
                        key: UniqueKey(),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.gif_box),
                            label: const Text('image frame will show here'),
                          ),
                        ],
                      );
                    }
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.bounceIn,
                      switchOutCurve: Curves.bounceInOut,
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: widget,
                    );
                  },
                ),
              ),
            )
          ],
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
      builder: (context, value, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: value
            ? SizedBox(
                key: UniqueKey(),
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ))
            : Tooltip(
                key: UniqueKey(),
                message: text,
                waitDuration: const Duration(seconds: 1),
                child: TextButton.icon(
                  onPressed: () {
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
                  Widget widget;
                  var icon = const Icon(Icons.download_rounded);
                  var text = state is DownloadCropImageZiping
                      ? 'Ziping ...'
                      : Platform.isAndroid
                          ? 'Save into Internal storage'
                          : 'Download';

                  if (state is! DownloadCropImageZiping) {
                    widget = Tooltip(
                      key: UniqueKey(),
                      message: text,
                      waitDuration: const Duration(seconds: 1),
                      child: TextButton.icon(
                        onPressed: stateAnim is AnimImageSplittingComplated
                            ? () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                context
                                    .read<DownloadCropImageBloc>()
                                    .add(DownloadCropImageSaveEvent(
                                      mainImage: stateAnim.mBytes,
                                      pixels: stateAnim.pixelBytes,
                                      packageInfo: statepkinfo.packageInfo,
                                    ));
                              }
                            : null,
                        icon: icon,
                        label: Text(isSmallScreen ? '' : text),
                      ),
                    );
                  } else {
                    widget = SizedBox(
                        key: UniqueKey(),
                        height: 20,
                        width: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ));
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: widget,
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

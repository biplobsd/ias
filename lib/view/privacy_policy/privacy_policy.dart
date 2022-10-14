import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../bloc/ads_bloc.dart';
import 'cubit/get_privacy_policy_cubit.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String pathName = '/privacy_policy';
  static const String pageName = 'Privacy policy';
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetPrivacyPolicyCubit>().fetch();
    var markdownScrollC = ScrollController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<GetPrivacyPolicyCubit, GetPrivacyPolicyState>(
            builder: (context, state) {
              if (state is GetPrivacyPolicyFound) {
                return Markdown(
                  padding: const EdgeInsets.only(
                    bottom: 50,
                    right: 15,
                    left: 15,
                  ),
                  controller: markdownScrollC,
                  data: state.data,
                  selectable: true,
                );
              } else if (state is GetPrivacyPolicyError) {
                return Text(
                  state.errorMsg,
                  style: Theme.of(context).textTheme.displayMedium,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          BlocBuilder<AdsBloc, AdsState>(
            builder: (context, state) {
              if (state is AdsLoaded) {
                var ad = context.read<AdsBloc>().myBanners[1];
                return Container(
                  alignment: Alignment.center,
                  width: ad.size.width.toDouble(),
                  height: ad.size.height.toDouble(),
                  child: AdWidget(ad: ad),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

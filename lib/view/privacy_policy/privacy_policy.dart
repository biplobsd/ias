import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:preloadwebapptemplate/view/privacy_policy/cubit/get_privacy_policy_cubit.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String pathName = '/privacy_policy';
  static const String pageName = 'Privacy policy';
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetPrivacyPolicyCubit>().fetch();
    var markdownScrollC = ScrollController();

    return Scaffold(
      body: BlocBuilder<GetPrivacyPolicyCubit, GetPrivacyPolicyState>(
        builder: (context, state) {
          if (state is GetPrivacyPolicyFound) {
            return Markdown(
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
    );
  }
}

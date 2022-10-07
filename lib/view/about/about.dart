import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/url.dart';
import 'package:preloadwebapptemplate/view/widgets/power_by.dart';
import 'package:preloadwebapptemplate/view/widgets/responsiveness.dart';
import 'package:preloadwebapptemplate/view/widgets/side_menu/cubit/packageinfo_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/function/helper.dart';

class About extends StatelessWidget {
  static const String pathName = '/about';
  static const String pageName = 'About';
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedRPadding = !ResponsiveWidget.isSmallScreen(context) ? 25 : 10;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: sizedRPadding,
          right: sizedRPadding,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<PackageinfoCubit, PackageinfoState>(
                builder: (context, state) {
                  if (state is PackageinfoFound) {
                    String appInfotxt =
                        "${AppString.appName} v${state.packageInfo.version} #${state.packageInfo.buildNumber}";
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Helper.copyToClipboard(context, appInfotxt);
                          },
                          child: Text(
                            appInfotxt,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const PowerBy(),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  if (!await launchUrl(AppUrl.speedOut)) {
                    throw 'Could not launch ${AppUrl.speedOut}';
                  }
                },
                child: Text(
                  "Developed by SpeedOut, 2022",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 9),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Developer info",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DevInfoTile(
                profileUrl:
                    'https://avatars.githubusercontent.com/u/43641536?v=4',
                name: "Biplob Kumar Sutradhar",
                email: "biplobsd11@gmail.com",
                role: "Lead developer",
                devGithub: AppUrl.devGithubBiplob,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Issue or Bug report",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text("Report on Github issue tab"),
                subtitle: const Text(
                    "Before reporting any issue or bug report please add proper description and screenshots to help fix the problem."),
                trailing: TextButton(
                  onPressed: () async {
                    if (!await launchUrl(AppUrl.issueGithub)) {
                      throw 'Could not launch ${AppUrl.issueGithub}';
                    }
                  },
                  child: const Text(
                    'Issue',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DevInfoTile extends StatelessWidget {
  final String profileUrl;
  final String name;
  final String email;
  final String role;
  final Uri devGithub;
  const DevInfoTile({
    required this.profileUrl,
    required this.email,
    required this.name,
    required this.role,
    required this.devGithub,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (!await launchUrl(devGithub)) {
          throw 'Could not launch $devGithub';
        }
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            profileUrl,
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 3,
            ),
            // Text(email),
            Text(role),
          ],
        ),
      ),
    );
  }
}

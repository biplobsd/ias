import 'package:flutter/material.dart';
import 'package:preloadwebapptemplate/constants/string.dart';
import 'package:preloadwebapptemplate/constants/url.dart';
import 'package:url_launcher/url_launcher.dart';

class PowerBy extends StatelessWidget {
  const PowerBy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(AppUrl.acctionTokenUri)) {
          throw 'Could not launch ${AppUrl.acctionTokenUri}';
        }
      },
      child: Text(
        AppString.poweredByTitle,
        style: Theme.of(context).textTheme.overline!.copyWith(
            color:
                Theme.of(context).textTheme.overline!.color!.withOpacity(0.6)),
        textAlign: TextAlign.end,
      ),
    );
  }
}

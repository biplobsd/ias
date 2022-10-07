import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/string.dart';
import '../../constants/url.dart';

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
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color:
                Theme.of(context).textTheme.labelSmall!.color!.withOpacity(0.6)),
        textAlign: TextAlign.end,
      ),
    );
  }
}

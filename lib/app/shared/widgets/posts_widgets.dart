import 'package:ericpereira/app/shared/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'snackbar/snackbar.dart';

class PostWidget extends StatefulWidget {
  final String date;
  final String title;
  final String? detail;
  final String? url;
  const PostWidget({
    required this.date,
    required this.title,
    this.detail,
    this.url,
    super.key,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime formattedTime =
        DateFormat('dd/MM/yyyy', 'pt_BR').parse(widget.date);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
              spacing: 15,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextCustom(
                    DateFormat("d 'de' MMMM 'de' y", 'pt_BR')
                        .format(formattedTime),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextCustom(
                        widget.title,
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                      widget.detail != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: TextCustom(
                                widget.detail!,
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                            )
                          : Container(),
                      widget.url != null
                          ? InkWell(
                              onTap: () async {
                                if (await canLaunchUrl(
                                    Uri.parse(widget.url!))) {
                                  await launchUrl(Uri.parse(widget.url!));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  snackBarWarning(
                                      'Não foi possível acessar a página',
                                      context: context);
                                  throw 'Could not launch $widget.url';
                                }
                              },
                              child: TextCustom(
                                'ver →',
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 0.2,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

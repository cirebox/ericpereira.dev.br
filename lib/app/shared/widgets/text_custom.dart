import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TextCustom extends StatefulWidget {
  final String data;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final Function()? onTap;
  final int? maxLines;

  const TextCustom(
    this.data, {
    super.key,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.textDecoration,
    this.textHeight,
    this.onTap,
    this.maxLines,
  });

  @override
  State<TextCustom> createState() => _TextCustomState();
}

class _TextCustomState extends State<TextCustom> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return widget.onTap != null
        ? InkWell(
            onTap: () {
              setState(() {
                isHover = !isHover;
              });
              widget.onTap!();
            },
            onHover: (isHovering) {},
            child: _text(),
          )
        : _text();
  }

  Widget _text() => Text(
        widget.data,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        textScaleFactor: 0.8,
        softWrap: true,
        maxLines: widget.maxLines,
        style: GoogleFonts.roboto(
          height: widget.textHeight,
          textStyle: TextStyle(
            color: isHover ? Colors.blue : widget.color,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            decoration:
                isHover ? TextDecoration.underline : widget.textDecoration,
            letterSpacing: .5,
          ),
        ),
      );
}

class TextSpanCustom extends TextSpan {
  final String data;
  final TextOverflow? textOverflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final String? href;
  TextSpanCustom(
    this.data, {
    this.textOverflow,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.textDecoration,
    this.textHeight,
    this.href,
    super.children,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  }) : super(
          text: data,
          style: GoogleFonts.roboto(
            height: textHeight,
            color: color,
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: .5,
              overflow: textOverflow,
              decoration: textDecoration,
            ),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (href != null) {
                if (await canLaunchUrl(Uri.parse(href))) {
                  await launchUrl(Uri.parse(href));
                } else {
                  // ignore: use_build_context_synchronously
                  throw 'Could not launch $href';
                }
              }
            },
        );
}

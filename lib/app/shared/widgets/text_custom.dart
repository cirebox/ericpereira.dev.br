import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustom extends StatefulWidget {
  final String data;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final Function()? onTap;

  const TextCustom(
    this.data, {
    super.key,
    this.textAlign = TextAlign.start,
    this.textOverflow,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.textDecoration,
    this.textHeight,
    this.onTap,
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
        overflow: widget.textOverflow,
        textScaleFactor: 0.8,
        softWrap: true,
        maxLines: 8,
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

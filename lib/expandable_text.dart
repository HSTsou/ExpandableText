import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(
    this.text, {
    this.expandLabelText = 'See More',
    this.expandLabel = '... ',
    this.maxLines = 2,
    this.originalTextTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    this.expandableTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
  });

  final String text;
  final String expandLabelText;
  final String expandLabel;
  final int maxLines;
  final TextStyle originalTextTextStyle;
  final TextStyle expandableTextStyle;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  static final int safePlusOffset = 1;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TextSpan expandableTextSpan = TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: widget.expandLabelText,
          style: widget.expandableTextStyle,
          recognizer: new TapGestureRecognizer()..onTap = _onExpandTextTap,
        ),
      ],
      text: widget.expandLabel,
      style: widget.originalTextTextStyle,
    );

    final TextSpan originalTextSpan = TextSpan(
      text: widget.text,
      style: widget.originalTextTextStyle,
      recognizer: new TapGestureRecognizer()..onTap = _onExpandTextTap,
    );

    return LayoutBuilder(builder: (context, size) {
      TextPainter expandableTextTP = _getTextPainter(expandableTextSpan, size);
      TextPainter originalTextTP = _getTextPainter(originalTextSpan, size);

      final lastLinePosOffset = originalTextTP.getPositionForOffset(Offset(
        originalTextTP.size.width - expandableTextTP.size.width,
        originalTextTP.size.height,
      ));

      if (!originalTextTP.didExceedMaxLines || isExpanded) {
        return RichText(
          maxLines: null,
          text: TextSpan(
            children: <TextSpan>[
              originalTextSpan,
            ],
            recognizer: new TapGestureRecognizer()..onTap = _onExpandTextTap,
          ),
        );
      } else {
        return RichText(
          maxLines: widget.maxLines,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: widget.text
                      .substring(0, lastLinePosOffset.offset - safePlusOffset),
                  style: widget.originalTextTextStyle),
              expandableTextSpan,
            ],
//            recognizer: new TapGestureRecognizer()..onTap = _onExpandTextTap,
          ),
        );
      }
    });
  }

  TextPainter _getTextPainter(TextSpan textSpan, var size) {
    TextPainter textPainter = TextPainter(
        text: textSpan,
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: size.maxWidth);
    return textPainter;
  }

  void _onExpandTextTap() {
    this.setState(() {
      isExpanded = !isExpanded;
    });
  }
}

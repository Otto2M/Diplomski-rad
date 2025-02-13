import 'package:flutter/material.dart';
import 'package:povedi_me_app/constants/styles/text.dart';

List<String> splitTextBySentences(String text, int sentencesPerParagraph) {
  RegExp regex = RegExp(
      r'(?<!\b(?:st|god|dr|mr|sr|dipl|bacc|mag|phd|prof|i|v|x|l|c|m)\.)(?<=\.)\s+(?=[A-ZŠĐŽĆČ])');

  List<String> sentences = text.split(regex);

  List<String> paragraphs = [];

  for (int i = 0; i < sentences.length; i += sentencesPerParagraph) {
    paragraphs.add(
      sentences
          .sublist(
              i,
              i + sentencesPerParagraph > sentences.length
                  ? sentences.length
                  : i + sentencesPerParagraph)
          .join(' ')
          .trim(),
    );
  }

  return paragraphs;
}

Widget buildParagraphs(BuildContext context, List<String> paragraphs) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: paragraphs.map((paragraph) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          paragraph,
          textAlign: TextAlign.justify,
          style: AppTextStyles.description(context),
        ),
      );
    }).toList(),
  );
}

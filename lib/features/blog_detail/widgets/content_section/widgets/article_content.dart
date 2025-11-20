import 'code_block.dart';
import 'callout_box.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class ArticleContent extends StatelessWidget {
  final String content;
  final Map<int, GlobalKey> headingKeys;

  const ArticleContent({super.key, required this.content, required this.headingKeys});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    // Parse content into widgets
    final widgets = _parseContent(content, context, s, fonts);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  List<Widget> _parseContent(String content, BuildContext context, DSizes s, AppFonts fonts) {
    final List<Widget> widgets = [];
    final lines = content.split('\n');
    String codeBuffer = '';
    String codeLanguage = '';
    bool inCodeBlock = false;
    int headingIndex = 0;

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Code block start
      if (line.startsWith('```')) {
        if (!inCodeBlock) {
          inCodeBlock = true;
          codeLanguage = line.replaceAll('```', '').trim();
          if (codeLanguage.isEmpty) codeLanguage = 'dart';
          continue;
        } else {
          // Code block end
          inCodeBlock = false;
          if (codeBuffer.isNotEmpty) {
            widgets.add(CodeBlock(code: codeBuffer.trim(), language: codeLanguage));
            codeBuffer = '';
          }
          continue;
        }
      }

      if (inCodeBlock) {
        codeBuffer += '$line\n';
        continue;
      }

      // ✅ H2 heading (with key for scrolling)
      if (line.startsWith('## ')) {
        final headingText = line.replaceAll('## ', '');
        final key = headingKeys[headingIndex];

        widgets.add(
          Container(
            key: key,
            child: Text(
              headingText,
              style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            ),
          ),
        );

        headingIndex++;
        continue;
      }

      // H3 heading
      if (line.startsWith('### ')) {
        widgets.add(SizedBox(height: s.spaceBtwItems));
        widgets.add(
          Text(
            line.replaceAll('### ', ''),
            style: fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
        );
        widgets.add(SizedBox(height: s.paddingSm));
        continue;
      }

      // Callout boxes
      if (line.startsWith('💡 ')) {
        widgets.add(CalloutBox(text: line.replaceAll('💡 ', ''), type: CalloutType.tip));
        continue;
      }

      if (line.startsWith('⚠️ ')) {
        widgets.add(CalloutBox(text: line.replaceAll('⚠️ ', ''), type: CalloutType.warning));
        continue;
      }

      if (line.startsWith('📝 ')) {
        widgets.add(CalloutBox(text: line.replaceAll('📝 ', ''), type: CalloutType.note));
        continue;
      }

      if (line.startsWith('✅ ')) {
        widgets.add(CalloutBox(text: line.replaceAll('✅ ', ''), type: CalloutType.success));
        continue;
      }

      // Bullet list
      if (line.trim().startsWith('- ') || line.trim().startsWith('* ')) {
        widgets.add(
          Padding(
            padding: EdgeInsets.only(left: s.paddingMd, bottom: s.paddingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: fonts.bodyLarge.rubik(color: DColors.primaryButton)),
                SizedBox(width: s.paddingSm),
                Expanded(
                  child: Text(
                    line.replaceAll(RegExp(r'^[\s\-\*]+'), ''),
                    style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.7),
                  ),
                ),
              ],
            ),
          ),
        );
        continue;
      }

      // Empty line
      if (line.trim().isEmpty) {
        widgets.add(SizedBox(height: s.paddingSm));
        continue;
      }

      // Regular paragraph
      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: s.paddingMd),
          child: Text(
            line,
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.7, fontSize: 16),
          ),
        ),
      );
    }

    return widgets;
  }
}

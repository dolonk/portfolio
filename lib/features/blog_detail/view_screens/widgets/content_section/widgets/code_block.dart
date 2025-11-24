import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class CodeBlock extends StatefulWidget {
  final String code;
  final String language;

  const CodeBlock({super.key, required this.code, this.language = 'dart'});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      margin: EdgeInsets.symmetric(vertical: s.paddingMd),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: DColors.cardBorder.withAlpha((255 * 0.3).round())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with language and copy button
          Container(
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha((255 * 0.3).round()),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s.borderRadiusMd),
                topRight: Radius.circular(s.borderRadiusMd),
              ),
            ),
            child: Row(
              children: [
                // Language tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
                  decoration: BoxDecoration(
                    color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.language.toUpperCase(),
                    style: fonts.labelSmall.rubik(
                      color: DColors.primaryButton,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),

                // Copy button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _copyCode,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
                      decoration: BoxDecoration(
                        color: _isCopied ? Colors.green.withAlpha((255 * 0.2).round()) : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _isCopied ? Colors.green : DColors.cardBorder),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isCopied ? Icons.check_rounded : Icons.copy_rounded,
                            color: _isCopied ? Colors.green : DColors.textSecondary,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _isCopied ? 'Copied!' : 'Copy',
                            style: fonts.labelSmall.rubik(
                              color: _isCopied ? Colors.green : DColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Code content
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(s.paddingMd),
            child: SelectableText(
              widget.code,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFFD4D4D4), // VS Code text color
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _isCopied = true);

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isCopied = false);
      }
    });
  }
}

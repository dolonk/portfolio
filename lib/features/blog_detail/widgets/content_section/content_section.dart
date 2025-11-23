import 'widgets/article_content.dart';
import 'widgets/table_of_contents.dart';
import 'package:flutter/material.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../project_detail/widgets/gallery/gallery_section.dart';
import '../../../project_detail/widgets/demo_links/ widgets/video_player.dart';

class ContentSection extends StatefulWidget {
  final BlogPost post;

  const ContentSection({super.key, required this.post});

  @override
  State<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends State<ContentSection> {
  int _activeHeadingIndex = 0;
  List<String> _headings = [];
  Map<int, GlobalKey> _headingKeys = {};

  @override
  void initState() {
    super.initState();
    _extractHeadings();
    _createHeadingKeys();
  }

  /// Extract H2 headings from content for TOC
  void _extractHeadings() {
    final lines = widget.post.content.split('\n');
    _headings = lines.where((line) => line.startsWith('## ')).map((line) => line.replaceAll('## ', '')).toList();
  }

  /// Create GlobalKeys for each heading
  void _createHeadingKeys() {
    _headingKeys = {for (var i = 0; i < _headings.length; i++) i: GlobalKey()};
  }

  /// Scroll to heading when TOC item is tapped
  void _scrollToHeading(int index) {
    setState(() => _activeHeadingIndex = index);

    final key = _headingKeys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: context.isMobile ? _buildMobileLayout(s) : _buildDesktopLayout(s),
    );
  }

  /// Desktop/Tablet Layout (Content + Sidebar)
  Widget _buildDesktopLayout(DSizes s) {
    return Column(
      children: [
        if (widget.post.videoUrl != null && widget.post.videoUrl!.isNotEmpty)
          YouTubeVideoPlayer(videoUrl: widget.post.videoUrl!),
        SizedBox(height: s.spaceBtwSections),

        if (widget.post.contentImages.isNotEmpty) GallerySection(imagesGallery: widget.post.contentImages),
        SizedBox(height: s.spaceBtwSections),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Content (70%)
            Expanded(
              flex: 70,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ArticleContent(content: widget.post.content, headingKeys: _headingKeys),
              ),
            ),
            SizedBox(width: s.spaceBtwSections),

            // TOC Sidebar (30%)
            Expanded(
              flex: 30,
              child: _headings.isNotEmpty
                  ? TableOfContents(
                      headings: _headings,
                      activeIndex: _activeHeadingIndex,
                      onHeadingTap: _scrollToHeading,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }

  /// Mobile Layout (Content then TOC)
  Widget _buildMobileLayout(DSizes s) {
    return Column(
      children: [
        if (widget.post.videoUrl != null && widget.post.videoUrl!.isNotEmpty)
          YouTubeVideoPlayer(videoUrl: widget.post.videoUrl!),
        SizedBox(height: s.spaceBtwSections),

        // TOC at top (collapsible)
        if (_headings.isNotEmpty) ...[
          TableOfContents(headings: _headings, activeIndex: _activeHeadingIndex, onHeadingTap: _scrollToHeading),
          SizedBox(height: s.spaceBtwSections),
        ],

        // Main Content
        ArticleContent(content: widget.post.content, headingKeys: _headingKeys),
      ],
    );
  }
}

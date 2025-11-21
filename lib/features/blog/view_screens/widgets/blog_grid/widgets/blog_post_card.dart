import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/blog/blog_post_model.dart';

import '../../../../../route/route_name.dart';

class BlogPostCard extends StatefulWidget {
  final BlogPostModel post;

  const BlogPostCard({super.key, required this.post});

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.go('${RouteNames.blog}/${widget.post.id}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(
              color: _isHovered ? DColors.primaryButton : DColors.cardBorder,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha((255 * 0.2).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Category Badge
              _buildImageSection(context, s),

              // Content Section
              Padding(
                padding: EdgeInsets.all(s.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    _buildTitle(context, s),
                    SizedBox(height: s.paddingSm),

                    // Excerpt
                    _buildExcerpt(context, s),
                    SizedBox(height: s.paddingMd),

                    // Meta Info (Author, Date, Reading Time)
                    _buildMetaInfo(context, s),
                    SizedBox(height: s.paddingMd),

                    // Tags
                    _buildTags(context, s),
                    SizedBox(height: s.paddingMd),

                    // Read More Link
                    _buildReadMoreLink(context, s),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Image Section with Category Badge and Optional View Count
  Widget _buildImageSection(BuildContext context, DSizes s) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(s.borderRadiusLg),
        topRight: Radius.circular(s.borderRadiusLg),
      ),
      child: SizedBox(
        height: context.responsiveValue(mobile: 180.0, tablet: 200.0, desktop: 220.0),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                widget.post.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: DColors.cardBorder,
                    child: Icon(Icons.article_rounded, size: 60, color: DColors.textSecondary),
                  );
                },
              ),
            ),

            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withAlpha((255 * 0.6).round()), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Category Badge (Top Left)
            Positioned(
              top: s.paddingMd,
              left: s.paddingMd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
                decoration: BoxDecoration(
                  color: DColors.primaryButton.withAlpha((255 * 0.9).round()),
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                ),
                child: Text(
                  widget.post.category,
                  style: context.fonts.labelSmall.rubik(
                    color: DColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // View Count (Bottom Right) - Optional
            if (widget.post.viewCount > 0)
              Positioned(
                bottom: s.paddingMd,
                right: s.paddingMd,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: s.paddingXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha((255 * 0.6).round()),
                    borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility_rounded, color: DColors.textPrimary, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '${widget.post.viewCount}',
                        style: context.fonts.labelSmall.rubik(color: DColors.textPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Title
  Widget _buildTitle(BuildContext context, DSizes s) {
    return Text(
      widget.post.title,
      style: context.fonts.titleLarge.rajdhani(
        fontWeight: FontWeight.bold,
        color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
        fontSize: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Excerpt
  Widget _buildExcerpt(BuildContext context, DSizes s) {
    return Text(
      widget.post.excerpt,
      style: context.fonts.bodySmall.rubik(
        color: DColors.textSecondary,
        height: 1.6,
        fontSize: context.responsiveValue(mobile: 13.0, tablet: 14.0, desktop: 14.0),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Meta Info (Author + Date + Reading Time)
  Widget _buildMetaInfo(BuildContext context, DSizes s) {
    return Row(
      children: [
        // Author
        Icon(Icons.person_rounded, color: DColors.textSecondary, size: 14),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            widget.post.author,
            style: context.fonts.labelSmall.rubik(color: DColors.textSecondary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: s.paddingSm),

        // Separator
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(color: DColors.textSecondary, shape: BoxShape.circle),
        ),
        SizedBox(width: s.paddingSm),

        // Date
        Icon(Icons.calendar_today_rounded, color: DColors.textSecondary, size: 14),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            widget.post.publishedDate,
            style: context.fonts.labelSmall.rubik(color: DColors.textSecondary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Tags (Max 3)
  Widget _buildTags(BuildContext context, DSizes s) {
    final displayTags = widget.post.tags.take(3).toList();

    return Wrap(
      spacing: s.paddingSm,
      runSpacing: s.paddingSm,
      children: displayTags.map((tag) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 1),
          ),
          child: Text(
            '#$tag',
            style: context.fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 11),
          ),
        );
      }).toList(),
    );
  }

  /// Read More Link
  Widget _buildReadMoreLink(BuildContext context, DSizes s) {
    return Row(
      children: [
        Text(
          'Read More',
          style: context.fonts.bodySmall.rubik(
            color: _isHovered ? DColors.primaryButton : DColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.arrow_forward_rounded,
          color: _isHovered ? DColors.primaryButton : DColors.textSecondary,
          size: 16,
        ),
      ],
    );
  }
}

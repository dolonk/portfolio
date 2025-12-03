import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../../route/route_name.dart';
import '../../../../view_models/blog_view_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/data_layer/domain/entities/blog/blog_post.dart';

class RecentPostsWidget extends StatelessWidget {
  const RecentPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final viewModel = BlogViewModel(context);
    final recentPosts = viewModel.recentPosts;
    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Row(
            children: [
              Icon(Icons.schedule_rounded, color: DColors.primaryButton, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Recent Posts',
                style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Recent Posts List
          ...recentPosts.asMap().entries.map((entry) {
            final index = entry.key;
            final post = entry.value;
            final isLast = index == recentPosts.length - 1;

            return Column(
              children: [
                _RecentPostItem(post: post),
                if (!isLast) SizedBox(height: s.paddingMd),
                if (!isLast) Divider(color: DColors.cardBorder, height: 1),
                if (!isLast) SizedBox(height: s.paddingMd),
              ],
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideX(begin: 0.1, duration: 600.ms, delay: 500.ms);
  }
}

class _RecentPostItem extends StatefulWidget {
  final BlogPost post;

  const _RecentPostItem({required this.post});

  @override
  State<_RecentPostItem> createState() => _RecentPostItemState();
}

class _RecentPostItemState extends State<_RecentPostItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('${RouteNames.blog}/${widget.post.id}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                  widget.post.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: DColors.cardBorder,
                      child: Icon(Icons.article_rounded, color: DColors.textSecondary, size: 24),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: s.paddingMd),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: fonts.bodySmall.rubik(
                      color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.post.publishedDate,
                    style: fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

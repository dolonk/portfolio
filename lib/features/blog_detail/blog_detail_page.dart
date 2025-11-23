import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import 'widgets/content_section/content_section.dart';
import '../../common_function/exception_ui/error/error_state.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import 'package:portfolio/features/blog/view_models/blog_view_model.dart';
import '../../common_function/exception_ui/loading/blog_details_page.dart';
import '../../common_function/exception_ui/data_not_found/not_found_state.dart';
import 'package:portfolio/features/blog_detail/widgets/comments/comments_section.dart';
import 'package:portfolio/features/blog_detail/widgets/hero_section/blog_detail_hero.dart';
import 'package:portfolio/features/blog_detail/widgets/newsletter/newsletter_cta_section.dart';

class BlogDetailPage extends StatefulWidget {
  final String postId;

  const BlogDetailPage({super.key, required this.postId});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late final viewModel = BlogViewModel(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchPostById(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(backgroundColor: DColors.background, child: _buildContent(context, viewModel));
  }

  /// Build content based on state
  Widget _buildContent(BuildContext context, BlogViewModel viewModel) {
    // ==================== LOADING STATE ====================
    if (viewModel.isDetailLoading) {
      return const BlogDetailPageLoading();
    }

    // ==================== ERROR STATE ====================
    if (viewModel.hasDetailError) {
      return ErrorState(
        message: viewModel.errorMessage ?? 'Failed to load post',
        onRetry: () => viewModel.fetchPostById(widget.postId),
      );
    }

    // ==================== EMPTY/NOT FOUND STATE ====================
    final post = viewModel.selectedPost;
    if (post == null) {
      return const DataNotFoundState();
    }

    // ==================== SUCCESS STATE ====================
    return Column(
      children: [
        // Hero + Post Header
        BlogDetailHero(post: post),

        // Content
        ContentSection(post: post),

        // Comments
        CommentsSection(post: post),

        // Newsletter CTA
        const NewsletterCtaSection(),
      ],
    );
  }
}

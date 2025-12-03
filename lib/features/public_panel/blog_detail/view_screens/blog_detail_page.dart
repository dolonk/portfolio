import 'package:flutter/material.dart';
import '../../../../common_function/state_widgets/data_not_found/not_found_state.dart';
import '../../../../common_function/state_widgets/error/error_state.dart';
import '../../../../common_function/state_widgets/loading/blog_details_page.dart';
import '../../../../common_function/state_widgets/state_builder.dart';
import '../../../../utility/constants/colors.dart';
import '../../blog/view_models/blog_view_model.dart';
import 'widgets/comments/comments_section.dart';
import 'widgets/hero_section/blog_detail_hero.dart';
import 'widgets/content_section/content_section.dart';
import 'widgets/newsletter/newsletter_cta_section.dart';
import 'package:portfolio/data_layer/domain/entities/blog/blog_post.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';

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
    return BaseScreen(
      backgroundColor: DColors.background,
      child: DStateBuilder<BlogPost>(
        state: viewModel.detailState,
        onLoading: () => const BlogDetailPageLoading(),
        onError: (msg) => ErrorState(message: msg, onRetry: () => viewModel.fetchPostById(widget.postId)),
        onEmpty: () => const DataNotFoundState(),
        onSuccess: (post) => Column(
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
        ),
      ),
    );
  }
}

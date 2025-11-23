import '../../../../../common_function/state_widgets/data_not_found/not_found_state.dart';
import '../../../../../common_function/state_widgets/error/error_state.dart';
import '../../../../../common_function/state_widgets/loading/blog_page.dart';
import '../../../../../common_function/state_widgets/state_builder.dart';
import '../../../../../data_layer/domain/entities/blog/blog_post.dart';
import 'widgets/blog_post_card.dart';
import 'widgets/load_more_button.dart';
import 'package:flutter/material.dart';
import '../sidebar/blog_sidebar.dart';
import '../../../view_models/blog_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class BlogGridSection extends StatelessWidget {
  const BlogGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlogViewModel(context);
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: context.isMobile ? _buildMobileLayout(context, viewModel, s) : _buildDesktopLayout(context, viewModel, s),
    );
  }

  /// Desktop/Tablet Layout (Grid + Sidebar)
  Widget _buildDesktopLayout(BuildContext context, BlogViewModel viewModel, DSizes s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blog Grid (Left - 70%)
        Expanded(flex: 70, child: _buildContent(context, viewModel, s)),
        SizedBox(width: s.spaceBtwSections),

        // Sidebar (Right - 30%)
        const Expanded(flex: 30, child: BlogSidebar()),
      ],
    );
  }

  /// Mobile Layout (Grid then Sidebar)
  Widget _buildMobileLayout(BuildContext context, BlogViewModel viewModel, DSizes s) {
    return Column(
      children: [
        // Blog Grid
        _buildContent(context, viewModel, s),
        SizedBox(height: s.spaceBtwSections),

        // Sidebar (Below)
        const BlogSidebar(),
      ],
    );
  }

  /// Build content based on state
  /*Widget _buildContent(BuildContext context, BlogViewModel viewModel, DSizes s) {
    // ==================== LOADING STATE (First time) ====================
    if (viewModel.isLoading && viewModel.allPosts.isEmpty) {
      return const BlogPage();
    }

    // ==================== ERROR STATE ====================
    if (viewModel.hasError) {
      return ErrorState(
        message: viewModel.errorMessage ?? 'Failed to load posts',
        onRetry: () => viewModel.fetchAllPosts(),
      );
    }

    // ==================== EMPTY STATE ====================
    if (viewModel.isEmpty) {
      return const DataNotFoundState();
    }

    // ==================== SUCCESS STATE - Show Posts ====================
    return _buildBlogGrid(context, viewModel, s);
  }*/

  Widget _buildContent(BuildContext context, BlogViewModel viewModel, DSizes s) {
    return DStateBuilder<List<BlogPost>>(
      state: viewModel.postsState,
      onLoading: () => const BlogPageLoading(),
      onError: (message) => ErrorState(message: message, onRetry: viewModel.fetchAllPosts),
      onEmpty: () => const DataNotFoundState(),
      onSuccess: (posts) => _buildBlogGrid(context, viewModel, s),
    );
  }

  /// Blog Post Grid
  Widget _buildBlogGrid(BuildContext context, BlogViewModel viewModel, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 2);

    // Get posts from ViewModel
    final displayedPosts = viewModel.displayPosts;
    final hasMore = viewModel.hasMore;
    final isLoadingMore = viewModel.isLoading && displayedPosts.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double desiredHeight = context.isMobile ? 424 : 530;
        final double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * s.spaceBtwItems) / crossAxisCount;
        final double finalAspectRatio = itemWidth / desiredHeight;

        return Column(
          children: [
            // Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: s.spaceBtwItems,
                mainAxisSpacing: s.spaceBtwItems,
                childAspectRatio: finalAspectRatio,
              ),
              itemCount: displayedPosts.length,
              itemBuilder: (context, index) {
                return BlogPostCard(post: displayedPosts[index])
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (100 * index).ms)
                    .slideY(begin: 0.1, duration: 400.ms, delay: (100 * index).ms);
              },
            ),

            // Load More Button
            if (hasMore) ...[
              SizedBox(height: s.spaceBtwSections),
              LoadMoreButton(
                onPressed: () => viewModel.loadMore(),
                currentCount: displayedPosts.length,
                totalCount: viewModel.allPosts.length,
                isLoading: isLoadingMore,
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, duration: 600.ms, delay: 200.ms),
            ],
          ],
        );
      },
    );
  }
}

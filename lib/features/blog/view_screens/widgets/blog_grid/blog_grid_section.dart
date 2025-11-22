import '../error_section/blog_empty_state.dart';
import '../error_section/blog_error_state.dart';
import '../error_section/blog_loading_skeleton.dart';
import 'widgets/blog_post_card.dart';
import 'widgets/load_more_button.dart';
import 'package:flutter/material.dart';
import '../sidebar/blog_sidebar.dart';
import '../../../view_models/blog_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

/*class BlogGridSection extends StatefulWidget {
  const BlogGridSection({super.key});

  @override
  State<BlogGridSection> createState() => _BlogGridSectionState();
}

class _BlogGridSectionState extends State<BlogGridSection> {
  final List<BlogPostModel> _displayedPosts = [];
  List<BlogPostModel> _allPosts = [];
  bool _isLoading = false;
  final int _postsPerPage = 4;

  @override
  void initState() {
    super.initState();
    _allPosts = BlogPostModel.getStaticPosts();
    _loadMorePosts();
  }

  void _loadMorePosts() {
    setState(() => _isLoading = true);

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          final currentLength = _displayedPosts.length;
          final remainingPosts = _allPosts.length - currentLength;
          final postsToAdd = remainingPosts > _postsPerPage ? _postsPerPage : remainingPosts;

          _displayedPosts.addAll(_allPosts.skip(currentLength).take(postsToAdd));
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: context.isMobile ? _buildMobileLayout(s) : _buildDesktopLayout(s),
    );
  }

  /// Desktop/Tablet Layout (Grid + Sidebar)
  Widget _buildDesktopLayout(DSizes s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blog Grid (Left - 70%)
        Expanded(flex: 70, child: _buildBlogGrid(s)),
        SizedBox(width: s.spaceBtwSections),

        // Sidebar (Right - 30%)
        Expanded(flex: 30, child: const BlogSidebar()),
      ],
    );
  }

  /// Mobile Layout (Grid then Sidebar)
  Widget _buildMobileLayout(DSizes s) {
    return Column(
      children: [
        // Blog Grid
        _buildBlogGrid(s),
        SizedBox(height: s.spaceBtwSections),

        // Sidebar (Below)
        const BlogSidebar(),
      ],
    );
  }

  /// Blog Post Grid
  Widget _buildBlogGrid(DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double desiredHeight = context.isMobile ? 424 : 530;
        final double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * s.spaceBtwItems) / crossAxisCount;
        final double finalAspectRatio = itemWidth / desiredHeight;

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: s.spaceBtwItems,
                mainAxisSpacing: s.spaceBtwItems,
                childAspectRatio: finalAspectRatio,
              ),
              itemCount: _displayedPosts.length,
              itemBuilder: (context, index) {
                return BlogPostCard(post: _displayedPosts[index])
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (100 * index).ms)
                    .slideY(begin: 0.1, duration: 400.ms, delay: (100 * index).ms);
              },
            ),

            // Load More Button
            if (_displayedPosts.length < _allPosts.length) ...[
              SizedBox(height: s.spaceBtwSections),
              LoadMoreButton(
                    onPressed: _loadMorePosts,
                    currentCount: _displayedPosts.length,
                    totalCount: _allPosts.length,
                    isLoading: _isLoading,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.1, duration: 600.ms, delay: 200.ms),
            ],
          ],
        );
      },
    );
  }
}*/

class BlogGridSection extends StatelessWidget {
  const BlogGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlogViewModel(context);
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: context.isMobile
          ? _buildMobileLayout(context, viewModel, s)
          : _buildDesktopLayout(context, viewModel, s),
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
  Widget _buildContent(BuildContext context, BlogViewModel viewModel, DSizes s) {
    // ==================== LOADING STATE (First time) ====================
    if (viewModel.isLoading && viewModel.allPosts.isEmpty) {
      return const BlogLoadingSkeleton();
    }

    // ==================== ERROR STATE ====================
    if (viewModel.hasError) {
      return BlogErrorState(
        message: viewModel.errorMessage ?? 'Failed to load posts',
        onRetry: () => viewModel.fetchAllPosts(),
      );
    }

    // ==================== EMPTY STATE ====================
    if (viewModel.isEmpty) {
      return const BlogEmptyState();
    }

    // ==================== SUCCESS STATE - Show Posts ====================
    return _buildBlogGrid(context, viewModel, s);
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
        final double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * s.spaceBtwItems) / crossAxisCount;
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
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.1, duration: 600.ms, delay: 200.ms),
            ],
          ],
        );
      },
    );
  }
}

import '../../../../../../data_layer/domain/entities/blog/blog_post.dart';
import 'widgets/comment_card.dart';
import 'package:flutter/material.dart';
import '../../../providers/comment_provider.dart';
import 'widgets/discussion_on_twitter_button.dart';
import '../../../view_models/comment_view_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';

class CommentsSection extends StatefulWidget {
  final BlogPost post;

  const CommentsSection({super.key, required this.post});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final _formKey = GlobalKey<FormState>();
  late final vm = CommentViewModel(context);
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchComments(widget.post.id);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = CommentViewModel(context);

    final success = await vm.addComment(
      authorName: _nameController.text.trim().isEmpty ? 'Anonymous' : _nameController.text.trim(),
      authorEmail: _emailController.text.trim(),
      content: _commentController.text.trim(),
    );

    if (success && mounted) {
      _commentController.clear();
      _showSuccessSnackBar('Comment posted successfully!');
    } else if (mounted) {
      _showErrorSnackBar('Failed to post comment. Please try again.');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: DColors.serviceGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with count and sort
              _buildHeader(context, s, vm),
              SizedBox(height: s.spaceBtwItems),

              // Twitter Discuss Button
              DiscussOnTwitterButton(post: widget.post),
              SizedBox(height: s.spaceBtwItems),

              // Divider
              Divider(color: DColors.cardBorder),
              SizedBox(height: s.spaceBtwItems),

              // Add Comment Form
              _buildAddCommentForm(context, s, vm),
              SizedBox(height: s.spaceBtwItems),

              _buildCommentsList(context, s, vm),

              // Comments List with State Handling
              /* DStateBuilder<List<Comment>>(
                state: vm.commentsState,
                onLoading: () => _buildLoadingState(s),
                onError: (msg) => _buildErrorState(context, s, msg),
                onEmpty: () => _buildEmptyState(context, s),
                onSuccess: (comments) => _buildCommentsList(context, s, vm),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  /// Header with count and sort
  Widget _buildHeader(BuildContext context, DSizes s, CommentViewModel vm) {
    final fonts = context.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title + Count
        Row(
          children: [
            Icon(Icons.comment_rounded, color: DColors.primaryButton, size: 24),
            SizedBox(width: s.paddingSm),
            Text(
              'Comments',
              style: fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            ),
            SizedBox(width: s.paddingSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
              decoration: BoxDecoration(
                color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
              ),
              child: Text(
                '${vm.totalCommentCount}',
                style: fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        // Sort Dropdown
        _buildSortDropdown(context, s, vm),
      ],
    );
  }

  /// Sort Dropdown
  Widget _buildSortDropdown(BuildContext context, DSizes s, CommentViewModel vm) {
    final fonts = context.fonts;
    final CommentSort currentSortBy = vm.sortBy;

    return PopupMenuButton<CommentSort>(
      initialValue: currentSortBy,
      color: DColors.cardBackground,
      onSelected: (value) => vm.changeSortOrder(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: DColors.cardBackground,
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          border: Border.all(color: DColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort_rounded, color: DColors.textSecondary, size: 18),
            SizedBox(width: s.paddingXs),
            Text(switch (currentSortBy) {
              CommentSort.newest => 'Newest',
              CommentSort.oldest => 'Oldest',
              CommentSort.mostLiked => 'Most Liked',
            }, style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
          ],
        ),
      ),
      itemBuilder: (context) {
        const sortOptions = {
          CommentSort.newest: 'Newest First',
          CommentSort.oldest: 'Oldest First',
          CommentSort.mostLiked: 'Most Liked',
        };
        return sortOptions.entries.map((entry) {
          final value = entry.key;
          final label = entry.value;

          return PopupMenuItem<CommentSort>(
            value: value,
            child: Text(
              label,
              style: fonts.bodySmall.rubik(
                color: currentSortBy == value ? DColors.primaryButton : DColors.textPrimary,
                fontWeight: currentSortBy == value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  /// Add Comment Form
  Widget _buildAddCommentForm(BuildContext context, DSizes s, CommentViewModel vm) {
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave a Comment',
              style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            ),
            SizedBox(height: s.paddingMd),

            // Name & Email Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
                    decoration: _inputDecoration(s, 'Your Name (optional)'),
                  ),
                ),
                SizedBox(width: s.paddingSm),
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
                    decoration: _inputDecoration(s, 'Email (optional)'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            SizedBox(height: s.paddingSm),

            // Comment TextField
            TextFormField(
              controller: _commentController,
              maxLines: 4,
              style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
              decoration: _inputDecoration(s, 'Share your thoughts...'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your comment';
                }
                return null;
              },
            ),
            SizedBox(height: s.paddingMd),

            // Submit Button
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(tittleText: 'Post Comment', onPressed: _submitComment),
            ),
          ],
        ),
      ),
    );
  }

  /// Input Decoration style
  InputDecoration _inputDecoration(DSizes s, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
      filled: true,
      fillColor: DColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        borderSide: BorderSide(color: DColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        borderSide: BorderSide(color: DColors.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        borderSide: BorderSide(color: DColors.primaryButton, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
    );
  }

  /// Comments List
  Widget _buildCommentsList(BuildContext context, DSizes s, CommentViewModel vm) {
    return Column(
      children: vm.comments.map((comment) {
        return CommentCard(
          comment: comment,
          onLike: () => vm.toggleLike(comment.id),
          onReplyLike: (replyId) => vm.toggleLike(replyId),
          isLiked: vm.isLiked(comment.id),
          isReplyLiked: (replyId) => vm.isLiked(replyId),
        );
      }).toList(),
    );
  }
}

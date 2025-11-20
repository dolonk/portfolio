import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/blog/comment_model.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import 'link_button.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final Function(String) onReplyLike;

  const CommentCard({super.key, required this.comment, required this.onLike, required this.onReplyLike});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      margin: EdgeInsets.only(bottom: s.paddingMd),
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comment Header
          _buildCommentHeader(context, s),
          SizedBox(height: s.paddingSm),

          // Comment Content
          _buildCommentContent(context, s),
          SizedBox(height: s.paddingMd),

          // Comment Actions
          _buildCommentActions(context, s),

          // Replies
          if (comment.replies.isNotEmpty) ...[SizedBox(height: s.paddingMd), _buildReplies(context, s)],
        ],
      ),
    );
  }

  Widget _buildCommentHeader(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 20,
          backgroundColor: DColors.primaryButton.withAlpha((255 * 0.2).round()),
          backgroundImage: AssetImage(comment.authorImage),
        ),
        SizedBox(width: s.paddingSm),

        // Author + Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.authorName,
                style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
              Text(
                _formatTimestamp(comment.timestamp),
                style: fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommentContent(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Text(comment.content, style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6));
  }

  Widget _buildCommentActions(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      children: [
        // Like Button
        LikeButton(likes: comment.likes, onTap: onLike),
        SizedBox(width: s.paddingMd),

        // Reply Button (placeholder)
        Icon(Icons.reply_rounded, color: DColors.textSecondary, size: 18),
        SizedBox(width: 4),
        Text('Reply', style: fonts.labelSmall.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  Widget _buildReplies(BuildContext context, DSizes s) {
    return Container(
      margin: EdgeInsets.only(left: s.paddingLg),
      padding: EdgeInsets.only(left: s.paddingMd),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: DColors.cardBorder, width: 2)),
      ),
      child: Column(
        children: comment.replies.map((reply) {
          return Container(
            margin: EdgeInsets.only(bottom: s.paddingSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reply Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                      backgroundImage: AssetImage(reply.authorImage),
                    ),
                    SizedBox(width: s.paddingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply.authorName,
                            style: context.fonts.bodySmall.rubik(
                              fontWeight: FontWeight.bold,
                              color: DColors.textPrimary,
                            ),
                          ),
                          Text(
                            _formatTimestamp(reply.timestamp),
                            style: context.fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: s.paddingSm),

                // Reply Content
                Text(
                  reply.content,
                  style: context.fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6),
                ),
                SizedBox(height: s.paddingSm),

                // Reply Actions
                LikeButton(likes: reply.likes, onTap: () => onReplyLike(reply.id)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

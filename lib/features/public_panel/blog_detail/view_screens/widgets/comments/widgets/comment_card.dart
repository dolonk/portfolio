import 'link_button.dart';
import 'package:flutter/material.dart';
import '../../../../../../../utility/constants/colors.dart';
import '../../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../../data_layer/domain/entities/blog/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLike;
  final Function(String) onReplyLike;
  final bool isLiked;
  final bool Function(String) isReplyLiked;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onReplyLike,
    this.isLiked = false,
    required this.isReplyLiked,
  });

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
          _buildCommentHeader(context, s),
          SizedBox(height: s.paddingSm),
          _buildCommentContent(context, s),
          SizedBox(height: s.paddingMd),
          _buildCommentActions(context, s),
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
              Row(
                children: [
                  Text(
                    comment.authorName,
                    style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                  ),
                  // Author badge
                  if (comment.isAuthorReply) ...[
                    SizedBox(width: s.paddingSm * 0.5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: s.paddingSm * 0.5, vertical: 2),
                      decoration: BoxDecoration(color: DColors.primaryButton, borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'Author',
                        style: fonts.labelSmall.rubik(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
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
        LikeButton(likes: comment.likes, onTap: onLike, isLiked: isLiked),
        SizedBox(width: s.paddingMd),

        // Reply Button
        Icon(Icons.reply_rounded, color: DColors.textSecondary, size: 18),
        const SizedBox(width: 4),
        Text('Reply', style: fonts.labelSmall.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  Widget _buildReplies(BuildContext context, DSizes s) {
    final fonts = context.fonts;

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
                          Row(
                            children: [
                              Text(
                                reply.authorName,
                                style: fonts.bodySmall.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                              ),
                              if (reply.isAuthorReply) ...[
                                SizedBox(width: s.paddingSm * 0.5),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm * 0.5, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: DColors.primaryButton,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Author',
                                    style: fonts.labelSmall.rubik(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            _formatTimestamp(reply.timestamp),
                            style: fonts.labelSmall.rubik(color: DColors.textSecondary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: s.paddingSm),

                // Reply Content
                Text(reply.content, style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.5)),
                SizedBox(height: s.paddingSm),

                // Reply Actions
                LikeButton(
                  likes: reply.likes,
                  onTap: () => onReplyLike(reply.id),
                  isLiked: isReplyLiked(reply.id),
                  small: true,
                ),
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

    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inDays > 0) {
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

import 'package:flutter/material.dart';
import '../../models/client_feedback.dart';
import '../colors.dart';

class ClientFeedbackSection extends StatelessWidget {
  final List<ClientFeedback> feedbackList;
  final Function(String)? onToggleExpansion;
  final VoidCallback? onLoadMore;
  final bool hasMoreFeedback;
  final EdgeInsetsGeometry? margin;

  const ClientFeedbackSection({
    super.key,
    required this.feedbackList,
    this.onToggleExpansion,
    this.onLoadMore,
    this.hasMoreFeedback = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Feedback',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: KoreColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...feedbackList.map((feedback) => _buildFeedbackItem(context, feedback)),
          const SizedBox(height: 12),
          if (hasMoreFeedback)
            Center(
              child: GestureDetector(
                onTap: onLoadMore,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: KoreColors.textLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'See more',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeedbackItem(BuildContext context, ClientFeedback feedback) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(feedback.clientImage),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              feedback.clientName,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _getTimeAgo(feedback.date),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: KoreColors.textLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < feedback.rating ? Icons.star : Icons.star_border,
                                  color: index < feedback.rating ? Colors.amber : KoreColors.textLight,
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${feedback.rating})',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: KoreColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (feedback.comment.isNotEmpty) ...[
                _buildCommentText(context, feedback),
              ],
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: KoreColors.border,
        ),
      ],
    );
  }

  Widget _buildCommentText(BuildContext context, ClientFeedback feedback) {
    const int maxLines = 2;
    const int maxChars = 120; // Approximate characters for 2 lines
    
    if (feedback.comment.length <= maxChars || feedback.isExpanded) {
      return Text(
        feedback.comment,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: KoreColors.textLight,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedback.comment.substring(0, maxChars) + '...',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: KoreColors.textLight,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => onToggleExpansion?.call(feedback.id),
            child: Text(
              'See More',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months Month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks Week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} Day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return 'Today';
    }
  }
}

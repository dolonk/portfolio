import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';

// class BlogErrorState extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//
//   const BlogErrorState({super.key, required this.message, required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = context.sizes;
//     final fonts = context.fonts;
//
//     return Container(
//       padding: EdgeInsets.all(s.paddingXl * 2),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline_rounded, size: 80, color: Colors.red.shade400),
//           SizedBox(height: s.spaceBtwItems),
//           Text(
//             'Oops! Something went wrong',
//             style: fonts.headlineMedium.rajdhani(color: DColors.textPrimary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: s.paddingSm),
//           Text(
//             message,
//             style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: s.spaceBtwItems),
//           ElevatedButton.icon(
//             onPressed: onRetry,
//             icon: const Icon(Icons.refresh_rounded),
//             label: const Text('Retry'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: DColors.primaryButton,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

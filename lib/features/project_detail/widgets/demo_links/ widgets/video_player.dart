import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YouTubeVideoPlayer({super.key, required this.videoUrl});

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  final String _iframeId = 'youtube-player-${DateTime.now().millisecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();
    _registerIframe();
  }

  void _registerIframe() {
    final videoId = _extractVideoId(widget.videoUrl);
    if (videoId == null) return;

    ui_web.platformViewRegistry.registerViewFactory(_iframeId, (int viewId) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement
        ..src = 'https://www.youtube.com/embed/$videoId'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';

      //iframe.setAttribute('allow fullscreen', 'true');
      return iframe;
    });
  }

  String? _extractVideoId(String url) {
    // Extract video ID from various YouTube URL formats
    final regExp = RegExp(r'(?:youtube\.com/(?:[^/]+/.+/|(?:v|e(?:mbed)?)/|.*[?&]v=)|youtu\.be/)([^"&?/\s]{11})');
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
    final videoId = _extractVideoId(widget.videoUrl);

    if (videoId == null) {
      // Fallback if invalid URL
      return Container(
        height: 400,
        decoration: BoxDecoration(color: DColors.cardBackground, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text('Invalid YouTube URL', style: TextStyle(color: DColors.textSecondary)),
        ),
      );
    }

    return SizedBox(
      width: 800,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((255 * 0.15).round()),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: HtmlElementView(viewType: _iframeId),
          ),
        ),
      ),
    );
  }
}

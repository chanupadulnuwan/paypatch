import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/group_post.dart';
import '../../providers/posts_provider.dart';
import '../../widgets/net_image.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<GroupPost> posts;
  final int initialIndex;

  const StoryViewerScreen({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with TickerProviderStateMixin {
  late PageController _pageCtrl;
  late int _currentIndex;

  // Per-page progress animation
  late AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageCtrl = PageController(initialPage: _currentIndex);
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextPage();
        }
      });
    _progressCtrl.forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < widget.posts.length - 1) {
      _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageCtrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    _progressCtrl.reset();
    _progressCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.localPosition.dx < width / 3) {
            _prevPage();
          } else if (details.localPosition.dx > (2 * width / 3)) {
            _nextPage();
          }
        },
        child: Stack(
          children: [
            // Pages
            PageView.builder(
              controller: _pageCtrl,
              onPageChanged: _onPageChanged,
              itemCount: widget.posts.length,
              itemBuilder: (_, index) {
                final post = widget.posts[index];
                return _StoryPage(
                  post: post,
                  onLike: () async {
                    await Provider.of<PostsProvider>(context, listen: false)
                        .toggleLike(post.id);
                    setState(() {});
                  },
                  onComment: () => _showCommentSheet(post),
                  onDelete: post.isOwn
                      ? () async {
                          final ok = await Provider.of<PostsProvider>(context, listen: false)
                              .deletePost(post.id);
                          if (ok && context.mounted) Navigator.pop(context);
                        }
                      : null,
                );
              },
            ),

            // Progress bar at top
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Row(
                  children: widget.posts.asMap().entries.map((entry) {
                    final i = entry.key;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: i < _currentIndex
                              ? Container(height: 3, color: Colors.white)
                              : i == _currentIndex
                                  ? AnimatedBuilder(
                                      animation: _progressCtrl,
                                      builder: (context, child) => LinearProgressIndicator(
                                        value: _progressCtrl.value,
                                        backgroundColor: Colors.white.withValues(alpha: 0.35),
                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                        minHeight: 3,
                                      ),
                                    )
                                  : Container(height: 3, color: Colors.white.withValues(alpha: 0.35)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Close button
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 12),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentSheet(GroupPost post) {
    _progressCtrl.stop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CommentSheet(post: post),
    ).whenComplete(() {
      if (mounted) _progressCtrl.forward();
    });
  }
}

class _StoryPage extends StatefulWidget {
  final GroupPost post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback? onDelete;

  const _StoryPage({required this.post, required this.onLike, required this.onComment, this.onDelete});

  @override
  State<_StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<_StoryPage> with SingleTickerProviderStateMixin {
  late AnimationController _heartCtrl;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _heartScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(_heartCtrl);
  }

  @override
  void dispose() {
    _heartCtrl.dispose();
    super.dispose();
  }

  void _tapLike() {
    _heartCtrl.forward(from: 0);
    widget.onLike();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    // Rebuild with latest from provider
    final provPost = Provider.of<PostsProvider>(context)
        .posts
        .firstWhere((p) => p.id == post.id, orElse: () => post);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        if (provPost.imageUrl != null)
          CachedNetworkImage(
            imageUrl: provPost.imageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.black),
            errorWidget: (context, url, error) => Container(color: const Color(0xFF1A1A2E)),
          )
        else
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0D5B3F), Color(0xFF2B7D63)],
              ),
            ),
          ),

        // Dark gradient overlay for readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withValues(alpha: 0.75),
              ],
              stops: const [0.0, 0.25, 0.55, 1.0],
            ),
          ),
        ),

        // User info header (below progress bar)
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Row(
              children: [
                NetImage(url: provPost.userPhotoUrl, radius: 18, fallbackText: provPost.userName),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provPost.userName,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text(
                        provPost.groupName,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                      ),
                    ],
                  ),
                ),
                if (provPost.isOwn && widget.onDelete != null)
                  GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Caption + action bar at bottom
        Positioned(
          left: 0, right: 0, bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (provPost.caption != null && provPost.caption!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        provPost.caption!,
                        style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Row(
                    children: [
                      // Like button
                      GestureDetector(
                        onTap: _tapLike,
                        child: Row(
                          children: [
                            ScaleTransition(
                              scale: _heartScale,
                              child: Icon(
                                provPost.likedByMe ? Icons.favorite : Icons.favorite_border,
                                color: provPost.likedByMe ? const Color(0xFFE8AC73) : Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${provPost.likesCount}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Comment button
                      GestureDetector(
                        onTap: widget.onComment,
                        child: Row(
                          children: [
                            const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 26),
                            const SizedBox(width: 6),
                            Text(
                              '${provPost.commentsCount}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Audience badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              provPost.audience == 'group' ? Icons.groups_outlined : Icons.people_outline,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              provPost.audience == 'group' ? 'Group' : 'Friends',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Comment Sheet ─────────────────────────────────────────────────────────────

class _CommentSheet extends StatefulWidget {
  final GroupPost post;
  const _CommentSheet({required this.post});

  @override
  State<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<_CommentSheet> {
  final _commentCtrl = TextEditingController();
  final _scrollCtrl  = ScrollController();
  List<Map<String, dynamic>> _comments = [];
  bool _loading = true;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    final comments = await Provider.of<PostsProvider>(context, listen: false)
        .fetchComments(widget.post.id);
    if (mounted) setState(() { _comments = comments; _loading = false; });
  }

  Future<void> _send() async {
    final text = _commentCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    final result = await Provider.of<PostsProvider>(context, listen: false)
        .addComment(widget.post.id, text);
    if (!mounted) return;
    if (result != null) {
      _commentCtrl.clear();
      setState(() { _comments.add(result); _sending = false; });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollCtrl.hasClients) {
          _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    } else {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, sc) => Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('Comments', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: cs.onSurface)),
            const Divider(height: 20),

            // Comments list
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _comments.isEmpty
                      ? Center(
                          child: Text('No comments yet. Be the first!',
                              style: TextStyle(color: cs.onSurface.withValues(alpha: 0.5))),
                        )
                      : ListView.builder(
                          controller: _scrollCtrl,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _comments.length,
                          itemBuilder: (_, i) {
                            final c = _comments[i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NetImage(
                                    url: c['user_photo']?.toString(),
                                    radius: 16,
                                    fallbackText: c['user_name']?.toString() ?? '?',
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: cs.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(c['user_name']?.toString() ?? 'User',
                                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                          const SizedBox(height: 2),
                                          Text(c['comment']?.toString() ?? '', style: const TextStyle(fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),

            // Comment input
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentCtrl,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _sending
                      ? const SizedBox(width: 36, height: 36, child: CircularProgressIndicator(strokeWidth: 2))
                      : IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF4F7D6A),
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.send_rounded),
                          onPressed: _send,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

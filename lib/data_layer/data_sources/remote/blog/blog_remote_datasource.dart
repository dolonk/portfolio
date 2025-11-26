import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/blog/blog_post_model.dart';

abstract class BlogRemoteDataSource {
  Future<List<BlogPostModel>> getAllPosts();
  Future<List<BlogPostModel>> getFeaturedPosts();
  Future<BlogPostModel> getPostById(String id);
  Future<List<BlogPostModel>> getPostsByTag(String tag);
  Future<List<String>> getAllTags();
  Future<void> createPost(BlogPostModel post);
  Future<void> updatePost(BlogPostModel post);
  Future<void> deletePost(String id);
  Future<void> incrementViewCount(String id);
  Future<List<BlogPostModel>> searchPosts(String query);
  Future<List<BlogPostModel>> getRecentPosts({int limit = 5});
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient? supabase;
  BlogRemoteDataSourceImpl({this.supabase});

  // ==================== GET ALL POSTS ====================
  @override
  Future<List<BlogPostModel>> getAllPosts() async {
    try {
      final response = await supabase!
          .from('blog_posts')
          .select()
          .eq('is_published', true)
          .order('created_at', ascending: false);

      return (response as List).map((json) => BlogPostModel.fromSupabase(json)).toList();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching all blog posts');
    }
  }

  // ==================== GET FEATURED POSTS ====================
  @override
  Future<List<BlogPostModel>> getFeaturedPosts() async {
    try {
      final response = await supabase!
          .from('blog_posts')
          .select()
          .eq('is_published', true)
          .eq('is_featured', true)
          .order('created_at', ascending: false);

      return (response as List).map((json) => BlogPostModel.fromSupabase(json)).toList();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching featured blog posts');
    }
  }

  // ==================== GET POST BY ID ====================
  @override
  Future<BlogPostModel> getPostById(String id) async {
    try {
      final response = await supabase!.from('blog_posts').select().eq('id', id).maybeSingle();

      if (response == null) {
        throw NotFoundException('Blog post with ID "$id" not found');
      }

      return BlogPostModel.fromSupabase(response);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching blog post by ID');
    }
  }

  // ==================== GET POSTS BY TAG ====================
  @override
  Future<List<BlogPostModel>> getPostsByTag(String tag) async {
    try {
      final response = await supabase!
          .from('blog_posts')
          .select()
          .eq('is_published', true)
          .contains('tags', [tag])
          .order('created_at', ascending: false);

      return (response as List).map((json) => BlogPostModel.fromSupabase(json)).toList();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching posts by tag "$tag"');
    }
  }

  // ==================== GET ALL TAGS ====================
  @override
  Future<List<String>> getAllTags() async {
    try {
      final response = await supabase!.from('blog_posts').select('tags').eq('is_published', true);

      final Set<String> tags = {};

      for (var post in response as List) {
        final postTags = List<String>.from(post['tags'] ?? []);
        tags.addAll(postTags);
      }

      return tags.toList()..sort();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching blog tags');
    }
  }

  // ==================== CREATE POST ====================
  @override
  Future<void> createPost(BlogPostModel post) async {
    try {
      await supabase!.from('blog_posts').insert(post.toSupabase());
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Creating blog post');
    }
  }

  // ==================== UPDATE POST ====================
  @override
  Future<void> updatePost(BlogPostModel post) async {
    try {
      final response = await supabase!
          .from('blog_posts')
          .update(post.toSupabase())
          .eq('id', post.id)
          .select();

      if (response.isEmpty) {
        throw NotFoundException('Blog post with ID "${post.id}" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Updating blog post');
    }
  }

  // ==================== DELETE POST ====================
  @override
  Future<void> deletePost(String id) async {
    try {
      final response = await supabase!.from('blog_posts').delete().eq('id', id).select();

      if (response.isEmpty) {
        throw NotFoundException('Blog post with ID "$id" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Deleting blog post');
    }
  }

  // ==================== INCREMENT VIEW COUNT ====================
  @override
  Future<void> incrementViewCount(String id) async {
    try {
      final response = await supabase!.from('blog_posts').select('view_count').eq('id', id).maybeSingle();

      if (response == null) {
        throw NotFoundException('Blog post with ID "$id" not found');
      }

      final currentCount = response['view_count'] as int? ?? 0;

      await supabase!.from('blog_posts').update({'view_count': currentCount + 1}).eq('id', id);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Incrementing view count');
    }
  }

  // ==================== SEARCH POSTS ====================
  @override
  Future<List<BlogPostModel>> searchPosts(String query) async {
    try {
      if (query.trim().isEmpty) {
        throw ValidationException('Search query cannot be empty');
      }

      final response = await supabase!.from('blog_posts').select().eq('is_published', true);

      final searchQuery = query.toLowerCase().trim();

      final filtered = (response as List).where((post) {
        final title = (post['title'] ?? '').toString().toLowerCase();
        final excerpt = (post['excerpt'] ?? '').toString().toLowerCase();
        final tags = List<String>.from(post['tags'] ?? []);

        return title.contains(searchQuery) ||
            excerpt.contains(searchQuery) ||
            tags.any((tag) => tag.toLowerCase().contains(searchQuery));
      }).toList();

      return filtered.map((json) => BlogPostModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Searching blog posts');
    }
  }

  // ==================== GET RECENT POSTS ====================
  @override
  Future<List<BlogPostModel>> getRecentPosts({int limit = 5}) async {
    try {
      if (limit <= 0) {
        throw ValidationException('Limit must be greater than 0');
      }

      final response = await supabase!
          .from('blog_posts')
          .select()
          .eq('is_published', true)
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List).map((json) => BlogPostModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching recent blog posts');
    }
  }
}

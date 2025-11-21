import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../entities/blog/blog_post.dart';

abstract class BlogRepository {
  /// Get all published blog posts
  Future<Either<Failure, List<BlogPost>>> getAllPosts();

  /// Get all featured posts
  Future<Either<Failure, List<BlogPost>>> getFeaturedPosts();

  /// Get single post by ID
  Future<Either<Failure, BlogPost>> getPostById(String id);

  /// Get posts by tag
  Future<Either<Failure, List<BlogPost>>> getPostsByTag(String tag);

  /// Get all unique tags
  Future<Either<Failure, List<String>>> getAllTags();

  /// Create new post (Admin only)
  Future<Either<Failure, void>> createPost(BlogPost post);

  /// Update existing post (Admin only)
  Future<Either<Failure, void>> updatePost(BlogPost post);

  /// Delete post (Admin only)
  Future<Either<Failure, void>> deletePost(String id);

  /// Increment view count
  Future<Either<Failure, void>> incrementViewCount(String id);

  /// Search posts by title or content
  Future<Either<Failure, List<BlogPost>>> searchPosts(String query);
}

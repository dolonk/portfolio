import 'blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/blog/blog_post.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/blog/blog_post_model.dart';
import '../../../data_sources/remote/blog/blog_remote_datasource.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final bool useSupabase;

  BlogRepositoryImpl({required this.remoteDataSource, this.useSupabase = false});

  // ==================== GET ALL POSTS ====================
  @override
  Future<Either<Failure, List<BlogPost>>> getAllPosts() async {
    try {
      if (useSupabase) {
        final posts = await remoteDataSource.getAllPosts();
        return Right(posts);
      } else {
        final posts = BlogPostModel.getStaticPosts();
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(posts);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting all blog posts'));
    }
  }

  // ==================== GET FEATURED POSTS ====================
  @override
  Future<Either<Failure, List<BlogPost>>> getFeaturedPosts() async {
    try {
      if (useSupabase) {
        final posts = await remoteDataSource.getFeaturedPosts();
        return Right(posts);
      } else {
        final posts = BlogPostModel.getFeaturedPosts();
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(posts);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting featured posts'));
    }
  }

  // ==================== GET POST BY ID ====================
  @override
  Future<Either<Failure, BlogPost>> getPostById(String id) async {
    try {
      if (useSupabase) {
        final post = await remoteDataSource.getPostById(id);
        return Right(post);
      } else {
        final posts = BlogPostModel.getStaticPosts();
        final post = posts.firstWhere(
          (p) => p.id == id,
          orElse: () => throw NotFoundException('Post with ID "$id" not found'),
        );
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(post);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting post by ID'));
    }
  }

  // ==================== GET POSTS BY TAG ====================
  @override
  Future<Either<Failure, List<BlogPost>>> getPostsByTag(String tag) async {
    try {
      if (useSupabase) {
        final posts = await remoteDataSource.getPostsByTag(tag);
        return Right(posts);
      } else {
        final posts = BlogPostModel.getPostsByTag(tag);
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(posts);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting posts by tag'));
    }
  }

  // ==================== GET ALL TAGS ====================
  @override
  Future<Either<Failure, List<String>>> getAllTags() async {
    try {
      if (useSupabase) {
        final tags = await remoteDataSource.getAllTags();
        return Right(tags);
      } else {
        final posts = BlogPostModel.getStaticPosts();
        final allTags = <String>{};
        for (var post in posts) {
          allTags.addAll(post.tags);
        }
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(allTags.toList()..sort());
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting all tags'));
    }
  }

  // ==================== CREATE POST ====================
  @override
  Future<Either<Failure, void>> createPost(BlogPost post) async {
    try {
      if (!useSupabase) {
        throw ServerException(
          'Supabase not configured. Cannot create post.',
          code: 'SUPABASE_NOT_CONFIGURED',
        );
      }

      await remoteDataSource.createPost(post as BlogPostModel);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Creating blog post'));
    }
  }

  // ==================== UPDATE POST ====================
  @override
  Future<Either<Failure, void>> updatePost(BlogPost post) async {
    try {
      if (!useSupabase) {
        throw ServerException(
          'Supabase not configured. Cannot update post.',
          code: 'SUPABASE_NOT_CONFIGURED',
        );
      }

      await remoteDataSource.updatePost(post as BlogPostModel);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Updating blog post'));
    }
  }

  // ==================== DELETE POST ====================
  @override
  Future<Either<Failure, void>> deletePost(String id) async {
    try {
      if (!useSupabase) {
        throw ServerException(
          'Supabase not configured. Cannot delete post.',
          code: 'SUPABASE_NOT_CONFIGURED',
        );
      }

      await remoteDataSource.deletePost(id);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Deleting blog post'));
    }
  }

  // ==================== INCREMENT VIEW COUNT ====================
  @override
  Future<Either<Failure, void>> incrementViewCount(String id) async {
    try {
      if (useSupabase) {
        await remoteDataSource.incrementViewCount(id);
      }
      return const Right(null);
    } catch (e) {
      // Silently fail for view count (non-critical)
      return const Right(null);
    }
  }

  // ==================== SEARCH POSTS ====================
  @override
  Future<Either<Failure, List<BlogPost>>> searchPosts(String query) async {
    try {
      if (useSupabase) {
        final posts = await remoteDataSource.searchPosts(query);
        return Right(posts);
      } else {
        final allPosts = BlogPostModel.getStaticPosts();
        final searchQuery = query.toLowerCase();

        final filteredPosts = allPosts.where((post) {
          return post.title.toLowerCase().contains(searchQuery) ||
              post.excerpt.toLowerCase().contains(searchQuery) ||
              post.content.toLowerCase().contains(searchQuery) ||
              post.tags.any((tag) => tag.toLowerCase().contains(searchQuery));
        }).toList();

        await Future.delayed(const Duration(milliseconds: 300));
        return Right(filteredPosts);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Searching posts'));
    }
  }

  // ==================== GET RECENT POSTS ====================
  @override
  Future<Either<Failure, List<BlogPost>>> getRecentPosts({int limit = 5}) async {
    try {
      if (useSupabase) {
        final posts = await remoteDataSource.getRecentPosts(limit: limit);
        return Right(posts);
      } else {
        final allPosts = BlogPostModel.getStaticPosts();
        allPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        final recentPosts = allPosts.take(limit).toList();
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(recentPosts);
      }
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Getting recent posts'));
    }
  }
}

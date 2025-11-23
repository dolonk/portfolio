import 'blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/blog/blog_post.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/blog/blog_post_model.dart';
import '../../../data_sources/remote/blog/blog_remote_datasource.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final bool useFirebase;

  BlogRepositoryImpl({required this.remoteDataSource, this.useFirebase = false});

  @override
  Future<Either<Failure, List<BlogPost>>> getAllPosts() async {
    try {
      if (useFirebase) {
        // Firebase থেকে data fetch
        final posts = await remoteDataSource.getAllPosts();
        print('get firebase data dolon');
        return Right(posts);
      } else {
        // Static data use
        final posts = BlogPostModel.getStaticPosts();
        print('get static data dolon');
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(posts);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load posts: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<BlogPost>>> getFeaturedPosts() async {
    try {
      if (useFirebase) {
        final posts = await remoteDataSource.getFeaturedPosts();
        return Right(posts);
      } else {
        final posts = BlogPostModel.getFeaturedPosts();
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(posts);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load featured posts'));
    }
  }

  @override
  Future<Either<Failure, BlogPost>> getPostById(String id) async {
    try {
      if (useFirebase) {
        final post = await remoteDataSource.getPostById(id);
        return Right(post);
      } else {
        final posts = BlogPostModel.getStaticPosts();
        final post = posts.firstWhere((p) => p.id == id, orElse: () => throw ServerException('Post not found'));
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(post);
      }
    } on ServerException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load post'));
    }
  }

  @override
  Future<Either<Failure, List<BlogPost>>> getPostsByTag(String tag) async {
    try {
      if (useFirebase) {
        final posts = await remoteDataSource.getPostsByTag(tag);
        return Right(posts);
      } else {
        final posts = BlogPostModel.getPostsByTag(tag);
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(posts);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load posts by tag'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllTags() async {
    try {
      if (useFirebase) {
        final tags = await remoteDataSource.getAllTags();
        return Right(tags);
      } else {
        // Static data থেকে unique tags extract
        final posts = BlogPostModel.getStaticPosts();
        final allTags = <String>{};
        for (var post in posts) {
          allTags.addAll(post.tags);
        }
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(allTags.toList()..sort());
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load tags'));
    }
  }

  /// Admin section
  @override
  Future<Either<Failure, void>> createPost(BlogPost post) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot create post.'));
      }
      await remoteDataSource.createPost(post as BlogPostModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create post'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(BlogPost post) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot update post.'));
      }
      await remoteDataSource.updatePost(post as BlogPostModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update post'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String id) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot delete post.'));
      }
      await remoteDataSource.deletePost(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete post'));
    }
  }

  @override
  Future<Either<Failure, void>> incrementViewCount(String id) async {
    try {
      if (useFirebase) {
        await remoteDataSource.incrementViewCount(id);
      }
      return const Right(null);
    } catch (e) {
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, List<BlogPost>>> searchPosts(String query) async {
    try {
      if (useFirebase) {
        final posts = await remoteDataSource.searchPosts(query);
        return Right(posts);
      } else {
        // Static data তে search
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
      return Left(ServerFailure(message: 'Failed to search posts'));
    }
  }

  @override
  Future<Either<Failure, List<BlogPost>>> getRecentPosts({int limit = 5}) async {
    try {
      if (useFirebase) {
        final posts = await remoteDataSource.getRecentPosts(limit: limit);
        return Right(posts);
      } else {
        // Static data - sort by date and take limit
        final allPosts = BlogPostModel.getStaticPosts();

        // Sort by createdAt descending (newest first)
        allPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        final recentPosts = allPosts.take(limit).toList();

        await Future.delayed(const Duration(milliseconds: 200));
        return Right(recentPosts);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load recent posts'));
    }
  }
}

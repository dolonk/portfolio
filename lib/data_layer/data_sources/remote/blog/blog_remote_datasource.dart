import '../../../../core/error/exceptions.dart';
import '../../../model/blog/blog_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Blog Remote DataSource Interface
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
}

/// Blog Remote DataSource Implementation
class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore firestore;

  BlogRemoteDataSourceImpl({required this.firestore});

  // Collection reference
  CollectionReference get _postsCollection => firestore.collection('blog_posts');

  @override
  Future<List<BlogPostModel>> getAllPosts() async {
    try {
      final querySnapshot = await _postsCollection
          .where('isPublished', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch posts: ${e.toString()}');
    }
  }

  @override
  Future<List<BlogPostModel>> getFeaturedPosts() async {
    try {
      final querySnapshot = await _postsCollection
          .where('isPublished', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch featured posts: ${e.toString()}');
    }
  }

  @override
  Future<BlogPostModel> getPostById(String id) async {
    try {
      final doc = await _postsCollection.doc(id).get();

      if (!doc.exists) {
        throw ServerException('Post not found');
      }

      return BlogPostModel.fromFirestore(doc);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch post: ${e.toString()}');
    }
  }

  @override
  Future<List<BlogPostModel>> getPostsByTag(String tag) async {
    try {
      final querySnapshot = await _postsCollection
          .where('isPublished', isEqualTo: true)
          .where('tags', arrayContains: tag)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch posts by tag: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getAllTags() async {
    try {
      final querySnapshot = await _postsCollection.where('isPublished', isEqualTo: true).get();

      final allTags = <String>{};
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final tags = List<String>.from(data['tags'] ?? []);
        allTags.addAll(tags);
      }

      return allTags.toList()..sort();
    } catch (e) {
      throw ServerException('Failed to fetch tags: ${e.toString()}');
    }
  }

  @override
  Future<void> createPost(BlogPostModel post) async {
    try {
      await _postsCollection.doc(post.id).set(post.toFirestore());
    } catch (e) {
      throw ServerException('Failed to create post: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePost(BlogPostModel post) async {
    try {
      await _postsCollection.doc(post.id).update(post.toFirestore());
    } catch (e) {
      throw ServerException('Failed to update post: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await _postsCollection.doc(id).delete();
    } catch (e) {
      throw ServerException('Failed to delete post: ${e.toString()}');
    }
  }

  @override
  Future<void> incrementViewCount(String id) async {
    try {
      await _postsCollection.doc(id).update({'viewCount': FieldValue.increment(1)});
    } catch (e) {
      return;
    }
  }

  // This is a basic implementation - for production use Algolia/ElasticSearch
  @override
  Future<List<BlogPostModel>> searchPosts(String query) async {
    try {
      final querySnapshot = await _postsCollection
          .where('isPublished', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      final searchQuery = query.toLowerCase();
      final filteredDocs = querySnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final title = (data['title'] ?? '').toLowerCase();
        final excerpt = (data['excerpt'] ?? '').toLowerCase();
        final tags = List<String>.from(data['tags'] ?? []);

        return title.contains(searchQuery) ||
            excerpt.contains(searchQuery) ||
            tags.any((tag) => tag.toLowerCase().contains(searchQuery));
      });

      return filteredDocs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to search posts: ${e.toString()}');
    }
  }
}

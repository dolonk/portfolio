import '../../../../core/error/exceptions.dart';
import '../../../model/portfolio/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getAllProjects();
  Future<List<ProjectModel>> getFeaturedProjects();
  Future<List<ProjectModel>> getRecentProjects({int limit = 6});
  Future<ProjectModel> getProjectById(String id);
  Future<List<ProjectModel>> getProjectsByCategory(String category);
  Future<List<ProjectModel>> getProjectsByPlatform(String platform);
  Future<List<String>> getAllCategories();
  Future<List<String>> getAllPlatforms();
  Future<List<String>> getAllTechStacks();
  Future<List<ProjectModel>> searchProjects(String query);
  Future<void> incrementViewCount(String id);
  Future<void> createProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final FirebaseFirestore? firestore;

  ProjectRemoteDataSourceImpl({this.firestore});

  CollectionReference? get _projectsCollection => firestore?.collection('projects');

  void _checkFirebaseAvailable() {
    if (firestore == null || _projectsCollection == null) {
      throw ServerException('Firebase not initialized. Please use static data instead.');
    }
  }

  @override
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!
          .where('isPublished', isEqualTo: true)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getFeaturedProjects() async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!
          .where('isPublished', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch featured projects: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getRecentProjects({int limit = 6}) async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!
          .where('isPublished', isEqualTo: true)
          .orderBy('updatedAt', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch recent projects: ${e.toString()}');
    }
  }

  @override
  Future<ProjectModel> getProjectById(String id) async {
    try {
      _checkFirebaseAvailable();

      final doc = await _projectsCollection!.doc(id).get();

      if (!doc.exists) {
        throw ServerException('Project not found');
      }

      return ProjectModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException('Failed to fetch project: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getProjectsByCategory(String category) async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!
          .where('isPublished', isEqualTo: true)
          .where('category', isEqualTo: category)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch projects by category: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> getProjectsByPlatform(String platform) async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!
          .where('isPublished', isEqualTo: true)
          .where('platforms', arrayContains: platform)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch projects by platform: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getAllCategories() async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!.where('isPublished', isEqualTo: true).get();

      final Set<String> categories = {};
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final category = data['category'] as String?;
        if (category != null && category.isNotEmpty) {
          categories.add(category);
        }
      }

      return categories.toList()..sort();
    } catch (e) {
      throw ServerException('Failed to fetch categories: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getAllPlatforms() async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!.where('isPublished', isEqualTo: true).get();

      final Set<String> platforms = {};
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final projectPlatforms = List<String>.from(data['platforms'] ?? []);
        platforms.addAll(projectPlatforms);
      }

      return platforms.toList()..sort();
    } catch (e) {
      throw ServerException('Failed to fetch platforms: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getAllTechStacks() async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!.where('isPublished', isEqualTo: true).get();

      final Set<String> techStacks = {};
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final projectTechStacks = List<String>.from(data['techStack'] ?? []);
        techStacks.addAll(projectTechStacks);
      }

      return techStacks.toList()..sort();
    } catch (e) {
      throw ServerException('Failed to fetch tech stacks: ${e.toString()}');
    }
  }

  @override
  Future<List<ProjectModel>> searchProjects(String query) async {
    try {
      _checkFirebaseAvailable();

      final querySnapshot = await _projectsCollection!.where('isPublished', isEqualTo: true).get();

      final searchQuery = query.toLowerCase();

      final filteredDocs = querySnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final title = (data['title'] ?? '').toLowerCase();
        final description = (data['description'] ?? '').toLowerCase();
        final tagline = (data['tagline'] ?? '').toLowerCase();
        final category = (data['category'] ?? '').toLowerCase();
        final platforms = List<String>.from(data['platforms'] ?? []);
        final techStack = List<String>.from(data['techStack'] ?? []);

        return title.contains(searchQuery) ||
            description.contains(searchQuery) ||
            tagline.contains(searchQuery) ||
            category.contains(searchQuery) ||
            platforms.any((p) => p.toLowerCase().contains(searchQuery)) ||
            techStack.any((t) => t.toLowerCase().contains(searchQuery));
      });

      return filteredDocs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw ServerException('Failed to search projects: ${e.toString()}');
    }
  }

  @override
  Future<void> incrementViewCount(String id) async {
    try {
      _checkFirebaseAvailable();

      await _projectsCollection!.doc(id).update({'viewCount': FieldValue.increment(1)});
    } catch (e) {
      throw ServerException('Failed to increment view count: ${e.toString()}');
    }
  }

  @override
  Future<void> createProject(ProjectModel project) async {
    try {
      _checkFirebaseAvailable();

      await _projectsCollection!.doc(project.id).set(project.toFirestore());
    } catch (e) {
      throw ServerException('Failed to create project: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    try {
      _checkFirebaseAvailable();

      await _projectsCollection!.doc(project.id).update(project.toFirestore());
    } catch (e) {
      throw ServerException('Failed to update project: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      _checkFirebaseAvailable();

      await _projectsCollection!.doc(id).delete();
    } catch (e) {
      throw ServerException('Failed to delete project: ${e.toString()}');
    }
  }
}

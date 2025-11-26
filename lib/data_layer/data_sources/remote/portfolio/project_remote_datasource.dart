import '../../../../core/error/exceptions.dart';
import '../../../model/portfolio/project_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final SupabaseClient? supabase;
  ProjectRemoteDataSourceImpl({this.supabase});

  // ==================== GET ALL PROJECTS ====================
  @override
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      final response = await supabase!
          .from('projects')
          .select()
          .eq('is_published', true)
          .order('updated_at', ascending: false);

      return (response as List).map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching all projects');
    }
  }

  // ==================== GET FEATURED PROJECTS ====================
  @override
  Future<List<ProjectModel>> getFeaturedProjects() async {
    try {
      final response = await supabase!
          .from('projects')
          .select()
          .eq('is_published', true)
          .eq('is_featured', true)
          .order('updated_at', ascending: false);

      return (response as List).map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching featured projects');
    }
  }

  // ==================== GET RECENT PROJECTS ====================
  @override
  Future<List<ProjectModel>> getRecentProjects({int limit = 6}) async {
    try {
      if (limit <= 0) {
        throw ValidationException('Limit must be greater than 0');
      }

      final response = await supabase!
          .from('projects')
          .select()
          .eq('is_published', true)
          .order('updated_at', ascending: false)
          .limit(limit);

      return (response as List).map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching recent projects');
    }
  }

  // ==================== GET PROJECT BY ID ====================
  @override
  Future<ProjectModel> getProjectById(String id) async {
    try {
      final response = await supabase!.from('projects').select().eq('id', id).maybeSingle();

      if (response == null) {
        throw NotFoundException('Project with ID "$id" not found');
      }

      return ProjectModel.fromSupabase(response);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching project by ID');
    }
  }

  // ==================== GET PROJECTS BY CATEGORY ====================
  @override
  Future<List<ProjectModel>> getProjectsByCategory(String category) async {
    try {
      if (category.trim().isEmpty) {
        throw ValidationException('Category cannot be empty');
      }

      final response = await supabase!
          .from('projects')
          .select()
          .eq('is_published', true)
          .eq('category', category.trim())
          .order('updated_at', ascending: false);

      return (response as List).map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching projects by category "$category"');
    }
  }

  // ==================== GET PROJECTS BY PLATFORM ====================
  @override
  Future<List<ProjectModel>> getProjectsByPlatform(String platform) async {
    try {
      if (platform.trim().isEmpty) {
        throw ValidationException('Platform cannot be empty');
      }

      // PostgresSQL array contains operator
      final response = await supabase!
          .from('projects')
          .select()
          .eq('is_published', true)
          .contains('platforms', [platform.trim()])
          .order('updated_at', ascending: false);

      return (response as List).map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Fetching projects by platform "$platform"');
    }
  }

  // ==================== GET ALL CATEGORIES ====================
  @override
  Future<List<String>> getAllCategories() async {
    try {
      final response = await supabase!.from('projects').select('category').eq('is_published', true);

      final Set<String> categories = {};

      for (var project in response as List) {
        final category = project['category'] as String?;
        if (category != null && category.isNotEmpty) {
          categories.add(category);
        }
      }

      return categories.toList()..sort();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching project categories');
    }
  }

  // ==================== GET ALL PLATFORMS ====================
  @override
  Future<List<String>> getAllPlatforms() async {
    try {
      final response = await supabase!.from('projects').select('platforms').eq('is_published', true);

      final Set<String> platforms = {};

      for (var project in response as List) {
        final projectPlatforms = List<String>.from(project['platforms'] ?? []);
        platforms.addAll(projectPlatforms);
      }

      return platforms.toList()..sort();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching project platforms');
    }
  }

  // ==================== GET ALL TECH STACKS ====================
  @override
  Future<List<String>> getAllTechStacks() async {
    try {
      final response = await supabase!.from('projects').select('tech_stack').eq('is_published', true);

      final Set<String> techStacks = {};

      for (var project in response as List) {
        final projectTechStacks = List<String>.from(project['tech_stack'] ?? []);
        techStacks.addAll(projectTechStacks);
      }

      return techStacks.toList()..sort();
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Fetching tech stacks');
    }
  }

  // ==================== SEARCH PROJECTS ====================
  @override
  Future<List<ProjectModel>> searchProjects(String query) async {
    try {
      if (query.trim().isEmpty) {
        throw ValidationException('Search query cannot be empty');
      }

      // Fetch all published projects (client-side filtering)
      final response = await supabase!.from('projects').select().eq('is_published', true);

      final searchQuery = query.toLowerCase().trim();

      final filtered = (response as List).where((project) {
        final title = (project['title'] ?? '').toString().toLowerCase();
        final description = (project['description'] ?? '').toString().toLowerCase();
        final tagline = (project['tagline'] ?? '').toString().toLowerCase();
        final category = (project['category'] ?? '').toString().toLowerCase();
        final platforms = List<String>.from(project['platforms'] ?? []);
        final techStack = List<String>.from(project['tech_stack'] ?? []);

        return title.contains(searchQuery) ||
            description.contains(searchQuery) ||
            tagline.contains(searchQuery) ||
            category.contains(searchQuery) ||
            platforms.any((p) => p.toLowerCase().contains(searchQuery)) ||
            techStack.any((t) => t.toLowerCase().contains(searchQuery));
      }).toList();

      return filtered.map((json) => ProjectModel.fromSupabase(json)).toList();
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Searching projects');
    }
  }

  // ==================== INCREMENT VIEW COUNT ====================
  @override
  Future<void> incrementViewCount(String id) async {
    try {
      // Get current view count
      final response = await supabase!.from('projects').select('view_count').eq('id', id).maybeSingle();

      if (response == null) {
        throw NotFoundException('Project with ID "$id" not found');
      }

      final currentCount = response['view_count'] as int? ?? 0;

      // Increment and update
      await supabase!.from('projects').update({'view_count': currentCount + 1}).eq('id', id);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Incrementing view count');
    }
  }

  // ==================== CREATE PROJECT ====================
  @override
  Future<void> createProject(ProjectModel project) async {
    try {
      await supabase!.from('projects').insert(project.toSupabase());
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Creating project');
    }
  }

  // ==================== UPDATE PROJECT ====================
  @override
  Future<void> updateProject(ProjectModel project) async {
    try {
      final response = await supabase!
          .from('projects')
          .update(project.toSupabase())
          .eq('id', project.id)
          .select();

      if (response.isEmpty) {
        throw NotFoundException('Project with ID "${project.id}" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Updating project');
    }
  }

  // ==================== DELETE PROJECT ====================
  @override
  Future<void> deleteProject(String id) async {
    try {
      final response = await supabase!.from('projects').delete().eq('id', id).select();

      if (response.isEmpty) {
        throw NotFoundException('Project with ID "$id" not found');
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ExceptionHandler.parse(e, context: 'Deleting project');
    }
  }
}

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../entities/portfolio/project.dart';

abstract class ProjectRepository {
  /// Get all published projects
  Future<Either<Failure, List<Project>>> getAllProjects();

  /// Get featured projects
  Future<Either<Failure, List<Project>>> getFeaturedProjects();

  /// Get recent projects
  Future<Either<Failure, List<Project>>> getRecentProjects({int limit = 6});

  /// Get single project by ID
  Future<Either<Failure, Project>> getProjectById(String id);

  /// Get projects by category
  Future<Either<Failure, List<Project>>> getProjectsByCategory(String category);

  /// Get projects by platform
  Future<Either<Failure, List<Project>>> getProjectsByPlatform(String platform);

  /// Get all categories
  Future<Either<Failure, List<String>>> getAllCategories();

  /// Get all platforms
  Future<Either<Failure, List<String>>> getAllPlatforms();

  /// Get all tech stacks
  Future<Either<Failure, List<String>>> getAllTechStacks();

  /// Search projects
  Future<Either<Failure, List<Project>>> searchProjects(String query);

  /// Increment view count
  Future<Either<Failure, void>> incrementViewCount(String id);

  ///=================================== ADMIN SECTION ==========================================
  Future<Either<Failure, void>> createProject(Project project);

  Future<Either<Failure, void>> updateProject(Project project);

  Future<Either<Failure, void>> deleteProject(String id);
}

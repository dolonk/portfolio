import 'package:fpdart/fpdart.dart';
import 'project_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../entities/portfolio/project.dart';
import '../../../model/portfolio/project_model.dart';
import '../../../data_sources/remote/portfolio/project_remote_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final bool useFirebase;

  ProjectRepositoryImpl({required this.remoteDataSource, this.useFirebase = false});

  @override
  Future<Either<Failure, List<Project>>> getAllProjects() async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.getAllProjects();
        return Right(projects);
      } else {
        // Static data
        final projects = ProjectModel.getAllProjects();
        await Future.delayed(const Duration(milliseconds: 500));
        return Right(projects);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load projects: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getFeaturedProjects() async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.getFeaturedProjects();
        return Right(projects);
      } else {
        final projects = ProjectModel.getFeaturedProjects();
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(projects);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load featured projects'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getRecentProjects({int limit = 3}) async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.getRecentProjects(limit: limit);
        return Right(projects);
      } else {
        final allProjects = ProjectModel.getAllProjects();

        // Sort by updatedAt descending (most recent first)
        allProjects.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        final recentProjects = allProjects.take(limit).toList();
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(recentProjects);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load recent projects'));
    }
  }

  @override
  Future<Either<Failure, Project>> getProjectById(String id) async {
    try {
      if (useFirebase) {
        final project = await remoteDataSource.getProjectById(id);
        return Right(project);
      } else {
        final projects = ProjectModel.getAllProjects();
        final project = projects.firstWhere(
          (p) => p.id == id,
          orElse: () => throw ServerException('Project not found'),
        );
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(project);
      }
    } on ServerException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load project'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getProjectsByCategory(String category) async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.getProjectsByCategory(category);
        return Right(projects);
      } else {
        final projects = ProjectModel.getProjectsByCategory(category);
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(projects);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load projects by category'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getProjectsByPlatform(String platform) async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.getProjectsByPlatform(platform);
        return Right(projects);
      } else {
        final projects = ProjectModel.getProjectsByPlatform(platform);
        await Future.delayed(const Duration(milliseconds: 300));
        return Right(projects);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load projects by platform'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllCategories() async {
    try {
      if (useFirebase) {
        final categories = await remoteDataSource.getAllCategories();
        return Right(categories);
      } else {
        final categories = ProjectModel.getAllCategories();
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(categories);
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load categories'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllPlatforms() async {
    try {
      if (useFirebase) {
        final platforms = await remoteDataSource.getAllPlatforms();
        return Right(platforms);
      } else {
        final platforms = ProjectModel.getAllPlatforms();
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(platforms);
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load platforms'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllTechStacks() async {
    try {
      if (useFirebase) {
        final techStacks = await remoteDataSource.getAllTechStacks();
        return Right(techStacks);
      } else {
        final techStacks = ProjectModel.getAllTechStacks();
        await Future.delayed(const Duration(milliseconds: 200));
        return Right(techStacks);
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load tech stacks'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> searchProjects(String query) async {
    try {
      if (useFirebase) {
        final projects = await remoteDataSource.searchProjects(query);
        return Right(projects);
      } else {
        // Static data search
        final allProjects = ProjectModel.getAllProjects();
        final searchQuery = query.toLowerCase();

        final filteredProjects = allProjects.where((project) {
          return project.title.toLowerCase().contains(searchQuery) ||
              project.description.toLowerCase().contains(searchQuery) ||
              project.tagline.toLowerCase().contains(searchQuery) ||
              project.category.toLowerCase().contains(searchQuery) ||
              project.platforms.any((p) => p.toLowerCase().contains(searchQuery)) ||
              project.techStack.any((t) => t.toLowerCase().contains(searchQuery));
        }).toList();

        await Future.delayed(const Duration(milliseconds: 300));
        return Right(filteredProjects);
      }
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to search projects'));
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
  Future<Either<Failure, void>> createProject(Project project) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot create project.'));
      }
      await remoteDataSource.createProject(ProjectModel.fromEntity(project));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create project'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProject(Project project) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot update project.'));
      }
      await remoteDataSource.updateProject(ProjectModel.fromEntity(project));
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update project'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      if (!useFirebase) {
        return Left(ServerFailure(message: 'Firebase not configured. Cannot delete project.'));
      }
      await remoteDataSource.deleteProject(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to delete project'));
    }
  }
}

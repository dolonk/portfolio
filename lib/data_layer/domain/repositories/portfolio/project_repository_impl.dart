import 'project_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../entities/portfolio/project.dart';
import '../../../../core/error/exceptions.dart';
import '../../../model/portfolio/project_model.dart';
import '../../../data_sources/remote/portfolio/project_remote_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Project>>> getAllProjects() async {
    try {
      final projects = await remoteDataSource.getAllProjects();
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching all projects'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getFeaturedProjects() async {
    try {
      final projects = await remoteDataSource.getFeaturedProjects();
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching featured projects'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getRecentProjects({int limit = 3}) async {
    try {
      final projects = await remoteDataSource.getRecentProjects(limit: limit);
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching recent projects'));
    }
  }

  @override
  Future<Either<Failure, Project>> getProjectById(String id) async {
    try {
      final project = await remoteDataSource.getProjectById(id);
      return Right(project);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching project $id'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getProjectsByCategory(String category) async {
    try {
      final projects = await remoteDataSource.getProjectsByCategory(category);
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching projects by category: $category'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getProjectsByPlatform(String platform) async {
    try {
      final projects = await remoteDataSource.getProjectsByPlatform(platform);
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching projects by platform: $platform'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return Right(categories);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching all categories'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllPlatforms() async {
    try {
      final platforms = await remoteDataSource.getAllPlatforms();
      return Right(platforms);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching all platforms'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllTechStacks() async {
    try {
      final techStacks = await remoteDataSource.getAllTechStacks();
      return Right(techStacks);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Fetching all tech stacks'));
    }
  }

  @override
  Future<Either<Failure, List<Project>>> searchProjects(String query) async {
    try {
      final projects = await remoteDataSource.searchProjects(query);
      return Right(projects);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Searching projects: $query'));
    }
  }

  @override
  Future<Either<Failure, void>> incrementViewCount(String id) async {
    try {
      await remoteDataSource.incrementViewCount(id);
      return const Right(null);
    } catch (e) {
      debugPrint('Failed to increment view count: $e');
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> createProject(Project project) async {
    try {
      await remoteDataSource.createProject(ProjectModel.fromEntity(project));
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Creating project: ${project.title}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProject(Project project) async {
    try {
      await remoteDataSource.updateProject(ProjectModel.fromEntity(project));
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Updating project: ${project.id}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      await remoteDataSource.deleteProject(id);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.parseToFailure(e, context: 'Deleting project: $id'));
    }
  }
}

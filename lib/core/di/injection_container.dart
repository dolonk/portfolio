import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data_layer/data_sources/remote/comment/comment_remote_datasource.dart';
import '../../data_layer/data_sources/remote/portfolio/project_remote_datasource.dart';
import '../../data_layer/domain/repositories/comment/comment_repository.dart';
import '../../data_layer/domain/repositories/comment/comment_repository_impl.dart';
import '../../data_layer/domain/repositories/portfolio/project_repository.dart';
import '../../data_layer/domain/repositories/portfolio/project_repository_impl.dart';
import '../../features/admin_section/auth/providers/admin_auth_provider.dart';
import '../../features/blog/providers/blog_provider.dart';
import '../../data_layer/domain/repositories/blog/blog_repository.dart';
import '../../data_layer/domain/repositories/blog/blog_repository_impl.dart';
import '../../data_layer/data_sources/remote/blog/blog_remote_datasource.dart';
import '../../features/blog_detail/providers/comment_provider.dart';
import '../../features/portfolio/providers/project_provider.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies({bool useFirebase = false}) async {
  print('🚀 Initializing Dependencies...');
  print('📱 Firebase Mode: ${useFirebase ? "ENABLED ✅" : "DISABLED ❌ (Static Data)"}');

  // ==================== EXTERNAL DEPENDENCIES ====================
  if (useFirebase) {
    try {
      final firestore = FirebaseFirestore.instance;
      getIt.registerLazySingleton<FirebaseFirestore>(() => firestore);
      print('✅ Firebase Firestore registered');
    } catch (e) {
      print('⚠️ Firebase registration failed: $e');
      print('⚠️ Falling back to static data');
    }
  } else {
    print('⚠️ Firebase not initialized - Using static data');
  }

  /// ====================  DATA SOURCES ====================
  getIt.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      firestore: useFirebase && getIt.isRegistered<FirebaseFirestore>() ? getIt<FirebaseFirestore>() : null,
    ),
  );

  getIt.registerLazySingleton<CommentRemoteDataSource>(
    () => CommentRemoteDataSourceImpl(
      firestore: useFirebase && getIt.isRegistered<FirebaseFirestore>() ? getIt<FirebaseFirestore>() : null,
    ),
  );

  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(
      firestore: useFirebase && getIt.isRegistered<FirebaseFirestore>() ? getIt<FirebaseFirestore>() : null,
    ),
  );

  /// ==================== REPOSITORIES ====================
  getIt.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(remoteDataSource: getIt<BlogRemoteDataSource>(), useFirebase: useFirebase),
  );

  getIt.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: getIt<CommentRemoteDataSource>(), useFirebase: useFirebase),
  );

  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(remoteDataSource: getIt<ProjectRemoteDataSource>(), useFirebase: useFirebase),
  );

  /// ==================== PROVIDERS ====================
  getIt.registerFactory<BlogProvider>(() => BlogProvider(repository: getIt<BlogRepository>()));

  getIt.registerFactory<CommentProvider>(() => CommentProvider(repository: getIt<CommentRepository>()));

  getIt.registerFactory<ProjectProvider>(() => ProjectProvider(repository: getIt<ProjectRepository>()));

  /// ====================  Admin Provider ====================
  getIt.registerFactory<AdminAuthProvider>(
    () => AdminAuthProvider(
      firestore: useFirebase && getIt.isRegistered<FirebaseFirestore>() ? getIt<FirebaseFirestore>() : null,
    ),
  );

  print('✅ All Dependencies registered');
  print('🎉 Dependency Injection setup complete!\n');
}

/// Clear all dependencies (useful for testing)
void resetDependencies() {
  getIt.reset();
  print('🔄 Dependencies reset');
}

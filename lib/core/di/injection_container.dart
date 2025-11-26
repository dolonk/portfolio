import 'package:get_it/get_it.dart';
import 'package:flutter/cupertino.dart';
import '../config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/blog/providers/blog_provider.dart';
import '../../features/portfolio/providers/project_provider.dart';
import '../../features/blog_detail/providers/comment_provider.dart';
import '../../data_layer/domain/repositories/blog/blog_repository.dart';
import '../../data_layer/domain/repositories/blog/blog_repository_impl.dart';
import '../../data_layer/data_sources/remote/blog/blog_remote_datasource.dart';
import '../../data_layer/data_sources/remote/comment/comment_remote_datasource.dart';
import '../../data_layer/data_sources/remote/portfolio/project_remote_datasource.dart';
import '../../data_layer/domain/repositories/comment/comment_repository.dart';
import '../../data_layer/domain/repositories/comment/comment_repository_impl.dart';
import '../../data_layer/domain/repositories/portfolio/project_repository.dart';
import '../../data_layer/domain/repositories/portfolio/project_repository_impl.dart';
import '../../features/admin_section/auth/providers/admin_auth_provider.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies({bool useSupabase = false}) async {
  debugPrint('🚀 Initializing Dependencies...');
  debugPrint('📱 Supabase Mode: ${useSupabase ? "ENABLED ✅" : "DISABLED ❌ (Static Data)"}');

  if (useSupabase) {
    try {
      await SupabaseConfig.initialize();
      debugPrint('URL: ${SupabaseConfig.supabaseUrl}');

      final supabase = SupabaseConfig.client;
      getIt.registerLazySingleton<SupabaseClient>(() => supabase);
      debugPrint('✅ Supabase client registered');
    } catch (e) {
      debugPrint('❌ Supabase initialization failed: $e');
    }
  } else {
    debugPrint('⚠️ Supabase not initialized - Using static data');
  }

  /// ====================  DATA SOURCES ====================
  getIt.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(supabase: SupabaseConfig.isInitialized ? getIt<SupabaseClient>() : null),
  );

  getIt.registerLazySingleton<CommentRemoteDataSource>(
    () =>
        CommentRemoteDataSourceImpl(supabase: SupabaseConfig.isInitialized ? getIt<SupabaseClient>() : null),
  );

  getIt.registerLazySingleton<ProjectRemoteDataSource>(
    () =>
        ProjectRemoteDataSourceImpl(supabase: SupabaseConfig.isInitialized ? getIt<SupabaseClient>() : null),
  );

  /// ==================== REPOSITORIES ====================
  getIt.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(remoteDataSource: getIt<BlogRemoteDataSource>(), useSupabase: useSupabase),
  );

  getIt.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: getIt<CommentRemoteDataSource>(), useSupabase: useSupabase),
  );

  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(remoteDataSource: getIt<ProjectRemoteDataSource>(), useFirebase: useSupabase),
  );

  /// ==================== PROVIDERS ====================
  getIt.registerFactory<BlogProvider>(() => BlogProvider(repository: getIt<BlogRepository>()));

  getIt.registerFactory<CommentProvider>(() => CommentProvider(repository: getIt<CommentRepository>()));

  getIt.registerFactory<ProjectProvider>(() => ProjectProvider(repository: getIt<ProjectRepository>()));

  /// ====================  Admin Provider ====================
  getIt.registerFactory<AdminAuthProvider>(
    () => AdminAuthProvider(supabase: SupabaseConfig.isInitialized ? getIt<SupabaseClient>() : null),
  );

  print('✅ All Dependencies registered');
  print('🎉 Dependency Injection setup complete!\n');
}

/// Clear all dependencies (useful for testing)
void resetDependencies() {
  getIt.reset();
  print('🔄 Dependencies reset');
}

import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/blog/providers/blog_provider.dart';
import '../../data_layer/domain/repositories/blog/blog_repository.dart';
import '../../data_layer/domain/repositories/blog/blog_repository_impl.dart';
import '../../data_layer/data_sources/remote/blog/blog_remote_datasource.dart';

final getIt = GetIt.instance;
Future<void> initializeDependencies({bool useFirebase = false}) async {
  print('🚀 Initializing Dependencies...');
  print('📱 Firebase Mode: ${useFirebase ? "ENABLED ✅" : "DISABLED ❌ (Static Data)"}');

  // ==================== EXTERNAL DEPENDENCIES ====================
  if (useFirebase) {
    try {
      // Firebase Firestore instance
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

  // ==================== DATA SOURCES ====================
  getIt.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      firestore: useFirebase && getIt.isRegistered<FirebaseFirestore>() ? getIt<FirebaseFirestore>() : null,
    ),
  );

  // ==================== REPOSITORIES ====================
  getIt.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(remoteDataSource: getIt<BlogRemoteDataSource>(), useFirebase: useFirebase),
  );

  // ==================== PROVIDERS (State Management) ====================
  getIt.registerFactory<BlogProvider>(() => BlogProvider(repository: getIt<BlogRepository>()));

  print('✅ All Providers registered');
  print('🎉 Dependency Injection setup complete!\n');
}

/// Clear all dependencies (useful for testing)
void resetDependencies() {
  getIt.reset();
  print('🔄 Dependencies reset');
}

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // ==================== CONFIG VALUES ====================
  static const String supabaseUrl = 'https://jjxswzunxbxnkavcocmx.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqeHN3enVueGJ4bmthdmNvY214Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQwNjQ4NzksImV4cCI6MjA3OTY0MDg3OX0.R4s4UIAhtwkZNMtPGwb7PI6RmbKfIHBRGrsOmQ6Zge0';

  // ==================== INITIALIZATION ====================
  /// Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey, debug: true);
  }

  // ==================== HELPER GETTERS ====================
  /// Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  /// Check if Supabase is initialized
  static bool get isInitialized {
    try {
      Supabase.instance;
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== TABLE NAMES ====================
  static const String adminsTable = 'admins';
  static const String blogPostsTable = 'blog_posts';
  static const String projectsTable = 'projects';
  static const String commentsTable = 'comments';
  static const String contactSubmissionsTable = 'contact_submissions';

  // ==================== STORAGE BUCKETS ====================
  static const String blogImagesBucket = 'blog-images';
  static const String projectImagesBucket = 'project-images';
  static const String uploadsBucket = 'uploads';
}

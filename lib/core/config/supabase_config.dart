import 'dart:typed_data';
import '../error/exceptions.dart';
import 'package:flutter/material.dart';
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

  /// Upload any image to any bucket
  Future<String> uploadImage({
    required Uint8List fileBytes,
    required String bucketName,
    required String folder,
    String? fileName,
  }) async {
    try {
      final String filePath = '$folder/$fileName';
      debugPrint('📤 Uploading to: $bucketName/$filePath');

      // Upload file
      final uploadRes = await client.storage
          .from(bucketName)
          .uploadBinary(filePath, fileBytes, fileOptions: const FileOptions(upsert: true, contentType: 'image/png'));
      debugPrint('✅ Upload response: $uploadRes');

      // Get full public URL
      final String publicUrl = client.storage.from(bucketName).getPublicUrl(filePath);
      debugPrint('✅ Public URL: $publicUrl');

      return publicUrl;
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Supabase Upload Failed:');
    }
  }

  /// Delete an image from bucket

  Future<void> deleteImage({required String bucketName, required String imageUrlOrPath}) async {
    try {
      // Extract file path from URL if needed
      String filePath = imageUrlOrPath;

      // Check if it's a full URL
      if (imageUrlOrPath.contains('storage/v1/object/public/$bucketName/')) {
        // Extract path after bucket name
        filePath = imageUrlOrPath.split('storage/v1/object/public/$bucketName/').last;
      } else if (imageUrlOrPath.contains(bucketName)) {
        // Handle other URL formats
        filePath = imageUrlOrPath.split('$bucketName/').last;
      }

      debugPrint('🗑️ Deleting from bucket: $bucketName');
      debugPrint('📄 File path: $filePath');

      // Delete from Supabase Storage
      final response = await client.storage.from(bucketName).remove([filePath]);

      debugPrint('✅ Delete response: $response');
    } catch (e) {
      throw ExceptionHandler.parse(e, context: 'Delete image from storage');
    }
  }
}

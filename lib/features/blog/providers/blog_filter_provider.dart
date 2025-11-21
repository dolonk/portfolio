import 'package:flutter/foundation.dart';

class BlogFilterProvider with ChangeNotifier {
  String? _selectedTag;
  final List<String> _selectedTags = [];
  String _sortBy = 'latest';
  bool _showOnlyFeatured = false;

  // Getters
  String? get selectedTag => _selectedTag;
  List<String> get selectedTags => _selectedTags;
  String get sortBy => _sortBy;
  bool get showOnlyFeatured => _showOnlyFeatured;
  bool get hasActiveFilters => _selectedTag != null || _selectedTags.isNotEmpty || _showOnlyFeatured;

  /// Set single tag filter
  void setTag(String? tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  /// Toggle multiple tags
  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    notifyListeners();
  }

  /// Set sort order
  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  /// Toggle featured only
  void toggleFeaturedOnly() {
    _showOnlyFeatured = !_showOnlyFeatured;
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedTag = null;
    _selectedTags.clear();
    _sortBy = 'latest';
    _showOnlyFeatured = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _selectedTags.clear();
    super.dispose();
  }
}

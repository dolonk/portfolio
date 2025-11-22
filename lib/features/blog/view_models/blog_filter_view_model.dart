import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/blog_filter_provider.dart';

class BlogFilterViewModel {
  final BuildContext context;

  BlogFilterViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  BlogFilterProvider get _provider => context.read<BlogFilterProvider>();
  BlogFilterProvider get _watchProvider => context.watch<BlogFilterProvider>();

  // ==================== GETTERS (From Provider) ====================
  String? get selectedTag => _watchProvider.selectedTag;
  List<String> get selectedTags => _watchProvider.selectedTags;
  String get sortBy => _watchProvider.sortBy;
  bool get showOnlyFeatured => _watchProvider.showOnlyFeatured;
  bool get hasActiveFilters => _watchProvider.hasActiveFilters;

  // ==================== ACTIONS (Forward to Provider) ====================
  void setTag(String? tag) {
    _provider.setTag(tag);
  }

  void toggleTag(String tag) {
    _provider.toggleTag(tag);
  }

  void setSortBy(String sortBy) {
    _provider.setSortBy(sortBy);
  }

  void toggleFeaturedOnly() {
    _provider.toggleFeaturedOnly();
  }

  void clearFilters() {
    _provider.clearFilters();
  }

  // ==================== HELPER METHODS (UI Formatting) ====================
  /// Check if tag is selected
  bool isTagSelected(String tag) {
    return selectedTag == tag;
  }

  /// Check if tag is in selected tags (multiple)
  bool isTagInSelectedTags(String tag) {
    return selectedTags.contains(tag);
  }

  /// Get active filter count
  int getActiveFilterCount() {
    int count = 0;
    if (selectedTag != null) count++;
    if (selectedTags.isNotEmpty) count += selectedTags.length;
    if (showOnlyFeatured) count++;
    return count;
  }

  /// Get sort display text
  String getSortDisplayText() {
    switch (sortBy) {
      case 'latest':
        return 'Latest First';
      case 'oldest':
        return 'Oldest First';
      case 'popular':
        return 'Most Popular';
      case 'trending':
        return 'Trending';
      default:
        return 'Sort By';
    }
  }

  /// Get filter summary text
  String getFilterSummaryText() {
    if (!hasActiveFilters) return 'No filters applied';

    final parts = <String>[];
    if (selectedTag != null) parts.add('Tag: $selectedTag');
    if (showOnlyFeatured) parts.add('Featured only');

    return parts.join(' • ');
  }
}

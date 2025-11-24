// class PortfolioPage extends StatefulWidget {
//   const PortfolioPage({super.key});
//
//   @override
//   State<PortfolioPage> createState() => _PortfolioPageState();
// }
//
// class _PortfolioPageState extends State<PortfolioPage> {
//   late final ProjectViewModel vm = ProjectViewModel(context);
//
//   @override
//   Widget build(BuildContext context) {
//     final filterBar = FilterBarSection(
//       selectedFilter: vm.selectedCategory ?? 'All',
//       onFilterChanged: _handleFilterChange,
//     );
//
//     return BaseScreen(
//       useCustomScrollView: true,
//       backgroundColor: DColors.background,
//       child: RefreshIndicator(
//         onRefresh: () => vm.refresh(),
//         child: CustomScrollView(
//           slivers: [
//             // Hero Section
//             const SliverToBoxAdapter(child: PortfolioHeroSection()),
//
//             // Filter Bar (Sticky)
//             SliverPinnedHeader(child: filterBar),
//
//             // Project Grid with State Handling
//             SliverToBoxAdapter(
//               child: DStateBuilder<List<Project>>(
//                 state: vm.projectsState,
//                 onLoading: () => _buildLoadingState(),
//                 onError: (msg) => _buildErrorState(msg),
//                 onEmpty: () => _buildEmptyState(),
//                 onSuccess: (projects) => ProjectGridSection(projects: vm.displayProjects),
//               ),
//             ),
//
//             // Load More Section
//             SliverToBoxAdapter(child: _buildLoadMoreSection()),
//
//             // Footer
//             const SliverToBoxAdapter(child: FooterSection()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Handle filter change
//   void _handleFilterChange(String filter) {
//     if (filter == 'All') {
//       vm.clearFilters();
//     } else {
//       vm.filterByCategory(filter);
//     }
//   }
//
//   /// Build Load More Section
//   Widget _buildLoadMoreSection() {
//     // Only show if there are more projects to load
//     if (!vm.hasMore || vm.displayProjects.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return LoadMoreSection(
//       isLoading: vm.isLoading,
//       displayedCount: vm.displayProjects.length,
//       totalCount: vm.filteredProjectsCount,
//       onLoadMore: () => vm.loadMore(),
//     );
//   }
//
//   /// Loading State
//   Widget _buildLoadingState() {
//     return const Padding(padding: EdgeInsets.all(60.0), child: Text("loading"));
//   }
//
//   /// Error State
//   Widget _buildErrorState(String message) {
//     return Padding(padding: const EdgeInsets.all(60.0), child: Text("loading"));
//   }
//
//   /// Empty State
//   Widget _buildEmptyState() {
//     return Padding(padding: const EdgeInsets.all(60.0), child: Text("loading"));
//   }
// }
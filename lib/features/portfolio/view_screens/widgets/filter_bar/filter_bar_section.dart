import 'widgets/filter_chip.dart';
import 'package:flutter/material.dart';
import '../../../view_models/project_view_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class FilterBarSection extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterBarSection({super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final vm = ProjectViewModel(context);
    //final filters = ['All', ...vm.categories];
    final filters = ['All', 'Mobile', 'Web', 'Desktop', 'UI/UX'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Wrap(
          spacing: s.paddingMd,
          runSpacing: s.paddingMd,
          alignment: WrapAlignment.center,
          children: filters.map((filter) {
            return PortfolioFilterChip(
              label: filter,
              isActive: selectedFilter == filter,
              onTap: () => onFilterChanged(filter),
            );
          }).toList(),
        ),
      ),
    );
  }
}

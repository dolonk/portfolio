import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../common_function/widgets/custom_button.dart';
import '../../../../route/route_name.dart';
import 'widgets/faq_item.dart';
import 'widgets/faq_search_bar.dart';
import 'widgets/faq_category_tabs.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/pricing/pricing_faq_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PriceFaqSection extends StatefulWidget {
  const PriceFaqSection({super.key});

  @override
  State<PriceFaqSection> createState() => _PriceFaqSectionState();
}

class _PriceFaqSectionState extends State<PriceFaqSection> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  int? _expandedIndex;

  List<PricingFaqModel> _getDisplayedFaqs() {
    List<PricingFaqModel> faqs;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      faqs = PricingFaqModel.searchFaqs(_searchQuery);
    } else {
      // Apply category filter
      faqs = PricingFaqModel.getFaqsByCategory(_selectedCategory);
    }

    return faqs;
  }

  void _handleCategoryChange(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = '';
      _expandedIndex = null;
    });
  }

  void _handleSearchChange(String query) {
    setState(() {
      _searchQuery = query;
      _expandedIndex = null;
    });
  }

  void _handleFaqToggle(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final displayedFaqs = _getDisplayedFaqs();

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1100),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(fonts, s),
              SizedBox(height: s.spaceBtwItems),

              // Search Bar
              FaqSearchBar(onSearchChanged: _handleSearchChange),
              SizedBox(height: s.spaceBtwItems),

              // Category Tabs
              if (_searchQuery.isEmpty) ...[
                FaqCategoryTabs(selectedCategory: _selectedCategory, onCategoryChanged: _handleCategoryChange),
                SizedBox(height: s.spaceBtwSections),
              ],

              // FAQ List
              _buildFaqList(displayedFaqs, s),

              // No Results Message
              if (displayedFaqs.isEmpty) _buildNoResults(fonts, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(DFontSizes fonts, DSizes s) {
    return Column(
      children: [
        Text('Common Questions About Pricing', style: fonts.headlineLarge, textAlign: TextAlign.center),
        SizedBox(height: s.paddingSm),
        Text(
          'Find answers to frequently asked questions',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// FAQ List
  Widget _buildFaqList(List<PricingFaqModel> faqs, DSizes s) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) =>
              SlideAnimation(verticalOffset: 30.0, child: FadeInAnimation(child: widget)),
          children: faqs.asMap().entries.map((entry) {
            final index = entry.key;
            final faq = entry.value;

            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingMd),
              child: FaqItem(faq: faq, isExpanded: _expandedIndex == index, onToggle: () => _handleFaqToggle(index)),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// No Results Message
  Widget _buildNoResults(DFontSizes fonts, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingXl * 2),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: DColors.textSecondary),
          SizedBox(height: s.paddingMd),
          Text('No results found', style: fonts.titleLarge.rajdhani(color: DColors.textSecondary)),
          SizedBox(height: s.paddingSm),
          Text(
            'Try adjusting your search or browse all questions',
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

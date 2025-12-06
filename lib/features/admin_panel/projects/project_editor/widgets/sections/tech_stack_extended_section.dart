import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class TechStackExtendedSection extends StatefulWidget {
  final List<Map<String, dynamic>> techStackExtended;
  final ValueChanged<List<Map<String, dynamic>>> onChanged;

  const TechStackExtendedSection({super.key, required this.techStackExtended, required this.onChanged});

  @override
  State<TechStackExtendedSection> createState() => _TechStackExtendedSectionState();
}

class _TechStackExtendedSectionState extends State<TechStackExtendedSection> {
  // Predefined icons for tech stack
  static const List<Map<String, dynamic>> availableIcons = [
    {'name': 'flutter', 'icon': FontAwesomeIcons.flutter, 'label': 'Flutter'},
    {'name': 'dart', 'icon': FontAwesomeIcons.code, 'label': 'Dart'},
    {'name': 'firebase', 'icon': FontAwesomeIcons.fire, 'label': 'Firebase'},
    {'name': 'supabase', 'icon': FontAwesomeIcons.database, 'label': 'Supabase'},
    {'name': 'bloc', 'icon': FontAwesomeIcons.cubes, 'label': 'BLoC'},
    {'name': 'provider', 'icon': FontAwesomeIcons.layerGroup, 'label': 'Provider'},
    {'name': 'rest_api', 'icon': FontAwesomeIcons.plug, 'label': 'REST API'},
    {'name': 'graphql', 'icon': FontAwesomeIcons.gratipay, 'label': 'GraphQL'},
    {'name': 'git', 'icon': FontAwesomeIcons.git, 'label': 'Git'},
    {'name': 'github', 'icon': FontAwesomeIcons.github, 'label': 'GitHub'},
    {'name': 'figma', 'icon': FontAwesomeIcons.figma, 'label': 'Figma'},
    {'name': 'stripe', 'icon': FontAwesomeIcons.stripe, 'label': 'Stripe'},
    {'name': 'aws', 'icon': FontAwesomeIcons.aws, 'label': 'AWS'},
    {'name': 'docker', 'icon': FontAwesomeIcons.docker, 'label': 'Docker'},
    {'name': 'node', 'icon': FontAwesomeIcons.nodeJs, 'label': 'Node.js'},
    {'name': 'python', 'icon': FontAwesomeIcons.python, 'label': 'Python'},
    {'name': 'java', 'icon': FontAwesomeIcons.java, 'label': 'Java'},
    {'name': 'swift', 'icon': FontAwesomeIcons.swift, 'label': 'Swift'},
    {'name': 'android', 'icon': FontAwesomeIcons.android, 'label': 'Android'},
    {'name': 'apple', 'icon': FontAwesomeIcons.apple, 'label': 'iOS'},
    {'name': 'get_it', 'icon': FontAwesomeIcons.syringe, 'label': 'Get It'},
    {'name': 'hive', 'icon': FontAwesomeIcons.cube, 'label': 'Hive'},
    {'name': 'sqlite', 'icon': FontAwesomeIcons.database, 'label': 'SQLite'},
  ];

  // Predefined categories
  static const List<String> categories = [
    'Framework',
    'Language',
    'Backend',
    'State Management',
    'Database',
    'Cloud',
    'Payment Gateway',
    'Design Tool',
    'Version Control',
    'DevOps',
    'Integration',
    'Dependency Injection',
  ];

  // Predefined colors
  static const List<Map<String, dynamic>> colorPalette = [
    {'hex': '#02569B', 'name': 'Flutter Blue'},
    {'hex': '#0175C2', 'name': 'Dart Blue'},
    {'hex': '#FFCA28', 'name': 'Firebase Yellow'},
    {'hex': '#3FCF8E', 'name': 'Supabase Green'},
    {'hex': '#8B5CF6', 'name': 'Purple'},
    {'hex': '#635BFF', 'name': 'Stripe Purple'},
    {'hex': '#3B82F6', 'name': 'Blue'},
    {'hex': '#10B981', 'name': 'Emerald'},
    {'hex': '#F05032', 'name': 'Git Orange'},
    {'hex': '#F24E1E', 'name': 'Figma Red'},
    {'hex': '#EF4444', 'name': 'Red'},
    {'hex': '#EC4899', 'name': 'Pink'},
    {'hex': '#F59E0B', 'name': 'Amber'},
    {'hex': '#06B6D4', 'name': 'Cyan'},
    {'hex': '#6366F1', 'name': 'Indigo'},
    {'hex': '#84CC16', 'name': 'Lime'},
  ];

  // Form controllers for adding new item
  String _selectedIcon = 'flutter';
  String _selectedCategory = 'Framework';
  String _selectedColor = '#02569B';
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(context),
          SizedBox(height: s.paddingMd),

          Text(
            'Add detailed tech stack with icons and categories for rich display',
            style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
          ),
          SizedBox(height: s.paddingLg),

          // Add New Item Form
          _buildAddItemForm(context, s),
          SizedBox(height: s.paddingLg),

          // Existing Items List
          if (widget.techStackExtended.isNotEmpty) ...[
            Divider(color: DColors.cardBorder),
            SizedBox(height: s.paddingMd),
            _buildItemsList(context, s),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.category_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Tech Stack Extended',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${widget.techStackExtended.length} items',
            style: context.fonts.bodySmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildAddItemForm(BuildContext context, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.background,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add New Technology',
            style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingMd),

          // Row 1: Icon & Name
          Row(
            children: [
              // Icon Dropdown
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Icon', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
                      decoration: BoxDecoration(
                        color: DColors.cardBackground,
                        borderRadius: BorderRadius.circular(s.borderRadiusSm),
                        border: Border.all(color: DColors.cardBorder),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedIcon,
                          isExpanded: true,
                          dropdownColor: DColors.cardBackground,
                          items: availableIcons.map((icon) {
                            return DropdownMenuItem<String>(
                              value: icon['name'] as String,
                              child: Row(
                                children: [
                                  FaIcon(icon['icon'] as IconData, size: 16, color: DColors.textPrimary),
                                  SizedBox(width: 8),
                                  Text(
                                    icon['label'] as String,
                                    style: context.fonts.bodySmall.rubik(color: DColors.textPrimary),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedIcon = value!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: s.paddingMd),

              // Name Input
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
                    SizedBox(height: 4),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Flutter',
                        hintStyle: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                        filled: true,
                        fillColor: DColors.cardBackground,
                        contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(s.borderRadiusSm),
                          borderSide: BorderSide(color: DColors.cardBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(s.borderRadiusSm),
                          borderSide: BorderSide(color: DColors.cardBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(s.borderRadiusSm),
                          borderSide: BorderSide(color: DColors.primaryButton, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Row 2: Category
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
                decoration: BoxDecoration(
                  color: DColors.cardBackground,
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  border: Border.all(color: DColors.cardBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    dropdownColor: DColors.cardBackground,
                    items: categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat,
                        child: Text(cat, style: context.fonts.bodySmall.rubik(color: DColors.textPrimary)),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Row 3: Color Picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Color', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colorPalette.map((color) {
                  final isSelected = _selectedColor == color['hex'];
                  return InkWell(
                    onTap: () => setState(() => _selectedColor = color['hex'] as String),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _hexToColor(color['hex'] as String),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: _hexToColor(color['hex'] as String).withAlpha(150),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: isSelected ? Icon(Icons.check, size: 16, color: Colors.white) : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: s.paddingLg),

          // Add Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addItem,
              icon: Icon(Icons.add_rounded),
              label: Text('Add Technology'),
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.primaryButton,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added Technologies',
          style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingMd),
        Wrap(
          spacing: s.paddingMd,
          runSpacing: s.paddingMd,
          children: widget.techStackExtended.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _buildTechItem(context, s, item, index);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTechItem(BuildContext context, DSizes s, Map<String, dynamic> item, int index) {
    final color = _hexToColor(item['colorHex'] as String? ?? '#3B82F6');
    final iconData =
        availableIcons.firstWhere(
              (i) => i['name'] == item['iconName'],
              orElse: () => availableIcons.first,
            )['icon']
            as IconData;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Center(child: FaIcon(iconData, size: 16, color: Colors.white)),
          ),
          SizedBox(width: s.paddingSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['name'] as String? ?? '',
                style: context.fonts.bodyMedium.rubik(
                  fontWeight: FontWeight.w600,
                  color: DColors.textPrimary,
                ),
              ),
              Text(
                item['category'] as String? ?? '',
                style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
              ),
            ],
          ),
          SizedBox(width: s.paddingMd),
          InkWell(
            onTap: () => _removeItem(index),
            child: Icon(Icons.close, size: 18, color: Colors.red.shade400),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final newItem = {
      'iconName': _selectedIcon,
      'name': name,
      'category': _selectedCategory,
      'colorHex': _selectedColor,
    };

    final updated = List<Map<String, dynamic>>.from(widget.techStackExtended)..add(newItem);
    widget.onChanged(updated);
    _nameController.clear();
  }

  void _removeItem(int index) {
    final updated = List<Map<String, dynamic>>.from(widget.techStackExtended)..removeAt(index);
    widget.onChanged(updated);
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}

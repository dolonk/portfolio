import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class KeyFeaturesExtendedSection extends StatefulWidget {
  final List<Map<String, dynamic>> keyFeaturesExtended;
  final ValueChanged<List<Map<String, dynamic>>> onChanged;

  const KeyFeaturesExtendedSection({
    super.key,
    required this.keyFeaturesExtended,
    required this.onChanged,
  });

  @override
  State<KeyFeaturesExtendedSection> createState() => _KeyFeaturesExtendedSectionState();
}

class _KeyFeaturesExtendedSectionState extends State<KeyFeaturesExtendedSection> {
  // Predefined icons for features
  static const List<Map<String, dynamic>> availableIcons = [
    {'name': 'user_check', 'icon': FontAwesomeIcons.userCheck, 'label': 'User Check'},
    {'name': 'magnifying_glass', 'icon': FontAwesomeIcons.magnifyingGlass, 'label': 'Search'},
    {'name': 'cart_shopping', 'icon': FontAwesomeIcons.cartShopping, 'label': 'Cart'},
    {'name': 'credit_card', 'icon': FontAwesomeIcons.creditCard, 'label': 'Payment'},
    {'name': 'truck_fast', 'icon': FontAwesomeIcons.truckFast, 'label': 'Delivery'},
    {'name': 'bell', 'icon': FontAwesomeIcons.bell, 'label': 'Notification'},
    {'name': 'heart', 'icon': FontAwesomeIcons.heart, 'label': 'Favorite'},
    {'name': 'language', 'icon': FontAwesomeIcons.language, 'label': 'Language'},
    {'name': 'shield', 'icon': FontAwesomeIcons.shield, 'label': 'Security'},
    {'name': 'chart_line', 'icon': FontAwesomeIcons.chartLine, 'label': 'Analytics'},
    {'name': 'comments', 'icon': FontAwesomeIcons.comments, 'label': 'Chat'},
    {'name': 'cloud', 'icon': FontAwesomeIcons.cloud, 'label': 'Cloud'},
    {'name': 'lock', 'icon': FontAwesomeIcons.lock, 'label': 'Lock'},
    {'name': 'gear', 'icon': FontAwesomeIcons.gear, 'label': 'Settings'},
    {'name': 'star', 'icon': FontAwesomeIcons.star, 'label': 'Star'},
    {'name': 'compass', 'icon': FontAwesomeIcons.compass, 'label': 'Compass'},
    {'name': 'map', 'icon': FontAwesomeIcons.map, 'label': 'Map'},
    {'name': 'camera', 'icon': FontAwesomeIcons.camera, 'label': 'Camera'},
    {'name': 'image', 'icon': FontAwesomeIcons.image, 'label': 'Image'},
    {'name': 'file', 'icon': FontAwesomeIcons.file, 'label': 'File'},
    {'name': 'share', 'icon': FontAwesomeIcons.shareNodes, 'label': 'Share'},
    {'name': 'download', 'icon': FontAwesomeIcons.download, 'label': 'Download'},
    {'name': 'upload', 'icon': FontAwesomeIcons.upload, 'label': 'Upload'},
    {'name': 'sync', 'icon': FontAwesomeIcons.rotate, 'label': 'Sync'},
  ];

  // Predefined colors
  static const List<Map<String, dynamic>> colorPalette = [
    {'hex': '#8B5CF6', 'name': 'Purple'},
    {'hex': '#3B82F6', 'name': 'Blue'},
    {'hex': '#10B981', 'name': 'Emerald'},
    {'hex': '#EF4444', 'name': 'Red'},
    {'hex': '#F59E0B', 'name': 'Amber'},
    {'hex': '#EC4899', 'name': 'Pink'},
    {'hex': '#06B6D4', 'name': 'Cyan'},
    {'hex': '#6366F1', 'name': 'Indigo'},
    {'hex': '#84CC16', 'name': 'Lime'},
    {'hex': '#DC2626', 'name': 'Red Dark'},
    {'hex': '#14B8A6', 'name': 'Teal'},
    {'hex': '#F97316', 'name': 'Orange'},
  ];

  // Form controllers
  String _selectedIcon = 'user_check';
  String _selectedColor = '#8B5CF6';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
            'Add detailed features with icons and descriptions for rich display',
            style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
          ),
          SizedBox(height: s.paddingLg),

          // Add New Item Form
          _buildAddItemForm(context, s),
          SizedBox(height: s.paddingLg),

          // Existing Items List
          if (widget.keyFeaturesExtended.isNotEmpty) ...[
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
        Icon(Icons.auto_awesome_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Key Features Extended',
          style: context.fonts.titleLarge.rajdhani(
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${widget.keyFeaturesExtended.length} items',
            style: context.fonts.bodySmall.rubik(
              color: DColors.primaryButton,
              fontWeight: FontWeight.w600,
            ),
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
            'Add New Feature',
            style: context.fonts.bodyMedium.rubik(
              fontWeight: FontWeight.w600,
              color: DColors.textPrimary,
            ),
          ),
          SizedBox(height: s.paddingMd),

          // Row 1: Icon & Title
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
                                  FaIcon(icon['icon'] as IconData, size: 14, color: DColors.textPrimary),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      icon['label'] as String,
                                      style: context.fonts.bodySmall.rubik(color: DColors.textPrimary),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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

              // Title Input
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
                    SizedBox(height: 4),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'e.g., User Authentication',
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

          // Row 2: Description
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description', style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
              SizedBox(height: 4),
              TextField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Describe this feature...',
                  hintStyle: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                  filled: true,
                  fillColor: DColors.cardBackground,
                  contentPadding: EdgeInsets.all(s.paddingMd),
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
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: isSelected
                            ? [BoxShadow(color: _hexToColor(color['hex'] as String).withAlpha(150), blurRadius: 8)]
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
              label: Text('Add Feature'),
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
          'Added Features',
          style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingMd),
        ...widget.keyFeaturesExtended.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: s.paddingMd),
            child: _buildFeatureItem(context, s, item, index),
          );
        }),
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, DSizes s, Map<String, dynamic> item, int index) {
    final color = _hexToColor(item['colorHex'] as String? ?? '#8B5CF6');
    final iconData = availableIcons.firstWhere(
      (i) => i['name'] == item['iconName'],
      orElse: () => availableIcons.first,
    )['icon'] as IconData;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: FaIcon(iconData, size: 20, color: Colors.white)),
          ),
          SizedBox(width: s.paddingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String? ?? '',
                  style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
                ),
                SizedBox(height: 4),
                Text(
                  item['description'] as String? ?? '',
                  style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _removeItem(index),
            icon: Icon(Icons.delete_rounded, color: Colors.red.shade400, size: 20),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty) return;

    final newItem = {
      'iconName': _selectedIcon,
      'title': title,
      'description': description,
      'colorHex': _selectedColor,
    };

    final updated = List<Map<String, dynamic>>.from(widget.keyFeaturesExtended)..add(newItem);
    widget.onChanged(updated);
    _titleController.clear();
    _descriptionController.clear();
  }

  void _removeItem(int index) {
    final updated = List<Map<String, dynamic>>.from(widget.keyFeaturesExtended)..removeAt(index);
    widget.onChanged(updated);
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}

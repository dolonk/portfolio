import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/contact/contact_form_model.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/custom_dropdown.dart';
import 'widgets/platform_checkbox_group.dart';
import 'widgets/file_upload_widget.dart';
import 'widgets/form_submit_button.dart';

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _messageController = TextEditingController();

  // Dropdown values
  String? _projectType;
  String? _budgetRange;
  String? _timeline;

  // Checkboxes
  List<String> _selectedPlatforms = [];
  bool _ndaRequired = false;
  bool _newsletterSignup = false;

  // File upload
  String? _attachedFileName;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1100),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'SEND A MESSAGE',
                title: 'Tell Me About Your Project',
                subtitle: 'Fill out the form below and I\'ll get back to you within 24 hours',
                alignment: TextAlign.center,
                maxWidth: 700,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Form
              _buildForm(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Main Form with Two-Column Desktop Layout
  Widget _buildForm(BuildContext context, DSizes s) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Name & Email (Two Columns on Desktop)
          _buildTwoColumnRow(
            context,
            s,
            leftChild: CustomTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              isRequired: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                if (value.trim().length < 2) {
                  return 'Name must be at least 2 characters';
                }
                if (value.trim().length > 50) {
                  return 'Name must be less than 50 characters';
                }
                return null;
              },
            ),
            rightChild: CustomTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'your.email@example.com',
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Row 2: Phone & Company (Two Columns on Desktop)
          _buildTwoColumnRow(
            context,
            s,
            leftChild: CustomTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: '+1 (234) 567-8900',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final phoneRegex = RegExp(r'^\+?[\d\s\-()]+$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                }
                return null;
              },
            ),
            rightChild: CustomTextField(
              controller: _companyController,
              label: 'Company/Organization',
              hint: 'Your company name (optional)',
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Row 3: Project Type & Budget (Two Columns on Desktop)
          _buildTwoColumnRow(
            context,
            s,
            leftChild: CustomDropdown(
              label: 'Project Type',
              hint: 'Select project type',
              isRequired: true,
              value: _projectType,
              items: const [
                'Mobile App',
                'Web Application',
                'Desktop Application',
                'Cross-Platform Solution',
                'Consulting',
                'Maintenance/Support',
                'UI/UX Design',
                'Other',
              ],
              onChanged: (value) => setState(() => _projectType = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a project type';
                }
                return null;
              },
            ),
            rightChild: CustomDropdown(
              label: 'Budget Range',
              hint: 'Select your budget range',
              isRequired: true,
              value: _budgetRange,
              items: const ['Under \$5K', '\$5K - \$10K', '\$10K - \$25K', '\$25K - \$50K', '\$50K+', 'Not sure yet'],
              onChanged: (value) => setState(() => _budgetRange = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a budget range';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Row 4: Timeline (Full Width)
          CustomDropdown(
            label: 'Project Timeline',
            hint: 'Select your preferred timeline',
            value: _timeline,
            items: const ['Urgent (1-2 weeks)', 'ASAP (3-4 weeks)', 'Standard (1-2 months)', 'Flexible (3+ months)'],
            onChanged: (value) => setState(() => _timeline = value),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Platform Checkboxes (Full Width)
          PlatformCheckboxGroup(
            selectedPlatforms: _selectedPlatforms,
            onChanged: (platforms) => setState(() => _selectedPlatforms = platforms),
            validator: (platforms) {
              if (platforms.isEmpty) {
                return 'Please select at least one platform';
              }
              return null;
            },
          ),
          SizedBox(height: s.spaceBtwItems),

          // Message Field (Full Width)
          CustomTextField(
            controller: _messageController,
            label: 'Message/Project Description',
            hint: 'Tell us about your project requirements...',
            isRequired: true,
            maxLines: 6,
            maxLength: 1000,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please describe your project';
              }
              if (value.trim().length < 50) {
                return 'Description must be at least 50 characters';
              }
              return null;
            },
          ),
          SizedBox(height: s.spaceBtwItems),

          // File Upload (Full Width)
          FileUploadWidget(onFileSelected: (fileName) => setState(() => _attachedFileName = fileName)),
          SizedBox(height: s.spaceBtwItems),

          // NDA Checkbox
          _buildCheckbox(
            label: 'NDA Required?',
            value: _ndaRequired,
            onChanged: (value) => setState(() => _ndaRequired = value ?? false),
          ),
          SizedBox(height: s.paddingMd),

          // Newsletter Checkbox
          _buildCheckbox(
            label: 'Send me Flutter tips and updates',
            value: _newsletterSignup,
            onChanged: (value) => setState(() => _newsletterSignup = value ?? false),
          ),
          SizedBox(height: s.spaceBtwItems),

          // reCAPTCHA Placeholder
          _buildRecaptchaPlaceholder(s),
          SizedBox(height: s.spaceBtwItems),

          // Note
          _buildFormNote(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Submit Button
          Center(
            child: FormSubmitButton(isLoading: _isLoading, onPressed: _submitForm),
          ),
          SizedBox(height: s.spaceBtwItems),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 300.ms);
  }

  /// Helper: Two-Column Row (Desktop) / Single Column (Mobile)
  Widget _buildTwoColumnRow(BuildContext context, DSizes s, {required Widget leftChild, required Widget rightChild}) {
    if (context.isDesktop) {
      // Desktop: Two columns side-by-side
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: leftChild),
          SizedBox(width: s.spaceBtwItems),
          Expanded(child: rightChild),
        ],
      );
    } else {
      // Mobile/Tablet: Stacked vertically
      return Column(
        children: [
          leftChild,
          SizedBox(height: s.spaceBtwItems),
          rightChild,
        ],
      );
    }
  }

  /// Custom Checkbox Widget
  Widget _buildCheckbox({required String label, required bool value, required void Function(bool?) onChanged}) {
    final s = context.sizes;
    final fonts = context.fonts;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(s.borderRadiusSm),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: s.paddingSm * 0.5),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value ? DColors.primaryButton : Colors.transparent,
                border: Border.all(color: value ? DColors.primaryButton : DColors.cardBorder, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: value ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            SizedBox(width: s.paddingMd),
            Expanded(
              child: Text(label, style: fonts.bodyMedium.rubik(color: DColors.textPrimary)),
            ),
          ],
        ),
      ),
    );
  }

  /// reCAPTCHA Placeholder
  Widget _buildRecaptchaPlaceholder(DSizes s) {
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.secondaryBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_rounded, color: DColors.primaryButton, size: 20),
          SizedBox(width: s.paddingMd),
          Expanded(
            child: Text('Protected by reCAPTCHA', style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
          ),
        ],
      ),
    );
  }

  /// Form Note
  Widget _buildFormNote(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Center(
      child: Column(
        children: [
          Text(
            '* Required fields',
            style: fonts.bodySmall.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.paddingSm * 0.5),
          Text(
            'I\'ll respond within 24 hours',
            style: fonts.bodySmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Submit Form
  Future<void> _submitForm() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate platforms manually (checkbox group)
    if (_selectedPlatforms.isEmpty) {
      _showErrorSnackbar('Please select at least one platform');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Create form model
      final formData = ContactFormModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        company: _companyController.text.trim().isEmpty ? null : _companyController.text.trim(),
        projectType: _projectType!,
        platforms: _selectedPlatforms,
        budgetRange: _budgetRange!,
        timeline: _timeline ?? '',
        message: _messageController.text.trim(),
        attachedFileName: _attachedFileName,
        ndaRequired: _ndaRequired,
        newsletterSignup: _newsletterSignup,
      );

      // TODO: Send to backend API
      await _sendToBackend(formData);

      // Show success message
      _showSuccessSnackbar('Message sent successfully! I\'ll respond within 24 hours.');

      // Clear form
      _clearForm();
    } catch (e) {
      _showErrorSnackbar('Failed to send message. Please try again.');
      debugPrint('Form submission error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Send to Backend (Placeholder)
  Future<void> _sendToBackend(ContactFormModel formData) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Implement actual API call
    debugPrint('Form Data: ${formData.toJson()}');
  }

  /// Clear Form
  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _companyController.clear();
    _messageController.clear();

    _projectType = null;
    _budgetRange = null;
    _timeline = null;
    _selectedPlatforms = [];
    _ndaRequired = false;
    _newsletterSignup = false;
    _attachedFileName = null;
    setState(() {});
  }

  /// Show Success Snackbar
  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: context.fonts.bodyMedium),
        backgroundColor: const Color(0xFF10B981), // Green
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(context.sizes.paddingMd),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show Error Snackbar
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: context.fonts.bodyMedium),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(context.sizes.paddingMd),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

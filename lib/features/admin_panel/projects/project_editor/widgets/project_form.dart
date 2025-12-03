import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../common_function/widgets/custom_button.dart';
import '../../../../../data_layer/domain/entities/portfolio/project.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/basic_info_section.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/features_results_section.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/media_links_section.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/platform_tech_section.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/project_details_section.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/sections/publishing_section.dart';

class ProjectForm extends StatefulWidget {
  final Project? existingProject;
  final VoidCallback onCancel;
  final Function(Project project, bool publish) onSave;

  const ProjectForm({super.key, this.existingProject, required this.onCancel, required this.onSave});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Controllers for text fields
  late final TextEditingController _titleController;
  late final TextEditingController _taglineController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _clientNameController;
  late final TextEditingController _launchDateController;
  late final TextEditingController _challengeController;
  late final TextEditingController _requirementsController;
  late final TextEditingController _constraintsController;
  late final TextEditingController _solutionController;
  late final TextEditingController _testimonialController;
  late final TextEditingController _demoVideoUrlController;
  late final TextEditingController _liveUrlController;
  late final TextEditingController _appStoreUrlController;
  late final TextEditingController _playStoreUrlController;
  late final TextEditingController _githubUrlController;

  // Form data
  String _category = 'Mobile App';
  String _imagePath = '';
  List<String> _platforms = [];
  List<String> _techStack = [];
  List<String> _keyFeatures = [];
  Map<String, String> _results = {};
  List<String> _galleryImages = [];
  bool _isPublished = false;
  bool _isFeatured = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadExistingData();
  }

  void _initializeControllers() {
    _titleController = TextEditingController();
    _taglineController = TextEditingController();
    _descriptionController = TextEditingController();
    _clientNameController = TextEditingController();
    _launchDateController = TextEditingController();
    _challengeController = TextEditingController();
    _requirementsController = TextEditingController();
    _constraintsController = TextEditingController();
    _solutionController = TextEditingController();
    _testimonialController = TextEditingController();
    _demoVideoUrlController = TextEditingController();
    _liveUrlController = TextEditingController();
    _appStoreUrlController = TextEditingController();
    _playStoreUrlController = TextEditingController();
    _githubUrlController = TextEditingController();
  }

  void _loadExistingData() {
    if (widget.existingProject != null) {
      final p = widget.existingProject!;

      _titleController.text = p.title;
      _taglineController.text = p.tagline;
      _descriptionController.text = p.description;
      _clientNameController.text = p.clientName;
      _launchDateController.text = p.launchDate;
      _challengeController.text = p.challenge;
      _requirementsController.text = p.requirements;
      _constraintsController.text = p.constraints;
      _solutionController.text = p.solution;
      _testimonialController.text = p.clientTestimonial;
      _demoVideoUrlController.text = p.demoVideoUrl;
      _liveUrlController.text = p.liveUrl ?? '';
      _appStoreUrlController.text = p.appStoreUrl ?? '';
      _playStoreUrlController.text = p.playStoreUrl ?? '';
      _githubUrlController.text = p.githubUrl;

      _category = p.category;
      _imagePath = p.imagePath;
      _platforms = List.from(p.platforms);
      _techStack = List.from(p.techStack);
      _keyFeatures = List.from(p.keyFeatures);
      _results = Map.from(p.results);
      _galleryImages = List.from(p.galleryImages);
      _isPublished = p.isPublished;
      _isFeatured = p.isFeatured;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    _clientNameController.dispose();
    _launchDateController.dispose();
    _challengeController.dispose();
    _requirementsController.dispose();
    _constraintsController.dispose();
    _solutionController.dispose();
    _testimonialController.dispose();
    _demoVideoUrlController.dispose();
    _liveUrlController.dispose();
    _appStoreUrlController.dispose();
    _playStoreUrlController.dispose();
    _githubUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Basic Information
          BasicInfoSection(
            titleController: _titleController,
            taglineController: _taglineController,
            descriptionController: _descriptionController,
            category: _category,
            imagePath: _imagePath,
            onCategoryChanged: (value) => setState(() => _category = value),
            onImageChanged: (path) => setState(() => _imagePath = path),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Section 2: Platform & Tech
          PlatformTechSection(
            selectedPlatforms: _platforms,
            selectedTechStack: _techStack,
            onPlatformsChanged: (value) => setState(() => _platforms = value),
            onTechStackChanged: (value) => setState(() => _techStack = value),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Section 3: Project Details
          ProjectDetailsSection(
            clientNameController: _clientNameController,
            launchDateController: _launchDateController,
            challengeController: _challengeController,
            requirementsController: _requirementsController,
            constraintsController: _constraintsController,
            solutionController: _solutionController,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Section 4: Features & Results
          FeaturesResultsSection(
            keyFeatures: _keyFeatures,
            results: _results,
            testimonialController: _testimonialController,
            onFeaturesChanged: (value) => setState(() => _keyFeatures = value),
            onResultsChanged: (value) => setState(() => _results = value),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Section 5: Media & Links
          MediaLinksSection(
            galleryImages: _galleryImages,
            demoVideoUrlController: _demoVideoUrlController,
            liveUrlController: _liveUrlController,
            appStoreUrlController: _appStoreUrlController,
            playStoreUrlController: _playStoreUrlController,
            githubUrlController: _githubUrlController,
            onGalleryChanged: (value) => setState(() => _galleryImages = value),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Section 6: Publishing Options
          PublishingSection(
            isPublished: _isPublished,
            isFeatured: _isFeatured,
            onPublishedChanged: (value) => setState(() => _isPublished = value),
            onFeaturedChanged: (value) => setState(() => _isFeatured = value),
          ),
          SizedBox(height: s.spaceBtwSections),

          // Action Buttons
          _buildActionButtons(context, s),
        ],
      ),
    );
  }

  /// Action Buttons
  Widget _buildActionButtons(BuildContext context, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Row(
        children: [
          // Cancel Button
          Expanded(
            child: CustomButton(
              height: 50,
              tittleText: 'Cancel',
              isPrimary: false,
              onPressed: _isSaving ? () {} : widget.onCancel,
              isDisabled: _isSaving,
            ),
          ),
          SizedBox(width: s.paddingMd),

          // Save Draft Button
          Expanded(
            child: CustomButton(
              height: 50,
              tittleText: 'Save Draft',
              isPrimary: false,
              icon: Icons.save_rounded,
              onPressed: _isSaving ? () {} : () => _handleSubmit(false),
              isLoading: _isSaving && !_isPublished,
              isDisabled: _isSaving,
            ),
          ),
          SizedBox(width: s.paddingMd),

          // Publish Button
          Expanded(
            child: CustomButton(
              height: 50,
              tittleText: 'Publish',
              icon: Icons.rocket_launch_rounded,
              onPressed: _isSaving ? () {} : () => _handleSubmit(true),
              isLoading: _isSaving && _isPublished,
              isDisabled: _isSaving,
            ),
          ),
        ],
      ),
    );
  }

  /// Handle Form Submit
  Future<void> _handleSubmit(bool publish) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Validate platforms
    if (_platforms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one platform'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Validate tech stack
    if (_techStack.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one technology'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    // Create project entity
    final project = Project(
      id: widget.existingProject?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      tagline: _taglineController.text.trim(),
      category: _category,
      imagePath: _imagePath,
      description: _descriptionController.text.trim(),
      platforms: _platforms,
      techStack: _techStack,
      clientName: _clientNameController.text.trim(),
      launchDate: _launchDateController.text.trim(),
      challenge: _challengeController.text.trim(),
      requirements: _requirementsController.text.trim(),
      constraints: _constraintsController.text.trim(),
      solution: _solutionController.text.trim(),
      keyFeatures: _keyFeatures,
      results: _results,
      clientTestimonial: _testimonialController.text.trim(),
      galleryImages: _galleryImages,
      demoVideoUrl: _demoVideoUrlController.text.trim(),
      liveUrl: _liveUrlController.text.trim().isEmpty ? null : _liveUrlController.text.trim(),
      appStoreUrl: _appStoreUrlController.text.trim().isEmpty ? null : _appStoreUrlController.text.trim(),
      playStoreUrl: _playStoreUrlController.text.trim().isEmpty ? null : _playStoreUrlController.text.trim(),
      githubUrl: _githubUrlController.text.trim(),
      createdAt: widget.existingProject?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      isPublished: publish,
      isFeatured: _isFeatured,
      viewCount: widget.existingProject?.viewCount ?? 0,
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSaving = false);

    // Call parent callback
    widget.onSave(project, publish);
  }
}

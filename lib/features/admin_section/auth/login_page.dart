import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/admin_auth_provider.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import '../../../common_function/widgets/custom_text_field.dart';
import 'package:portfolio/utility/snack_bar_toast/snack_bar.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkExistingSession();
    });
  }

  Future<void> _checkExistingSession() async {
    final authProvider = context.read<AdminAuthProvider>();
    final status = await authProvider.checkSession();
    if (status && mounted) {
      context.go('/admin/dashboard');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AdminAuthProvider>();
    final result = await authProvider.login(_usernameController.text, _passwordController.text);

    // Handle the DataState result
    if (!mounted) return;
    result.when(
      success: (adminData) => context.pushReplacement('/admin/dashboard'),
      error: (errorMessage) => DSnackBar.error(title: errorMessage),
      initial: () {},
      loading: () {},
      empty: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final authProvider = context.watch<AdminAuthProvider>();

    return Scaffold(
      backgroundColor: DColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              elevation: 8,
              color: DColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                side: BorderSide(color: DColors.cardBorder),
              ),
              child: Padding(
                padding: EdgeInsets.all(s.paddingXl),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo/Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.admin_panel_settings_rounded, size: 48, color: DColors.primaryButton),
                      ),
                      SizedBox(height: s.paddingLg),

                      // Title
                      Text('Admin Panel', style: context.fonts.displaySmall),
                      SizedBox(height: s.paddingSm),

                      // Sub-Title
                      Text(
                        'Sign in to manage your portfolio',
                        style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: s.paddingXl),

                      // Username Field
                      CustomTextField(
                        controller: _usernameController,
                        label: 'Username',
                        borderRadius: s.borderRadiusMd,
                        useInlineLabel: true,
                        hint: 'Enter your username',
                        prefixIcon: Icon(Icons.person_rounded, color: DColors.textSecondary),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: s.paddingMd),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        useInlineLabel: true,
                        hint: 'Enter your username',
                        borderRadius: s.borderRadiusMd,
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_rounded, color: DColors.textSecondary),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: s.paddingMd),

                      // Error Message form server side
                      if (authProvider.errorMessage != null)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(s.paddingMd),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(s.borderRadiusSm),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline_rounded, color: Colors.red, size: 20),
                              SizedBox(width: s.paddingSm),
                              Expanded(
                                child: Text(
                                  authProvider.errorMessage!,
                                  style: context.fonts.bodySmall.rubik(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: s.paddingLg),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DColors.primaryButton,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: DColors.primaryButton.withAlpha((255 * 0.6).round()),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusMd)),
                          ),
                          child: authProvider.isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text('Sign In', style: context.fonts.bodyLarge.rubik(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: s.paddingLg),

                      // Back to Home
                      TextButton.icon(
                        onPressed: () => context.go('/'),
                        icon: Icon(Icons.arrow_back_rounded, size: 24),
                        label: Text('Back to Home'),
                        style: TextButton.styleFrom(foregroundColor: DColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/admin_auth_provider.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AdminAuthProvider>();

    final success = await authProvider.login(_usernameController.text, _passwordController.text);

    if (success && mounted) {
      // Navigate to admin dashboard
      context.go('/admin/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final authProvider = context.watch<AdminAuthProvider>();

    return Scaffold(
      backgroundColor: DColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(s.paddingLg),
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
                padding: EdgeInsets.all(s.paddingXl * 2),
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
                        child: Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 48,
                          color: DColors.primaryButton,
                        ),
                      ),
                      SizedBox(height: s.paddingLg),

                      // Title
                      Text(
                        'Admin Panel',
                        style: context.fonts.displaySmall.rajdhani(
                          fontWeight: FontWeight.bold,
                          color: DColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: s.paddingSm),
                      Text(
                        'Sign in to manage your portfolio',
                        style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: s.paddingXl),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: DColors.textSecondary),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: DColors.textSecondary),
                          prefixIcon: Icon(Icons.person_rounded, color: DColors.textSecondary),
                          filled: true,
                          fillColor: DColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.cardBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.cardBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.primaryButton, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: s.paddingMd),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: DColors.textSecondary),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: DColors.textSecondary),
                          prefixIcon: Icon(Icons.lock_rounded, color: DColors.textSecondary),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: DColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          filled: true,
                          fillColor: DColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.cardBorder),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.cardBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: DColors.primaryButton, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                        ),
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

                      // Error Message
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
                          onPressed: authProvider.isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DColors.primaryButton,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: DColors.primaryButton.withAlpha((255 * 0.6).round()),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(s.borderRadiusMd),
                            ),
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
                              : Text(
                                  'Sign In',
                                  style: context.fonts.bodyLarge.rubik(fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(height: s.paddingLg),

                      // Back to Home
                      TextButton.icon(
                        onPressed: () => context.go('/'),
                        icon: Icon(Icons.arrow_back_rounded, size: 18),
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

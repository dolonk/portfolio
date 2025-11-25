// TextFormField(
// controller: _usernameController,
// style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary),
// decoration: InputDecoration(
// labelText: 'Username',
// labelStyle: TextStyle(color: DColors.textSecondary),
// hintText: 'Enter your username',
// hintStyle: TextStyle(color: DColors.textSecondary),
// prefixIcon: Icon(Icons.person_rounded, color: DColors.textSecondary),
// filled: true,
// fillColor: DColors.background,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(s.borderRadiusMd),
// borderSide: BorderSide(color: DColors.cardBorder),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(s.borderRadiusMd),
// borderSide: BorderSide(color: DColors.cardBorder),
// ),
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(s.borderRadiusMd),
// borderSide: BorderSide(color: DColors.primaryButton, width: 2),
// ),
// errorBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(s.borderRadiusMd),
// borderSide: BorderSide(color: Colors.red.shade400),
// ),
// ),
// validator: (value) {
// if (value == null || value.trim().isEmpty) {
// return 'Please enter username';
// }
// return null;
// },
// )
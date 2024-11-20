import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/core/theme/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: AppColors.primaryLight,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bienvenue sur notre application',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.dark.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Phone input field with country code selector
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Country code dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.primaryLight.withOpacity(0.3)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.selectedCountryCode.value,
                                items: controller.countryCodes
                                    .map((code) => DropdownMenuItem(
                                  value: code,
                                  child: Text(
                                    code,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedCountryCode.value = value!;
                                },
                                icon: Icon(Icons.arrow_drop_down,
                                    color: AppColors.primaryLight),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Phone number input field
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: controller.phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Numéro de téléphone',
                                  labelStyle: TextStyle(
                                      color: AppColors.primaryLight),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryLight
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryLight,
                                        width: 2),
                                  ),
                                  prefixIcon: Icon(Icons.phone,
                                      color: AppColors.dark),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    color: AppColors.dark, fontSize: 16),
                                validator: (value) {
                                  return controller.validatePhoneNumber(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.handleLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Suivant',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Google Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.googleSignIn();
                        },
                        icon: Icon(Icons.email,
                            color: AppColors.primaryBackground),
                        label: Text(
                          'Se connecter avec Gmail',
                          style:
                          TextStyle(color: AppColors.primaryBackground),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Facebook Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.facebookSignIn();
                        },
                        icon: Icon(Icons.facebook,
                            color: AppColors.primaryBackground),
                        label: Text(
                          'Se connecter avec Facebook',
                          style:
                          TextStyle(color: AppColors.primaryBackground),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/inscription');
                        },
                        child: Text(
                          "S'inscrire ici",
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

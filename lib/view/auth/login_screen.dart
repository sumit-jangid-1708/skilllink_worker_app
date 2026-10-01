import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../../view_models/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController _phoneController = TextEditingController();
  final RxBool otpSent = false.obs;
  final RxString phoneNumber = ''.obs;
  final RxInt countdown = 28.obs;

  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
  List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Listen for successful OTP send to transition UI
    ever(authController.sendOtpModel, (model) {
      if (model != null) {
        otpSent.value = true;
        startCountdown();
      }
    });

    // Listen for successful verification to navigate to Dashboard
    ever(authController.verifyOtpModel, (model) {
      if (model != null) {
        // Get.offAll(() =>  DashboardScreen());
        Utils.successToast("Login Successful");
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    for (var c in otpControllers) c.dispose();
    for (var f in otpFocusNodes) f.dispose();
    super.dispose();
  }

  void startCountdown() {
    countdown.value = 28;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (countdown.value > 0) {
        countdown.value--;
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ── BLUE TOP SECTION ──
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.3,
                        child: Stack(
                          children: [
                            Positioned(
                              right: -40,
                              top: 20,
                              child: CircleAvatar(
                                radius: 90,
                                backgroundColor: Colors.white.withOpacity(0.08),
                              ),
                            ),
                            Positioned(
                              right: 30,
                              top: 100,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white.withOpacity(0.06),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome\nBack!",
                                    style: theme.textTheme.headlineLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Sign in with your phone number to continue",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── WHITE BOTTOM CARD ──
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Obx(() => otpSent.value
                              ? _buildOtpSection(context)
                              : _buildPhoneSection(context)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhoneSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "Phone Number",
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Text(
                    "+91",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: Obx(() => FilledButton(
            onPressed: authController.isLoading.value
                ? null
                : () {
              if (_phoneController.text.length == 10) {
                phoneNumber.value = _phoneController.text;
                authController.sendOtp(_phoneController.text);
              } else {
                Get.snackbar(
                  'Invalid Number',
                  'Please enter a valid 10-digit phone number.',
                  backgroundColor: colorScheme.errorContainer,
                  colorText: colorScheme.onErrorContainer,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                );
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: authController.isLoading.value
                ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            )
                : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Send OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          )),
        ),

        const Spacer(),

        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
              children: [
                const TextSpan(text: "By continuing, you agree to our "),
                TextSpan(
                  text: "Terms",
                  style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOtpSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              Text(
                "Verification Code",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  children: [
                    const TextSpan(text: "Enter the code sent to "),
                    TextSpan(
                      text: "+91 ${phoneNumber.value}",
                      style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) => _buildOtpBox(context, index)),
        ),

        const SizedBox(height: 32),

        Center(
          child: Column(
            children: [
              Obx(() => TextButton(
                onPressed: (countdown.value > 0 || authController.isLoading.value) ? null : () {
                  authController.sendOtp(phoneNumber.value);
                },
                child: Text(
                  countdown.value > 0
                      ? "Resend code in 00:${countdown.value.toString().padLeft(2, '0')}"
                      : "Resend Code",
                  style: TextStyle(
                    color: (countdown.value > 0 || authController.isLoading.value) ? colorScheme.onSurfaceVariant : colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ],
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: Obx(() => FilledButton(
            onPressed: authController.isLoading.value ? null : () {
              String otp = otpControllers.map((e) => e.text).join();
              if (otp.length == 6) {
                authController.verifyOtp(phoneNumber.value, otp);
              } else {
                Utils.snackBar("Invalid OTP", "Please enter the 6-digit verification code.");
              }
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: authController.isLoading.value
                ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            )
                : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify & Continue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(Icons.check_circle_outline, size: 20),
              ],
            ),
          )),
        ),

        TextButton(
          onPressed: authController.isLoading.value ? null : () {
            otpSent.value = false;
            authController.sendOtpModel.value = null; // Clear previous state
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            "Change Phone Number",
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),

        const Spacer(),

        Center(
          child: Text(
            "SkillLink Secure Verification",
            style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOtpBox(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: (MediaQuery.of(context).size.width - 48 - 40) / 6,
      child: TextField(
        controller: otpControllers[index],
        focusNode: otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

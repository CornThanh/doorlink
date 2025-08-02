import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreenWidget extends StatelessWidget {
  const OnboardingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // viền ngoài là màu đen
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              // 📱 Image (vector art)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/onboarding_image.png', // thay bằng đúng path ảnh bạn có
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 🔤 Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'DoorLink',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Connect!',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\nHere!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'DoorLink Connect (DLC) is a mobile-first platform with future support for physical QR/NFC devices',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 👉 Arrow Button
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => context.pushNamed('login_screen'),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade900,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

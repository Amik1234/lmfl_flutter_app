import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Страница контактов
/// Конвертировано из Android ContactsFragment.kt
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundColor,
            AppColors.primarySurfaceColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Иконка с градиентом
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: AppColors.cardShadow,
                ),
                child: const Icon(
                  Icons.contact_mail_outlined,
                  size: 64,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Контакты ЛМФЛ',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              Text(
                'Свяжитесь с организаторами лиги',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.25,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Карточки контактов
              _buildContactCard(
                icon: Icons.phone_outlined,
                title: 'Телефон',
                subtitle: 'Звоните в рабочее время',
                gradient: AppColors.primaryGradient,
              ),
              const SizedBox(height: 16),
              
              _buildContactCard(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'Пишите нам на почту',
                gradient: AppColors.accentGradient,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required LinearGradient gradient,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          ),
          
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              size: 64,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 16),
            Text(
              'Контакты ЛМФЛ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Свяжитесь с нами',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
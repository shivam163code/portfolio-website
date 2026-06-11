import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../utils/url_launcher_utils.dart';

class PortfolioFooter extends StatelessWidget {
  final Function(String) onNavTap;

  const PortfolioFooter({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightCard,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildBrand(context)),
              Expanded(flex: 2, child: _buildQuickLinks(context)),
              Expanded(flex: 2, child: _buildContact(context)),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Made with ',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Icon(Icons.favorite, size: 14, color: AppColors.accent),
                  Text(
                    ' using Flutter',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: AppColors.primaryGradient),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'SK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppConstants.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.shortTitle,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Building beautiful Flutter apps\nthat make a difference.',
          style: GoogleFonts.inter(
            fontSize: 13,
            height: 1.6,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, AppConstants.githubUrl),
            const SizedBox(width: 10),
            _buildSocialIcon(
                FontAwesomeIcons.linkedin, AppConstants.linkedinUrl),
            const SizedBox(width: 10),
            _buildSocialIcon(Icons.email_outlined,
                'mailto:${AppConstants.email}'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        ...AppConstants.navItems.map((item) => _buildFooterLink(
              context,
              item,
              () => onNavTap(item.toLowerCase()),
            )),
      ],
    );
  }

  Widget _buildContact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactRow(context, Icons.email_outlined, AppConstants.email),
        const SizedBox(height: 8),
        _buildContactRow(context, Icons.phone_outlined, AppConstants.phone),
        const SizedBox(height: 8),
        _buildContactRow(
            context, Icons.location_on_outlined, AppConstants.location),
        const SizedBox(height: 8),
        _buildContactRow(
            context, Icons.school_outlined, AppConstants.college),
      ],
    );
  }

  Widget _buildFooterLink(
      BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const Icon(Icons.chevron_right,
                size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(
      BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(dynamic icon, String url) {
    return GestureDetector(
      onTap: () => UrlLauncherUtils.openUrl(url),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Center(
          child: icon is IconData
              ? Icon(icon, size: 15, color: AppColors.primary)
              : FaIcon(icon as IconData, size: 13, color: AppColors.primary),
        ),
      ),
    );
  }
}

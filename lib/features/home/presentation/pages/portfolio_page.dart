import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/back_to_top_button.dart';
import '../../../../core/widgets/footer.dart';
import '../../../../core/widgets/navbar.dart';
import '../../../../core/widgets/scroll_progress_indicator.dart';
import '../../../about/presentation/bloc/about_bloc.dart';
import '../../../about/presentation/widgets/about_section.dart';
import '../../../certificates/presentation/bloc/certificate_bloc.dart';
import '../../../certificates/presentation/widgets/certificates_section.dart';
import '../../../contact/presentation/bloc/contact_bloc.dart';
import '../../../contact/presentation/widgets/contact_section.dart';
import '../../../education/presentation/bloc/education_bloc.dart';
import '../../../education/presentation/widgets/education_section.dart';
import '../../../experience/presentation/bloc/experience_bloc.dart';
import '../../../experience/presentation/widgets/experience_section.dart';
import '../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../projects/presentation/widgets/projects_section.dart';
import '../../../resume/presentation/bloc/resume_bloc.dart' hide DownloadResume;
import '../../../resume/presentation/widgets/resume_section.dart';
import '../../../skills/presentation/bloc/skills_bloc.dart';
import '../../../skills/presentation/widgets/skills_section.dart';
import '../bloc/home_bloc.dart' show HomeBloc, LoadHomeData, DownloadResume;
import '../widgets/hero_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'home';

  // Section keys for scroll-to navigation
  final Map<String, GlobalKey> _sectionKeys = {
    AppConstants.sectionHome: GlobalKey(),
    AppConstants.sectionAbout: GlobalKey(),
    AppConstants.sectionSkills: GlobalKey(),
    AppConstants.sectionProjects: GlobalKey(),
    AppConstants.sectionEducation: GlobalKey(),
    AppConstants.sectionCertificates: GlobalKey(),
    AppConstants.sectionExperience: GlobalKey(),
    AppConstants.sectionResume: GlobalKey(),
    AppConstants.sectionContact: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
    context.read<HomeBloc>().add(const LoadHomeData());
  }

  void _updateActiveSection() {
    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      if (key.currentContext != null) {
        final box = key.currentContext!.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          final height = box.size.height;
          if (pos.dy <= 150 && pos.dy + height > 150) {
            if (_activeSection != entry.key) {
              setState(() => _activeSection = entry.key);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Add top padding for navbar
                SizedBox(
                  key: _sectionKeys[AppConstants.sectionHome],
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      HeroSection(
                        onContactTap: () =>
                            _scrollToSection(AppConstants.sectionContact),
                        onResumeTap: () => context
                            .read<HomeBloc>()
                            .add(const DownloadResume()),
                      ),
                    ],
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionAbout],
                  child: BlocProvider(
                    create: (_) => AboutBloc(),
                    child: const AboutSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionSkills],
                  child: BlocProvider(
                    create: (_) => SkillsBloc(),
                    child: const SkillsSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionProjects],
                  child: BlocProvider(
                    create: (_) => ProjectsBloc(),
                    child: const ProjectsSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionEducation],
                  child: BlocProvider(
                    create: (_) => EducationBloc(),
                    child: const EducationSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionCertificates],
                  child: BlocProvider(
                    create: (_) => CertificateBloc(),
                    child: const CertificatesSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionExperience],
                  child: BlocProvider(
                    create: (_) => ExperienceBloc(),
                    child: const ExperienceSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionResume],
                  child: BlocProvider(
                    create: (_) => ResumeBloc(),
                    child: const ResumeSection(),
                  ),
                ),
                Container(
                  key: _sectionKeys[AppConstants.sectionContact],
                  child: BlocProvider(
                    create: (_) => ContactBloc(),
                    child: const ContactSection(),
                  ),
                ),
                PortfolioFooter(onNavTap: _scrollToSection),
              ],
            ),
          ),
          // Scroll progress indicator
          ScrollProgressIndicatorWidget(
              scrollController: _scrollController),
          // Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              activeSection: _activeSection,
            ),
          ),
          // Back to top button
          Positioned(
            bottom: 32,
            right: 32,
            child: BackToTopButton(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}

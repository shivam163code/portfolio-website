import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/section_title.dart';
import '../../data/models/project_model.dart';
import '../bloc/projects_bloc.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state is ProjectsInitial) {
          context.read<ProjectsBloc>().add(const LoadProjects());
        }
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, ProjectsState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.horizontalPadding(context),
        vertical: ResponsiveUtils.sectionVerticalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'My Projects',
            subtitle: 'PORTFOLIO',
          ),
          const SizedBox(height: 40),
          if (state is ProjectsLoaded) ...[
            _buildFilterChips(context, state),
            const SizedBox(height: 40),
            _buildProjectsGrid(context, state.filteredProjects),
          ] else if (state is ProjectsLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, ProjectsLoaded state) {
    final categories = ['All', 'Mobile App', 'Web App', 'Business', 'Education', 'Coming Soon'];

    return FadeInDown(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: categories.map((cat) {
          final isActive = state.activeFilter == cat;
          return _FilterChip(
            label: cat,
            isActive: isActive,
            onTap: () =>
                context.read<ProjectsBloc>().add(FilterProjects(cat)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<ProjectModel> projects) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: isMobile ? 1.2 : 0.85,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: _ProjectCard(project: projects[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: widget.isActive
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: widget.isActive
                ? null
                : (_isHovered
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isActive
                  ? Colors.transparent
                  : (_isHovered
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.3)),
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: widget.isActive
                  ? Colors.white
                  : (_isHovered
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -8.0 : 0.0, 0),
        child: GlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Image.network(
                        widget.project.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) =>
                            _buildImagePlaceholder(),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return _buildImagePlaceholder();
                        },
                      ),
                    ),
                    if (widget.project.isFeatured)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: AppColors.primaryGradient),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Featured',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    // Category badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.project.category,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          widget.project.shortDescription,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tech chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.technologies
                            .take(3)
                            .map((tech) => _buildTechChip(tech))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: _ProjectActionButton(
                              icon: FontAwesomeIcons.github,
                              label: 'GitHub',
                              onTap: () => context
                                  .read<ProjectsBloc>()
                                  .add(OpenGithub(widget.project.githubUrl)),
                            ),
                          ),
                          if (widget.project.liveDemoUrl != null) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: _ProjectActionButton(
                                icon: Icons.open_in_new,
                                label: 'Live Demo',
                                isPrimary: true,
                                onTap: () => context
                                    .read<ProjectsBloc>()
                                    .add(OpenLiveDemo(
                                        widget.project.liveDemoUrl!)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        tech,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _ProjectActionButton extends StatefulWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ProjectActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  State<_ProjectActionButton> createState() => _ProjectActionButtonState();
}

class _ProjectActionButtonState extends State<_ProjectActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: (widget.isPrimary || _isHovered)
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: (widget.isPrimary || _isHovered)
                ? null
                : AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: (widget.isPrimary || _isHovered)
                  ? Colors.transparent
                  : AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon is IconData
                  ? Icon(
                      widget.icon as IconData,
                      size: 14,
                      color: (widget.isPrimary || _isHovered)
                          ? Colors.white
                          : AppColors.primary,
                    )
                  : FaIcon(
                      widget.icon as IconData,
                      size: 12,
                      color: (widget.isPrimary || _isHovered)
                          ? Colors.white
                          : AppColors.primary,
                    ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: (widget.isPrimary || _isHovered)
                      ? Colors.white
                      : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

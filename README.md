# Shivam Kumar — Flutter Developer Portfolio

A modern, professional, fully responsive portfolio website built with **Flutter Web**, following **Clean Architecture** and **BLoC State Management**.

## 🚀 Live Preview

Run locally:
```bash
flutter run -d chrome
```

Build for production:
```bash
flutter build web --release
```

---

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/         # AppColors, AppConstants, AppTextStyles
│   ├── theme/             # AppTheme (dark/light), ThemeCubit
│   ├── utils/             # ResponsiveUtils, UrlLauncherUtils
│   └── widgets/           # Reusable: GlassCard, Navbar, Footer, Buttons…
│
├── features/
│   ├── home/              # Hero section + HomeBloc
│   ├── about/             # About section + AboutBloc
│   ├── skills/            # Skills section + SkillsBloc
│   ├── projects/          # Projects + ProjectsBloc (with filtering)
│   ├── education/         # Education timeline + EducationBloc
│   ├── certificates/      # Certificates gallery + CertificateBloc
│   ├── experience/        # Experience timeline + ExperienceBloc
│   ├── resume/            # Resume preview/download + ResumeBloc
│   └── contact/           # Contact form + ContactBloc
│
└── main.dart
```

---

## ✨ Features

- ✅ **Dark / Light Theme** toggle with smooth animation
- ✅ **Fully Responsive** — Mobile, Tablet, Desktop
- ✅ **BLoC Pattern** — separate BLoC per feature
- ✅ **Clean Architecture** — modular, scalable, maintainable
- ✅ **Glassmorphism** cards and UI elements
- ✅ **Animated Hero Section** with rotating role titles
- ✅ **Skill Progress Bars** with animation
- ✅ **Project Filtering** by category
- ✅ **Education & Experience Timelines**
- ✅ **Certificate Gallery** with hover effects
- ✅ **Contact Form** with validation
- ✅ **Scroll Progress Indicator**
- ✅ **Back to Top Button**
- ✅ **SEO Optimized** index.html with Open Graph tags
- ✅ **Custom Loading Screen**
- ✅ **Social Links** — GitHub, LinkedIn, Email

---

## 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| Flutter Web | UI framework |
| Dart | Programming language |
| flutter_bloc | State management |
| google_fonts | Typography (Poppins, Inter) |
| animate_do | Scroll animations |
| flutter_animate | Complex animations |
| percent_indicator | Skill progress bars |
| timeline_tile | Education/Experience timeline |
| font_awesome_flutter | Social icons |
| url_launcher | External links |

---

## 📁 Customizing Data

All portfolio data is stored in-code as models — easy to update:

| Data | Location |
|---|---|
| Personal info | `lib/core/constants/app_constants.dart` |
| Projects | `lib/features/projects/presentation/bloc/projects_bloc.dart` |
| Education | `lib/features/education/presentation/bloc/education_bloc.dart` |
| Certificates | `lib/features/certificates/presentation/bloc/certificate_bloc.dart` |
| Experience | `lib/features/experience/presentation/bloc/experience_bloc.dart` |
| Skills | `lib/features/skills/presentation/bloc/skills_bloc.dart` |

---

## 📸 Adding Your Profile Photo

Replace the avatar initials in `hero_section.dart` and `about_section.dart` with:
```dart
Image.network('your-photo-url', fit: BoxFit.cover)
```
or use `Image.asset('assets/images/profile.jpg')` after adding to assets.

---

## 🌐 Deployment

### Firebase Hosting
```bash
flutter build web --release
firebase deploy
```

### GitHub Pages
```bash
flutter build web --release --base-href "/your-repo-name/"
# Copy build/web contents to gh-pages branch
```

### Vercel / Netlify
Upload the `build/web` folder directly.

---

## 👨‍💻 Developer

**Shivam Kumar**  
Flutter Developer | Mobile App Developer | Software Developer  
B.Tech CSE — CGC Jhanjeri (4th Year, 7th Semester)

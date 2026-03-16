// ============================================================
//  PORTFOLIO DATA — Edit everything here easily!
//  All your personal info, projects, and skills live here.
// ============================================================

class PortfolioData {
  // ── PERSONAL INFO ─────────────────────────────────────────
  static const String name = 'Wogood Wael';
  static const String title = 'Flutter Developer';
  static const String tagline =
      'Crafting production-ready apps for food delivery, e-commerce, healthcare & events';
  static const String about =
      'Flutter Developer with 2+ years of experience delivering production-ready '
      'apps for food delivery, e-commerce, healthcare, and events. '
      'Specialized in Flutter/Dart, API integration, and payment systems '
      '(Stripe, PayPal, MyFatoorah). Proven record of optimizing performance '
      '(20% faster load times) and ensuring seamless cross-platform user experiences '
      'on both iOS and Android.';

  static const String email = 'wogoodwael@gmail.com';
  static const String phone = '+201098489028';
  static const String location = 'Damietta, Egypt';
  static const String github = 'github.com/wogoodwael';
  static const String linkedin = 'linkedin.com/in/wogood-wael-695209241';
  static const String behance = 'behance.net/wogoodwael';
  static const String cvDownloadUrl = '';

  // ── SKILLS ────────────────────────────────────────────────
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Flutter & Dart',
      skills: [
        Skill('Flutter', 0.95),
        Skill('Dart', 0.93),
        Skill('UI/UX Design', 0.88),
        Skill('Figma', 0.82),
      ],
    ),
    SkillCategory(
      title: 'State Management',
      skills: [
        Skill('Bloc / Cubit', 0.90),
        Skill('GetX', 0.88),
        Skill('Provider', 0.80),
        Skill('Localization (Arabic)', 0.92),
      ],
    ),
    SkillCategory(
      title: 'Payments & APIs',
      skills: [
        Skill('REST APIs', 0.92),
        Skill('Stripe', 0.88),
        Skill('PayPal', 0.85),
        Skill('MyFatoorah', 0.82),
      ],
    ),
    SkillCategory(
      title: 'Tools & Databases',
      skills: [
        Skill('Git / GitHub', 0.92),
        Skill('Firebase / Firestore', 0.88),
        Skill('SQLite', 0.82),
        Skill('Debugging', 0.90),
      ],
    ),
  ];

  // ── PROJECTS ──────────────────────────────────────────────
  static const List<Project> projects = [
    Project(
      title: 'Delveria',
      description:
          'Cross-platform food ordering & delivery solution with real-time '
          'tracking. Boosted service efficiency by 30% and improved customer '
          'convenience significantly.',
      tags: ['Flutter', 'Real-time', 'Geolocation', 'REST API'],
      category: ProjectCategory.mobile,
      githubUrl: '',
      playStoreUrl: '',
      appStoreUrl: 'https://apps.apple.com/us/app/delveria/id6752578803',
      imageEmoji: '🍔',
      accentColorHex: 'FF6B35',
      featured: true,
    ),
    Project(
      title: 'RN Laundry',
      description:
          'Automated laundry management system with pickup & delivery scheduling. '
          'Increased service speed and customer satisfaction by 40%. '
          'Launched on the App Store.',
      tags: ['Flutter', 'Scheduling', 'Notifications', 'App Store'],
      category: ProjectCategory.mobile,
      githubUrl: '',
      playStoreUrl: '',
      appStoreUrl: 'https://apps.apple.com/eg/app/rn-laundry/id6751350212',
      imageEmoji: '👕',
      accentColorHex: '00D4FF',
      featured: true,
    ),
    Project(
      title: 'Yama Vet',
      description:
          'Veterinary clinic app with push notifications for 100+ pet owners, '
          'reducing missed appointments. Boosted clinic revenue by 25%.',
      tags: ['Flutter', 'Firebase', 'Push Notifications', 'GetX'],
      category: ProjectCategory.mobile,
      githubUrl: '',
      playStoreUrl: '',
      appStoreUrl: 'https://apps.apple.com/us/app/yama-vet/id6476448659',
      imageEmoji: '🐾',
      accentColorHex: '06D6A0',
      featured: true,
    ),
    Project(
      title: 'Sayink',
      description:
          'Technician app enabling customers to book, track, and communicate with service technicians in real-time. Features separate user and technician panels, integrated notifications, and robust job assignment workflows.',
      tags: ['Flutter', 'RestApi', 'Push Notifications', 'User/Technician', 'Bloc'],
      category: ProjectCategory.mobile,
      githubUrl: 'https://mega.nz/file/nNV3WYaS#NfCZpov0cvLJwyf9TQsFeTbuuNVEkDO4f3D6D5isusQ',
      playStoreUrl: '',
      appStoreUrl: '',
      imageEmoji: '🧑‍🔧',
      accentColorHex: '06D6A0',
      featured: false,
    ),
    Project(
      title: 'Qudorati',
      description:
          'E-learning app providing engaging educational content and interactive features, improving student performance and engagement for its users.',
      tags: ['Flutter', 'RestApi', 'E-learning', 'Bloc', 'Cubit'],
      category: ProjectCategory.mobile,
      githubUrl: 'https://mega.nz/file/iU0kAIBC#YAWdUVQ3TLc1dpx1E1zqS7kNNU-zQiYU9ue1X-qmyFA', // update to a plausible link
      playStoreUrl: '',
      appStoreUrl: '',
      imageEmoji: '📚',
      accentColorHex: '06D6A0',
      featured: false,
    ),
    Project(
      title: 'Payment Integration',
      description:
          'Integrated 10+ APIs including Stripe, PayPal, and MyFatoorah '
          'across multiple client apps. Reduced user payment issues by 25%.',
      tags: ['Stripe', 'PayPal', 'MyFatoorah', 'Flutter'],
      category: ProjectCategory.mobile,
      githubUrl: 'https://github.com/wogoodwael/headphone_payment.git',
      playStoreUrl: '',
      appStoreUrl: '',
      imageEmoji: '💳',
      accentColorHex: 'FFB703',
      featured: false,
    ),
    Project(
      title: 'Saudi Client Apps',
      description:
          'Developed and launched 3 apps for Saudi clients at Arab Optimism '
          'Foundation, ensuring full cross-platform compatibility and Arabic '
          'localization.',
      tags: ['Flutter', 'Localization', 'Arabic', 'Cross-platform'],
      category: ProjectCategory.mobile,
      githubUrl: 'https://github.com/wogoodwael/sudia_events.git',
      playStoreUrl: '',
      appStoreUrl: '',
      imageEmoji: '🗓️',
      accentColorHex: '7C3AED',
      featured: false,
    ),
  ];

  // ── EXPERIENCE ────────────────────────────────────────────
  static const List<Experience> experiences = [
    Experience(
      company: 'Freelance',
      role: 'Flutter Developer',
      period: 'Jul 2022 – Present',
      description:
          'Delivered 5+ scalable apps for international clients with 100% '
          'on-time delivery. Integrated 10+ APIs (Stripe, PayPal, geolocation, '
          'notifications), reducing user issues by 25%. Built cross-platform '
          'solutions for iOS & Android.',
    ),
    Experience(
      company: 'CodeCept',
      role: 'Flutter Developer',
      period: 'Mar 2025 – Jan 2026',
      description:
          'Built and deployed car washing app, E-learning app, and barber app from concept to App Store launch.',
    ),
    Experience(
      company: 'EgronX',
      role: 'Flutter Developer & Instructor',
      period: 'Jun 2025 – Oct 2025',
      description:
          'Built and deployed RN Laundry app from concept to App Store launch. '
          'Trained 30+ students in Flutter, Dart, and UI/UX best practices.',
    ),
    Experience(
      company: 'Arab Optimism Foundation',
      role: 'Flutter Developer',
      period: 'Sep 2024 – Mar 2025',
      description:
          'Developed and launched 3 apps for Saudi clients, ensuring '
          'cross-platform compatibility and full Arabic localization.',
    ),
  ];

  // ── CERTIFICATES ──────────────────────────────────────────
  static const List<Certificate> certificates = [
    Certificate(
      title: 'Flutter Development',
      issuer: 'ITI',
      year: '2022',
    ),
    Certificate(
      title: 'Flutter Payments Integration (Stripe, PayPal)',
      issuer: 'Udemy',
      year: '2025',
    ),
    Certificate(
      title: 'Mobile App Design in Figma',
      issuer: 'Udemy',
      year: '2025',
    ),
    Certificate(
      title: 'Java Level 1 & 2',
      issuer: 'IEEE – Al-Azhar University',
      year: '2021',
    ),
  ];

  // ── LANGUAGES ─────────────────────────────────────────────
  static const List<Language> languages = [
    Language('Arabic', 'Native'),
    Language('English', 'Conversational'),
    Language('Hindi', 'Basic'),
    Language('Urdu', 'Basic'),
  ];

  // ── EDUCATION ─────────────────────────────────────────────
  static const String university = 'Al-Azhar University';
  static const String degree = 'B.Sc. Software Engineering';
  static const String eduPeriod = '2019 – 2024';
  static const String eduLocation = 'Cairo, Egypt';
}

// ── DATA MODELS ───────────────────────────────────────────────

class SkillCategory {
  final String title;
  final List<Skill> skills;
  const SkillCategory({required this.title, required this.skills});
}

class Skill {
  final String name;
  final double level; // 0.0 – 1.0
  const Skill(this.name, this.level);
}

enum ProjectCategory { mobile, web, desktop, package }

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final ProjectCategory category;
  final String githubUrl;
  final String playStoreUrl;
  final String appStoreUrl;
  final String imageEmoji;
  final String accentColorHex;
  final bool featured;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.category,
    required this.githubUrl,
    required this.playStoreUrl,
    required this.appStoreUrl,
    required this.imageEmoji,
    required this.accentColorHex,
    required this.featured,
  });
}

class Experience {
  final String company;
  final String role;
  final String period;
  final String description;
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
  });
}

class Certificate {
  final String title;
  final String issuer;
  final String year;
  const Certificate({
    required this.title,
    required this.issuer,
    required this.year,
  });
}

class Language {
  final String name;
  final String level;
  const Language(this.name, this.level);
}

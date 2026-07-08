class Info {
  static const name         = 'Hamza Sattar';
  static const role         = 'Flutter Developer';
  static const age          = '22 Years';
  static const location     = 'Pakistan';
  static const experience   = '1+ Years';
  static const availability = 'Full-time';
  static const email        = 'hamzasattar849@gmail.com';
  static const phone        = '03155030161';
  static const about1 =
      "I'm Hamza Sattar, a passionate 22-year-old Flutter Developer "
      "dedicated to creating beautiful, functional, and user-friendly mobile "
      "applications. With a strong foundation in Dart and Flutter framework, "
      "I specialize in building cross-platform apps that deliver exceptional "
      "user experiences.";
  static const about2 =
      "I enjoy untangling difficult problems to ensure that every app I build "
      "is fast, reliable, and easy for people to use. My goal is to transform "
      "ideas into reality through clean code and innovative solutions.";
  static const statExp           = '1+';
  static const statProjects      = '10+';
  static const statContributions = '80+';
}

class Links {
  static const github    = 'https://github.com/hamzasattar849';
  static const linkedin  = 'https://www.linkedin.com/in/hamza-sattar-886169362?utm_source=share_via&utm_content=profile&utm_medium=member_android';
  static const instagram = 'https://www.instagram.com/h_a_m_z_a_679';
  static const facebook  = 'https://www.facebook.com';
  static const emailUrl  = 'mailto:hamzasattar849@gmail.com';
  static const phoneUrl  = 'tel:+923155030161';

  // CV — raw GitHub image URL so it opens/downloads directly
  static const cvDirect =
      'https://raw.githubusercontent.com/hamza2348/CV1/main/cv.png';
}

class Skill {
  final String name;
  final int percent;
  final double value;
  const Skill(this.name, this.percent, this.value);
}

const kSkills = [
  Skill('Flutter',      95, 0.95),
  Skill('Dart',         90, 0.90),
  Skill('Firebase',     85, 0.85),
  Skill('UI/UX Design', 80, 0.80),
  Skill('REST APIs',    75, 0.75),
  Skill('Git & GitHub', 70, 0.70),
];

class Service {
  final String title, desc;
  const Service(this.title, this.desc);
}

const kServices = [
  Service('Flutter App Development',
      'Cross-platform mobile applications built with Flutter for iOS and Android with stunning UI/UX.'),
  Service('Dart Programming',
      'Clean, efficient, and maintainable Dart code following best practices and design patterns.'),
  Service('UI/UX Design',
      'Beautiful and intuitive user interfaces designed with user experience as the top priority.'),
  Service('Backend Integration',
      'Seamless integration with Firebase, REST APIs, and third-party services.'),
  Service('App Maintenance',
      'Regular updates, bug fixes, and performance optimization for existing applications.'),
  Service('API Development',
      'Custom API design and integration to power your mobile applications.'),
];

class Project {
  final String title, desc, github;
  final List<String> tech;
  final int color;
  final bool imageOnLeft;
  const Project({required this.title, required this.desc, required this.github,
      required this.tech, required this.color, required this.imageOnLeft});
}

const kProjects = [
  Project(
    title: 'Calculator App',
    desc: 'A sleek, gesture-driven calculator with a minimalist UI and fluid '
        'Flutter animations. Features scientific calculations, history tracking, '
        'and customizable themes.',
    tech: ['Flutter', 'Dart', 'Material Design'],
    color: 0xFF3B82F6,
    github: 'https://www.linkedin.com/in/hamza-sattar-886169362?utm_source=share_via&utm_content=profile&utm_medium=member_android',
    imageOnLeft: true,
  ),
  Project(
    title: 'Calendar & Scheduler App',
    desc: 'A comprehensive calendar and task management application with event '
        'scheduling, reminders, and intuitive drag-and-drop functionality.',
    tech: ['Flutter', 'Firebase', 'State Management'],
    color: 0xFF8B5CF6,
    github: 'https://www.linkedin.com/in/hamza-sattar-886169362?utm_source=share_via&utm_content=profile&utm_medium=member_android',
    imageOnLeft: false,
  ),
];

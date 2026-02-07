class HebrewDateParts {
  const HebrewDateParts({
    required this.dayNumber,
    required this.dayHebrew,
    required this.monthHebrew,
    required this.yearNumber,
    required this.yearHebrew,
  });

  final int dayNumber;
  final String dayHebrew;
  final String monthHebrew;
  final int yearNumber;
  final String yearHebrew;

  String get shortLabel => '$dayHebrew ב$monthHebrew';
  String get fullLabel => '$dayHebrew ב$monthHebrew $yearHebrew';
}

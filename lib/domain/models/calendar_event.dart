/// DTO for a calendar event to be cached or displayed.
class CalendarEventDto {
  const CalendarEventDto({
    required this.layerId,
    required this.date,
    required this.title,
    required this.sourceKey,
    this.details = '',
    this.allDay = true,
    this.startTime,
    this.endTime,
    this.importance = 0,
  });

  final String layerId;
  final String date; // YYYY-MM-DD
  final String title;
  final String sourceKey;
  final String details;
  final bool allDay;
  final String? startTime;
  final String? endTime;
  final int importance;
}

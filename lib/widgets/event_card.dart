import 'package:club_events/widgets/heart_button.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';
import '../screens/event_detail_screen.dart';

String _formatDate(DateTime startDate, DateTime endDate) {
    DateTime now = DateTime.now();

    if (startDate.isBefore(now) && endDate.isAfter(now)) {
      return 'Today';
    } else if (startDate.isAfter(now) && startDate.isBefore(now.add(Duration(days: 1)))) {
      return 'Tomorrow';
    } else {
      return '${startDate.toString().split(' ')[0].split('-')[2]} ${_getMonth(startDate.month)}';
    }
  }

String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

void toggleFavorite(Event event){
  event.isFavorite = !event.isFavorite;
  event.save();
}

class EventCard extends StatefulWidget {
  final Event event;
  final bool isPast;

  const EventCard({Key? key, required this.event, required this.isPast}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: widget.event, toggleFavorite: () => toggleFavorite(widget.event)),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _formatDate(widget.event.startDate, widget.event.endDate),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.event.title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.event.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.8),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                spacing: 8,
                children: [
                  Icon(
                    widget.isPast ? Icons.lock_outline : Icons.people_outline,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  Text(
                    widget.isPast ? 'Event Ended' : 'Open to All',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  HeartButton(
                    isFavorite: widget.event.isFavorite,
                    size: 24,
                    onPressed: () {
                      setState(() {
                        toggleFavorite(widget.event);
                      });
                    },
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

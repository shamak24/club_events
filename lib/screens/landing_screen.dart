import 'package:flutter/material.dart';
import '../models/model.dart';
import 'event_detail_screen.dart';
import './add_event_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference < 7) {
      return '${date.toString().split(' ')[0].split('-')[2]} ${_getMonth(date.month)}';
    } else {
      return '${date.toString().split(' ')[0].split('-')[2]} ${_getMonth(date.month)}';
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  final List<Event> mockEvents = [
    Event(
      title: 'Flutter Workshop',
      date: DateTime.now().add(const Duration(days: 2)),
      description: 'Learn Flutter basics and build your first app',
    ),
    Event(
      title: 'Tech Meetup',
      date: DateTime.now().add(const Duration(days: 5)),
      description: 'Monthly tech community meetup with guest speakers',
    ),
    Event(
      title: 'Coding Competition',
      date: DateTime.now().add(const Duration(days: 7)),
      description: 'Competitive programming contest with prizes',
    ),
    Event(
      title: 'Mobile App Design Workshop',
      date: DateTime.now().add(const Duration(days: 10)),
      description: 'Learn UI/UX principles for mobile applications',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Club Events',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon')),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text(
              'Upcoming Events',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: mockEvents.length,
              itemBuilder: (context, index) {
                final event = mockEvents[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // TODO: Navigate to event details
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(event: event),
                      ));
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
                                  _formatDate(event.date),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            event.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            event.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onBackground.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Open for all',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to add event screen
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const AddEventScreen(),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Event'),
        elevation: 2,
      ),
    );
  }
}
    
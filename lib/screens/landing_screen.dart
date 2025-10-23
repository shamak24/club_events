import 'package:club_events/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import './add_event_screen.dart';
import '../widgets/event_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/events_provider.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, child) {
        DateTime now = DateTime.now();
        final events = ref.watch(eventListProvider);
        final eventProvider = ref.read(eventListProvider.notifier);
        final upcomingEvents = events
            .where((event) => event.startDate.isAfter(now))
            .toList();
        final pastEvents = events
            .where((event) => event.endDate.isBefore(now) && !event.endDate.isAtSameMomentAs(now))
            .toList();
        final ongoingEvents = events
            .where((event) => event.startDate.isBefore(now) && (event.endDate.isAfter(now) || event.endDate.isAtSameMomentAs(now)))
            .toList();

        return Scaffold(
          backgroundColor: colorScheme.background,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Image.asset(
                      'assets/images/club_logo.png',
                      height: 35,
                      width: 35,
                    ),
                  ),
                ),
                const Text(
                  'moz://a Firefox Club',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            backgroundColor: colorScheme.primary,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.light_mode, color: Colors.black),
                onPressed: () {
                  // TODO: Implement theme switching
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: colorScheme.primary,
                      content: Text(
                        'Theme switching coming soon.',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text(
                    'Ongoing Events',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
                ongoingEvents.isEmpty
                    ? EmptyState(
                        message: 'No Ongoing events. Please check back later.',
                      )
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          scrollDirection: Axis.vertical,
                          itemCount: ongoingEvents.length,
                          itemBuilder: (context, index) {
                            final event = ongoingEvents[index];
                            return EventCard(event: event, isPast: false, toggleDelete: () {
                              eventProvider.deleteEvent(event.id);
                            });
                          },
                        ),
                      ),
                SizedBox(height: 5),
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
                upcomingEvents.isEmpty
                    ? EmptyState(
                        message: 'No upcoming events. Please check back later.',
                      )
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          scrollDirection: Axis.vertical,
                          itemCount: upcomingEvents.length,
                          itemBuilder: (context, index) {
                            final event = upcomingEvents[index];
                            return EventCard(event: event, isPast: false, toggleDelete: () {
                              eventProvider.deleteEvent(event.id);
                            });
                          },
                        ),
                      ),
                SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text(
                    'Past Events',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ),
                pastEvents.isEmpty
                    ? EmptyState(message: 'No past events.')
                    : Container(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          scrollDirection: Axis.vertical,
                          itemCount: pastEvents.length,
                          itemBuilder: (context, index) {
                            final event = pastEvents[index];
                            return EventCard(event: event, isPast: true, toggleDelete: () {
                              eventProvider.deleteEvent(event.id);
                            });
                          },
                        ),
                      ),
                        SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // Navigate to add event screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEventScreen()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Event'),
            elevation: 2,
          ),
        );
      },
    );
  }
}

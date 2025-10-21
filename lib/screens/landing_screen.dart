import 'package:club_events/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import './add_event_screen.dart';
import '../widgets/upcoming_event_card.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, child) {
        final events = ref.watch(eventListProvider);
        final upcomingEvents = events.where((event) => event.date.isAfter(DateTime.now())).toList();
        final pastEvents = events.where((event) => event.date.isBefore(DateTime.now())).toList();
        return Scaffold(
          backgroundColor: colorScheme.background,
          appBar: AppBar(
            centerTitle: true,
            title: SingleChildScrollView(
              child: Row(
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
            ),
            backgroundColor: colorScheme.primary,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.light_mode, color: Colors.black),
                onPressed: () {
                  // TODO: Implement theme switch
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Theme switch coming soon')),
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
              upcomingEvents.isEmpty
                  ? EmptyState(
                      message: 'No upcoming events. Please check back later.',
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: upcomingEvents.length,
                        itemBuilder: (context, index) {
                          final event = upcomingEvents[index];
                          return UpcomingEventCard(event: event);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
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
                  ? EmptyState(
                      message: 'No past events.',
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: pastEvents.length,
                        itemBuilder: (context, index) {
                          final event = pastEvents[index];
                          return UpcomingEventCard(event: event);
                        },
                      ),
                    ),
            ],
            
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
            label: const Text('Add Event'),
            elevation: 2,
          ),
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import '../models/model.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = (hour % 12 == 0) ? 12 : hour % 12;
    return '$formattedHour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  event.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: event.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _buildTimeAndDate(context, colorScheme, textTheme),
                  const SizedBox(height: 32),
                  _buildDescription(context, colorScheme, textTheme),
                  const SizedBox(height: 32),
                  _buildLocation(context, colorScheme, textTheme),
                  const SizedBox(height: 32),
                  _buildOrganizer(context, colorScheme, textTheme),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: colorScheme.primary,
        label: const Text('RSVP'),
        icon: const Icon(Icons.check_circle_outline),
      ),
    );
  }

  Widget _buildTimeAndDate(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                _formatDate(event.date),
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTime(event.date),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          event.description,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onBackground.withOpacity(0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              Text(
                'Club House, Main Building',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizer(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(Icons.people_outline, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organized by',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              Text(
                'Tech Club Committee',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
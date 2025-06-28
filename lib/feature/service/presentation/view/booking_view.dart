import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_event.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_state.dart';
import 'package:motofix_app/feature/service/presentation/view_model/booking_view_model.dart';
import '../../../../app/service_locator/service_locator.dart';

// BookingPage remains the same - it's already correct.
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<BookingViewModel>()
        ..add(LoadUserBookingsEvent()), // Initial event to load data
      child: const BookingView(),
    );
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: const Color(0xFF2A4759),
        elevation: 0,
      ),
      body: BlocConsumer<BookingViewModel, BookingState>(
        listener: (context, state) {
          if (state is BookingActionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green,));
          } else if (state is BookingFailure) {
            // The listener can still show a snackbar for any failure
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
          }
        },
        // Use buildWhen to prevent rebuilding on action success messages
        buildWhen: (previous, current) =>
        current is! BookingActionSuccess,
        builder: (context, state) {
          // Handle loading state
          if (state is BookingLoading || state is BookingInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          // Handle success state
          if (state is BookingLoadSuccess) {
            if (state.bookings.isEmpty) {
              return const Center(
                child: Text(
                  'No active bookings found.',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookingViewModel>().add(LoadUserBookingsEvent());
              },
              child: ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return _buildBookingItem(context, booking);
                },
              ),
            );
          }
          // IMPROVEMENT: Handle failure state directly in the builder
          if (state is BookingFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load bookings: ${state.error}', style: const TextStyle(color: Colors.white70),),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BookingViewModel>().add(LoadUserBookingsEvent());
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          // Fallback widget
          return const Center(child: Text("Something went wrong."));
        },
      ),
      // Floating Action Button for creating new bookings...
    );
  }

  Widget _buildBookingItem(BuildContext context, BookingEntity booking) {
    // Your item builder code remains the same...
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(booking.serviceType),
        subtitle: Text('${booking.bikeModel}\nStatus: ${booking.status}'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Your dialog logic remains the same...
          },
        ),
      ),
    );
  }
}
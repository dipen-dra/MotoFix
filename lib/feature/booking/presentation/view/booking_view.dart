// booking_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../domain/entity/booking_entity.dart';
import '../view_model/booking_event.dart';
import '../view_model/booking_view_model.dart';
import '../view_model/booking_state.dart';

// You can now delete the BookingPage widget, as it's redundant.
// class BookingPage extends StatelessWidget { ... }

// --- MODIFIED BookingView ---
class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  void initState() {
    super.initState();
    // Get the BLoC provided by MotoFixDashboard and tell it to load the data.
    // We check the state to avoid re-fetching if the user navigates away and back.
    // `IndexedStack` keeps the state, so this will only run once.
    final bookingViewModel = context.read<BookingViewModel>();
    if (bookingViewModel.state is BookingInitial) {
      bookingViewModel.add(LoadUserBookingsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: const Color(0xFF2A4759),
        elevation: 0,
      ),
      // The rest of your UI code remains exactly the same.
      body: BlocConsumer<BookingViewModel, BookingState>(
        listener: (context, state) {
          if (state is BookingLoadSuccess && state.successMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
              ));
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text(state.error), backgroundColor: Colors.yellow));
          }
        },
        buildWhen: (previous, current) => current is! BookingActionSuccess,
        builder: (context, state) {
          if (state is BookingLoading || state is BookingInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BookingLoadSuccess) {
            if (state.bookings.isEmpty) {
              return const Center(
                child: Text(
                  'No active bookings found.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BookingViewModel>().add(LoadUserBookingsEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return _buildBookingItem(context, booking);
                },
              ),
            );
          }
          if (state is BookingFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to load bookings: ${state.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<BookingViewModel>()
                            .add(LoadUserBookingsEvent());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("An unknown error occurred."));
        },
      ),
    );
  }

  Widget _buildBookingItem(BuildContext context, BookingEntity booking) {
    // This method remains unchanged.
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          booking.serviceType.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${booking.bikeModel}\nStatus: ${booking.status}',
          style: const TextStyle(height: 1.5),
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Confirm Deletion'),
                content:
                const Text('Are you sure you want to delete this booking?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                  TextButton(
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      context
                          .read<BookingViewModel>()
                          .add(DeleteBookingEvent(bookingId: booking.id.toString()));
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
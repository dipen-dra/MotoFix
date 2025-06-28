import 'package:bloc/bloc.dart';
import 'package:motofix_app/feature/service/domain/use_case/delete_user_bookings.dart';
import 'package:motofix_app/feature/service/domain/use_case/get_user_bookings.dart';

import '../../domain/use_case/create_user_bookings.dart';
import 'booking_event.dart';
import 'booking_state.dart';

// Renamed to BookingViewModel for community convention
class BookingViewModel extends Bloc<BookingEvent, BookingState> {
  // Depend on Use Cases instead of the Repository
  final GetUserBookings _getUserBookingsUseCase;
  final CreateBookingUseCase _createBookingUseCase; // 2. Add the use case as a dependency
  final DeleteBookingUsecase _deleteBookingUseCase;

  BookingViewModel({
    required GetUserBookings getUserBookingsUseCase,
    required CreateBookingUseCase createBookingUseCase, // 3. Inject the use case
    required DeleteBookingUsecase deleteBookingUseCase,
  })  : _getUserBookingsUseCase = getUserBookingsUseCase,
        _createBookingUseCase = createBookingUseCase,
        _deleteBookingUseCase = deleteBookingUseCase,
        super(BookingInitial()) {
    on<LoadUserBookingsEvent>(_onLoadUserBookings);
    on<CreateBookingEvent>(_onCreateBooking); // 4. Register the event handler
    on<DeleteBookingEvent>(_onDeleteBooking);
  }

  void _onLoadUserBookings(
      LoadUserBookingsEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(BookingLoading());
    final result = await _getUserBookingsUseCase();
    result.fold(
          (failure) => emit(BookingFailure(failure.message)),
          (bookings) => emit(BookingLoadSuccess(bookings)),
    );
  }

  // 5. Uncomment and implement the create booking handler
  void _onCreateBooking(
      CreateBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    // Convert the BookingEntity from the event into the params the use case needs
    final params = CreateBookingParams(
      customerName: event.booking.customerName,
      serviceType: event.booking.serviceType,
      bikeModel: event.booking.bikeModel,
      date: event.booking.date,
      notes: event.booking.notes,
      totalCost: event.booking.totalCost,
      status: event.booking.status,
      paymentStatus: event.booking.paymentStatus,
      isPaid: event.booking.isPaid,
      paymentMethod: event.booking.paymentMethod,
    );

    final result = await _createBookingUseCase(params);

    result.fold(
          (failure) => emit(BookingFailure(failure.message)),
          (_) {
        // Emit a success message for a SnackBar, then reload the list
        emit(const BookingActionSuccess('Booking Created Successfully!'));
        add(LoadUserBookingsEvent());
      },
    );
  }

  void _onDeleteBooking(
      DeleteBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    final params = DeleteBookingParams(bookingId: event.bookingId);
    final result = await _deleteBookingUseCase(params);
    result.fold(
          (failure) => emit(BookingFailure(failure.message)),
          (_) {
        // Emit a success message for a SnackBar, then reload the list.
        emit(const BookingActionSuccess('Booking Deleted Successfully!'));
        add(LoadUserBookingsEvent());
      },
    );
  }
}
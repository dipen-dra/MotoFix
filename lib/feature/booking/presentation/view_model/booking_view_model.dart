import 'package:bloc/bloc.dart';

import '../../domain/use_case/create_user_bookings.dart';
import '../../domain/use_case/delete_user_bookings.dart';
import '../../domain/use_case/get_user_bookings.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingViewModel extends Bloc<BookingEvent, BookingState> {
  final GetUserBookings _getUserBookingsUseCase;
  final CreateBookingUseCase _createBookingUseCase;
  final DeleteBookingUsecase _deleteBookingUseCase;

  BookingViewModel({
    required GetUserBookings getUserBookingsUseCase,
    required CreateBookingUseCase createBookingUseCase,
    required DeleteBookingUsecase deleteBookingUseCase,
  })  : _getUserBookingsUseCase = getUserBookingsUseCase,
        _createBookingUseCase = createBookingUseCase,
        _deleteBookingUseCase = deleteBookingUseCase,
        super(BookingInitial()) {
    on<LoadUserBookingsEvent>(_onLoadUserBookings);
    on<CreateBookingEvent>(_onCreateBooking);
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

  void _onCreateBooking(
    CreateBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());

    final params = CreateBookingParams(
      bikeModel: event.bikeModel,
      date: event.date,
      notes: event.notes,
      serviceId: event.serviceId,
    );

    final result = await _createBookingUseCase(params);
    result.fold(
      (failure) => emit(BookingFailure(failure.message)),
      (createdBooking) {
        // Emit a success message, then reload the list to show the new booking.
        emit(const BookingActionSuccess('Booking Created Successfully!'));
        add(LoadUserBookingsEvent());
      },
    );
  }

  void _onDeleteBooking(
    DeleteBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    final params = DeleteBookingParams(bookingId: event.bookingId);
    final result = await _deleteBookingUseCase(params);
    result.fold(
      (failure) => emit(BookingFailure(failure.message)),
      (_) {
        emit(const BookingActionSuccess('Booking Deleted Successfully!'));
        add(LoadUserBookingsEvent());
      },
    );
  }
}

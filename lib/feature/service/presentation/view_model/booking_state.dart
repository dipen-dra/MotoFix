// motofix_app/feature/service/presentation/bloc/booking_state.dart


import 'package:equatable/equatable.dart';

import '../../domain/entity/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

// Initial state, before any action is taken
class BookingInitial extends BookingState {}

// State when an operation is in progress (e.g., fetching data)
class BookingLoading extends BookingState {}

class BookingLoadSuccess extends BookingState {
  final List<BookingEntity> bookings;

  const BookingLoadSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}

// State for when a CRUD action (Create, Delete) is successful
// We use this for transient states, often shown in a SnackBar.
class BookingActionSuccess extends BookingState {
  final String message;

  const BookingActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

// State when any operation fails
class BookingFailure extends BookingState {
  final String error;

  const BookingFailure(this.error);

  @override
  List<Object> get props => [error];
}
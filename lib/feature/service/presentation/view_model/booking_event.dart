// motofix_app/feature/service/presentation/bloc/booking_event.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // For @immutable

import '../../domain/entity/booking_entity.dart';

@immutable
sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserBookingsEvent extends BookingEvent {}

// Event to create a new booking
class CreateBookingEvent extends BookingEvent {
  final BookingEntity booking;
  const CreateBookingEvent(this.booking);

  @override
  List<Object?> get props => [booking];
}

// Event to delete a booking
class DeleteBookingEvent extends BookingEvent {
  final String bookingId;


  const DeleteBookingEvent({
    required this.bookingId
});

  // Override props to include 'bookingId' and 'token'.
  @override
  List<Object?> get props => [bookingId];
}
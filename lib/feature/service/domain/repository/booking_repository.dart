import 'package:dartz/dartz.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/service/domain/entity/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure , List<BookingEntity>>> getUserBookings() ;

  Future<Either<Failure , void>> createBooking(BookingEntity entity) ;
  Future<Either<Failure, BookingEntity>> updateUserBooking(String bookingId) ;
  Future<Either<Failure , void>> deleteUserBooking (String bookingId , String? token) ;
  Future<Either<Failure , BookingEntity>> confirmCodPayment(String bookingId) ;
  Future<Either<Failure , void>> verifyKhaltiPayment() ;
}
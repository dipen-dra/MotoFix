import 'package:dartz/dartz.dart';
import 'package:motofix_app/app/usecase/usecase.dart';
import 'package:motofix_app/core/error/failure.dart';

import '../entity/booking_entity.dart';
import '../repository/booking_repository.dart';

class GetUserBookings implements UseCaseWithoutParams<List<BookingEntity>> {
    final BookingRepository bookingRepository ;

    GetUserBookings({
      required this.bookingRepository
}) ;
  @override
  Future<Either<Failure, List<BookingEntity>>> call()  async{
   return await bookingRepository.getUserBookings() ;
  }

}
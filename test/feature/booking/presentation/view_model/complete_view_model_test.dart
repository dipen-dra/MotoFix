import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/booking/domain/entity/booking_entity.dart';
import 'package:motofix_app/feature/booking/domain/use_case/get_booking_byId_usecase.dart';
import 'package:motofix_app/feature/booking/domain/use_case/get_completed_booking_usecase.dart';
import 'package:motofix_app/feature/booking/presentation/view_model/complete_event.dart';
import 'package:motofix_app/feature/booking/presentation/view_model/complete_state.dart';
// Note: Adjust this import if your BLoC file is named differently
import 'package:motofix_app/feature/booking/presentation/view_model/complete_view_model.dart';

// --- Mocks for Dependencies ---
class MockGetCompletedBookingsUseCase extends Mock implements GetCompletedBookingsUseCase {}
class MockGetBookingByIdUseCase extends Mock implements GetBookingByIdUseCase {}

void main() {
  late BookingHistoryBloc bookingHistoryBloc;
  late MockGetCompletedBookingsUseCase mockGetCompletedBookingsUseCase;
  late MockGetBookingByIdUseCase mockGetBookingByIdUseCase;

  // --- Test Data ---
  final tBooking1 = BookingEntity(id: '1', bikeModel: 'Avenger', isReviewed: false);
  final tBooking2 = BookingEntity(id: '2', bikeModel: 'Pulsar', isReviewed: true);
  final tBookingsList = [tBooking1, tBooking2];

  // A more detailed version of tBooking1 that we might get from the "by ID" call
  final tBooking1_detailed = BookingEntity(id: '1', bikeModel: 'Avenger', notes: 'Changed oil', isReviewed: true);

  const tFailure = ApiFailure(message: 'Network Error', statusCode: 503);

  setUp(() {
    mockGetCompletedBookingsUseCase = MockGetCompletedBookingsUseCase();
    mockGetBookingByIdUseCase = MockGetBookingByIdUseCase();
    bookingHistoryBloc = BookingHistoryBloc(
      getCompletedBookingsUseCase: mockGetCompletedBookingsUseCase,
      getBookingByIdUseCase: mockGetBookingByIdUseCase,
    );
  });

  tearDown(() {
    bookingHistoryBloc.close();
  });

  test('initial state should be BookingHistoryInitial', () {
    expect(bookingHistoryBloc.state, isA<BookingHistoryInitial>());
  });

  group('FetchCompletedBookingsList', () {
    blocTest<BookingHistoryBloc, BookingHistoryState>(
      'emits [Loading, ListLoaded] when getting the list is successful',
      setUp: () {
        when(() => mockGetCompletedBookingsUseCase())
            .thenAnswer((_) async => Right(tBookingsList));
      },
      build: () => bookingHistoryBloc,
      act: (bloc) => bloc.add(FetchCompletedBookingsList()),
      expect: () => <BookingHistoryState>[
        BookingHistoryListLoading(),
        BookingHistoryListLoaded(tBookingsList),
      ],
      verify: (_) {
        verify(() => mockGetCompletedBookingsUseCase()).called(1);
      },
    );

    blocTest<BookingHistoryBloc, BookingHistoryState>(
      'emits [Loading, Failure] when getting the list fails',
      setUp: () {
        when(() => mockGetCompletedBookingsUseCase())
            .thenAnswer((_) async => const Left(tFailure));
      },
      build: () => bookingHistoryBloc,
      act: (bloc) => bloc.add(FetchCompletedBookingsList()),
      expect: () => <BookingHistoryState>[
        BookingHistoryListLoading(),
        BookingHistoryFailure(tFailure.message),
      ],
    );
  });

  group('FetchBookingDetailsById', () {
    const tBookingId = '1';

    // This test verifies the complex logic of fetching details while preserving the list.
    blocTest<BookingHistoryBloc, BookingHistoryState>(
      'emits [DetailLoaded] with specific booking and updated master list on success',
      setUp: () {
        when(() => mockGetBookingByIdUseCase(any()))
            .thenAnswer((_) async => Right(tBooking1_detailed));
      },
      // We must seed the BLoC with a loaded list, as the logic depends on it.
      seed: () => BookingHistoryListLoaded(tBookingsList),
      build: () => bookingHistoryBloc,
      act: (bloc) => bloc.add(const FetchBookingDetailsById(tBookingId)),
      expect: () => <BookingHistoryState>[
        // The expected state contains BOTH the specific detail item
        // AND the master list with that one item updated.
        BookingHistoryDetailLoaded(
          booking: tBooking1_detailed,
          bookings: [tBooking1_detailed, tBooking2], // Note: tBooking1 is replaced
        ),
      ],
      verify: (_) {
        verify(() => mockGetBookingByIdUseCase(tBookingId)).called(1);
      },
    );

    blocTest<BookingHistoryBloc, BookingHistoryState>(
      'emits [Failure] when fetching details fails',
      setUp: () {
        when(() => mockGetBookingByIdUseCase(any()))
            .thenAnswer((_) async => const Left(tFailure));
      },
      seed: () => BookingHistoryListLoaded(tBookingsList),
      build: () => bookingHistoryBloc,
      act: (bloc) => bloc.add(const FetchBookingDetailsById(tBookingId)),
      expect: () => <BookingHistoryState>[
        BookingHistoryFailure(tFailure.message),
      ],
    );
  });
}
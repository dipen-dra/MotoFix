import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/review/domain/entity/review_entity.dart';
import 'package:motofix_app/feature/review/domain/usecase/add_review_usecase.dart';
import 'package:motofix_app/feature/review/domain/usecase/get_review_usecase.dart';
import 'package:motofix_app/feature/review/presentation/view_model/review_event.dart';
import 'package:motofix_app/feature/review/presentation/view_model/review_state.dart';
import 'package:motofix_app/feature/review/presentation/view_model/review_view_model.dart';

// --- Mocks and Fakes for Dependencies ---
class MockAddReviewUsecase extends Mock implements AddReviewUsecase {}
class MockGetServiceReviewsUsecase extends Mock implements GetServiceReviewsUsecase {}
class FakeReviewEntity extends Fake implements ReviewEntity {}

void main() {
  late ReviewBloc reviewBloc;
  late MockAddReviewUsecase mockAddReviewUsecase;
  late MockGetServiceReviewsUsecase mockGetServiceReviewsUsecase;

  // --- Test Data ---
  const tReviewEntity = ReviewEntity(rating: 5, comment: 'Great service!');
  final tReviewsList = [
    const ReviewEntity(id: '1', rating: 5, comment: 'Excellent!'),
    const ReviewEntity(id: '2', rating: 4, comment: 'Very good.'),
  ];
  const tServiceId = 'service-123';
  const tFailure = ApiFailure(message: 'Something went wrong', statusCode: 500);

  setUpAll(() {
    // Required by mocktail because AddReviewSubmitted event contains a custom object
    registerFallbackValue(FakeReviewEntity());
  });

  setUp(() {
    mockAddReviewUsecase = MockAddReviewUsecase();
    mockGetServiceReviewsUsecase = MockGetServiceReviewsUsecase();
    reviewBloc = ReviewBloc(
      addReviewUsecase: mockAddReviewUsecase,
      getServiceReviewsUsecase: mockGetServiceReviewsUsecase,
    );
  });

  tearDown(() {
    reviewBloc.close();
  });

  test('initial state should be ReviewInitial', () {
    expect(reviewBloc.state, isA<ReviewInitial>());
  });

  group('AddReviewSubmitted Event', () {
    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewLoading, ReviewSuccess] when adding a review is successful',
      setUp: () {
        when(() => mockAddReviewUsecase(any()))
            .thenAnswer((_) async => const Right(true));
      },
      build: () => reviewBloc,
      act: (bloc) => bloc.add(const AddReviewSubmitted(tReviewEntity)),
      expect: () => <ReviewState>[
        ReviewLoading(),
        ReviewSuccess(),
      ],
      verify: (_) {
        verify(() => mockAddReviewUsecase(tReviewEntity)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewLoading, ReviewFailure] when adding a review fails',
      setUp: () {
        when(() => mockAddReviewUsecase(any()))
            .thenAnswer((_) async => const Left(tFailure));
      },
      build: () => reviewBloc,
      act: (bloc) => bloc.add(const AddReviewSubmitted(tReviewEntity)),
      expect: () => <ReviewState>[
        ReviewLoading(),
        ReviewFailure(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockAddReviewUsecase(tReviewEntity)).called(1);
      },
    );
  });

  group('FetchServiceReviews Event', () {
    blocTest<ReviewBloc, ReviewState>(
      'emits [ServiceReviewsLoading, ServiceReviewsLoaded] when fetching reviews is successful',
      setUp: () {
        when(() => mockGetServiceReviewsUsecase(any()))
            .thenAnswer((_) async => Right(tReviewsList));
      },
      build: () => reviewBloc,
      act: (bloc) => bloc.add(const FetchServiceReviews(tServiceId)),
      expect: () => <ReviewState>[
        ServiceReviewsLoading(),
        ServiceReviewsLoaded(tReviewsList),
      ],
      verify: (_) {
        verify(() => mockGetServiceReviewsUsecase(tServiceId)).called(1);
      },
    );

    blocTest<ReviewBloc, ReviewState>(
      'emits [ServiceReviewsLoading, ServiceReviewsError] when fetching reviews fails',
      setUp: () {
        when(() => mockGetServiceReviewsUsecase(any()))
            .thenAnswer((_) async => const Left(tFailure));
      },
      build: () => reviewBloc,
      act: (bloc) => bloc.add(const FetchServiceReviews(tServiceId)),
      expect: () => <ReviewState>[
        ServiceReviewsLoading(),
        ServiceReviewsError(tFailure.message),
      ],
      verify: (_) {
        verify(() => mockGetServiceReviewsUsecase(tServiceId)).called(1);
      },
    );
  });

  group('ReviewReset Event', () {
    blocTest<ReviewBloc, ReviewState>(
      'emits [ReviewInitial] when the state is reset',
      // Seed the BLoC with a different state to ensure it changes
      seed: () => ReviewSuccess(),
      build: () => reviewBloc,
      act: (bloc) => bloc.add(ReviewReset()),
      expect: () => <ReviewState>[
        ReviewInitial(),
      ],
    );
  });
}
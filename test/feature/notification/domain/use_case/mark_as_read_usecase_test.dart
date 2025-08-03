import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/notification/domain/repository/notification_repository.dart';
import 'package:motofix_app/feature/notification/domain/use_case/mark_as_read_usecase.dart';

// Mock from a separate file
class MockNotificationRepository extends Mock implements INotificationRepository {}

void main() {
  late MarkAsReadUseCase usecase;
  late MockNotificationRepository mockNotificationRepository;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    usecase = MarkAsReadUseCase(repository: mockNotificationRepository);
  });

  const tServerFailure = ServerFailure(message: 'Could not connect to the server');

  test(
    'should call repository.markAsRead and return success (Right<void>)',
    () async {
      // Arrange
      // Stub the repository to return a successful Right(null) for the void operation
      when(() => mockNotificationRepository.markAsRead())
          .thenAnswer((_) async => const Right(null));

      // Act
      // Execute the use case
      final result = await usecase();

      // Assert
      // 1. Expect the result to be a Right(null) indicating success
      expect(result, const Right(null));
      // 2. Verify that markAsRead was called on the repository exactly once
      verify(() => mockNotificationRepository.markAsRead()).called(1);
      // 3. Ensure no other methods were called on the mock
      verifyNoMoreInteractions(mockNotificationRepository);
    },
  );

  test(
    'should return a Failure when the repository fails to mark as read',
    () async {
      // Arrange
      // Stub the repository to return a Left with a ServerFailure
      when(() => mockNotificationRepository.markAsRead())
          .thenAnswer((_) async => const Left(tServerFailure));

      // Act
      final result = await usecase();

      // Assert
      // 1. Expect the result to be a Left containing the defined failure
      expect(result, const Left(tServerFailure));
      // 2. Verify that markAsRead was still called exactly once
      verify(() => mockNotificationRepository.markAsRead()).called(1);
      // 3. Ensure no other interactions occurred
      verifyNoMoreInteractions(mockNotificationRepository);
    },
  );
}
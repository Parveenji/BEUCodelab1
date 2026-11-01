import 'package:beu_codelab/core/error/result.dart';

abstract interface class DailyCheckinRepository {
  Future<Result<bool, Exception>> dailyCheckin();
}
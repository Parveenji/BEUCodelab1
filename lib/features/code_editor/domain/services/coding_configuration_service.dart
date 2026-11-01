import 'package:beu_codelab/features/code_editor/domain/model/coding_configuration.dart';

abstract interface class CodingConfigurationService {
  Future<CodingConfiguration> loadConfiguration();
  Future<void> saveConfiguration(CodingConfiguration configs);
}

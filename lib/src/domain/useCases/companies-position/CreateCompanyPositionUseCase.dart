
// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/CompanyPosition.dart';
import 'package:medcar_app/src/domain/repository/CompaniesPositionRepository.dart';

class CreateCompanyPositionUseCase {

  CompaniesPositionRepository companyPositionRepository;

  CreateCompanyPositionUseCase(this.companyPositionRepository);

  run(CompanyPosition companyPosition) => companyPositionRepository.create(companyPosition);

}
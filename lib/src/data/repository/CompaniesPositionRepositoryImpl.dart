// ignore_for_file: file_names

import 'package:medcar_app/src/data/dataSource/remote/services/CompaniesPositionService.dart';
import 'package:medcar_app/src/domain/models/CompanyPosition.dart';
import 'package:medcar_app/src/domain/models/DriverPosition.dart';
import 'package:medcar_app/src/domain/repository/CompaniesPositionRepository.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class CompaniesPositionRepositoryImpl implements CompaniesPositionRepository {

  CompaniesPositionService companiesPositionService;

  CompaniesPositionRepositoryImpl(this.companiesPositionService);

  @override
  Future<Resource<bool>> create(CompanyPosition companyPosition) {
    return companiesPositionService.create(companyPosition);
  }

  @override
  Future<Resource<bool>> delete(int idDriver) {
    return companiesPositionService.delete(idDriver);
  }
  
  @override
  Future<Resource<DriverPosition>> getCompanyPosition(int idCompany) {
    return companiesPositionService.getDriverPosition(idCompany);
  }

}
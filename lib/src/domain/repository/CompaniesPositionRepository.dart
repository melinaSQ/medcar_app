// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/CompanyPosition.dart';
import 'package:medcar_app/src/domain/models/DriverPosition.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

abstract class CompaniesPositionRepository {

  Future<Resource<bool>> create(CompanyPosition companyPosition);
  Future<Resource<bool>> delete(int idCompany);
  Future<Resource<DriverPosition>> getCompanyPosition(int idCompany);

}
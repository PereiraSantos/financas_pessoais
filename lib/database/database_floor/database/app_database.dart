import 'dart:async';
import 'package:floor/floor.dart';
import 'package:financas_pessoais/database/database_floor/dao/finance/finance_dao.dart';
import 'package:financas_pessoais/database/database_floor/dao/outgoing/outgoing_dao.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../entities/category/category.dart';
import '../../../entities/finance/finance.dart';
import '../../../entities/outgoing/outgoing.dart';
import '../dao/category/category_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Finance, Outgoing, Category])
abstract class AppDatabase extends FloorDatabase {
  FinanceDao get financeDao;
  OutgoingDao get outgoingDao;
  CategoryDao get categoryDao;
}

import 'package:flutter_tools/utilities/utils.dart';

import '../models/core_models.dart';
import '../shared/common.dart';

class DBManager {
  static const String DB_NAME = 'RiderMan.db';
  static const String COMPANIES_TABLE_NAME = 'Companies';
  static const String EXPENSES_TABLE_NAME = 'Expenses';
  static const String SALES_TABLE_NAME = 'Sales';
  static const String GUARANTORS_TABLE_NAME = 'Guarantors';
  static const String RIDERS_TABLE_NAME = 'Riders';
  static const String PROPERTIES_TABLE_NAME = 'Properties';
  static const String ACCOUNT_OVERVIEW_TABLE_NAME = 'AccountOverviews';
  //
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_EMAIL = 'email';
  static const String COLUMN_IS_ACTIVE = 'isActive';
  static const String COLUMN_DESCRIPTION = 'description';
  static const String COLUMN_AMOUNT = 'amount';
  static const String COLUMN_DATE = 'date';
  static const String COLUMN_PROPERTY_ID = 'propertyId';
  static const String COLUMN_CREATED_AT = 'createdAt';
  static const String COLUMN_UPDATED_AT = 'updatedAt';
  static const String COLUMN_DUE_DATE = 'dueDate';
  static const String COLUMN_RIDER_ID = 'riderId';
  static const String COLUMN_RIDER = 'rider';
  static const String COLUMN_USER_ID = 'userId';
  static const String COLUMN_PLATE_NUMBER = 'plateNumber';
  static const String COLUMN_SALE_STATUS = 'saleStatus';
  static const String COLUMN_PAYMENT_REF = 'paymentRef';
  static const String COLUMN_INVOICE_ID = 'invoiceId';
  static const String COLUMN_CHARGE_STATUS = 'chargeStatus';
  static const String COLUMN_PARTNER_CHARGE_STATUS = 'partnerChargeStatus';
  static const String COLUMN_PHONE_NUMBER = 'phoneNumber';
  static const String COLUMN_FULL_NAME = 'fullName';
  static const String COLUMN_PHOTO_URL = 'photoUrl';
  static const String COLUMN_PROPERTY_TYPE = 'propertyType';
  static const String COLUMN_CONTRACT_TYPE = 'contractType';
  static const String COLUMN_AMOUNT_AGREED = 'amountAgreed';
  static const String COLUMN_TOTAL_EXPECTED = 'totalExpected';
  static const String COLUMN_DEPOSIT = 'deposit';
  static const String COLUMN_PAYMENT_FREQUENCY = 'paymentFrequency';
  static const String COLUMN_START_DATE = 'startDate';
  static const String COLUMN_COMPANY_ID = 'companyId';
  static const String COLUMN_GUARANTORS_NEEDED = 'guarantorsNeeded';
  static const String COLUMN_EXPECTED_SALES_COUNT = 'expectedSalesCount';
  static const String COLUMN_PROPERTY_STATUS = 'propertyStatus';
  static const String COLUMN_RAW_DATA = 'rawData';
  //
  static final String _sql_create_companies_table =
      'CREATE TABLE IF NOT EXISTS $COMPANIES_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_NAME TEXT, $COLUMN_EMAIL TEXT, $COLUMN_IS_ACTIVE INTEGER)';
//
  static final String _sql_create_expenses_table =
      'CREATE TABLE IF NOT EXISTS $EXPENSES_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_DESCRIPTION TEXT, $COLUMN_AMOUNT REAL, $COLUMN_DATE DATETIME, '
      '$COLUMN_PROPERTY_ID INTEGER, $COLUMN_CREATED_AT DATETIME, '
      '$COLUMN_UPDATED_AT DATETIME)';
//
  static final String _sql_create_sales_table =
      'CREATE TABLE IF NOT EXISTS $SALES_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_DESCRIPTION TEXT, $COLUMN_AMOUNT REAL, $COLUMN_DUE_DATE DATETIME, '
      '$COLUMN_PROPERTY_ID INTEGER, $COLUMN_RIDER_ID INTEGER, $COLUMN_PLATE_NUMBER TEXT, '
      '$COLUMN_SALE_STATUS TEXT, $COLUMN_PAYMENT_REF TEXT, $COLUMN_INVOICE_ID INTEGER, '
      '$COLUMN_CHARGE_STATUS TEXT, $COLUMN_PARTNER_CHARGE_STATUS TEXT, '
      '$COLUMN_CREATED_AT DATETIME, $COLUMN_UPDATED_AT DATETIME)';
//
  static final String _sql_create_guarantors_table =
      'CREATE TABLE IF NOT EXISTS $GUARANTORS_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_FULL_NAME TEXT, $COLUMN_PHONE_NUMBER TEXT, '
      '$COLUMN_PHOTO_URL TEXT, $COLUMN_RIDER_ID INTEGER, $COLUMN_PROPERTY_ID INTEGER)';
  //
  static final String _sql_create_riders_table =
      'CREATE TABLE IF NOT EXISTS $RIDERS_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_FULL_NAME TEXT, $COLUMN_PHONE_NUMBER TEXT, $COLUMN_PHOTO_URL TEXT)';
  //
  static final String _sql_create_properties_table =
      'CREATE TABLE IF NOT EXISTS $PROPERTIES_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_USER_ID INTEGER, $COLUMN_PLATE_NUMBER TEXT, '
      '$COLUMN_PROPERTY_TYPE TEXT, $COLUMN_CONTRACT_TYPE TEXT, '
      '$COLUMN_AMOUNT_AGREED REAL, $COLUMN_TOTAL_EXPECTED REAL, '
      '$COLUMN_DEPOSIT REAL, $COLUMN_PAYMENT_FREQUENCY TEXT, '
      '$COLUMN_START_DATE DATETIME, $COLUMN_COMPANY_ID INTEGER, '
      '$COLUMN_GUARANTORS_NEEDED INTEGER, $COLUMN_EXPECTED_SALES_COUNT INTEGER, '
      '$COLUMN_PROPERTY_STATUS TEXT, $COLUMN_CREATED_AT DATETIME, '
      '$COLUMN_RIDER TEXT, $COLUMN_UPDATED_AT DATETIME)';
  //
  static final String _sql_create_account_overview_table =
      'CREATE TABLE IF NOT EXISTS $ACCOUNT_OVERVIEW_TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_COMPANY_ID INTEGER UNIQUE, $COLUMN_RAW_DATA TEXT)';
  // todo run this in app first widget build // in MyApp build

  static late DBHelper dbHelper;

  static Future<void> initiate() async {
    try {
      var createList = [
        _sql_create_companies_table,
        _sql_create_properties_table,
        _sql_create_sales_table,
        _sql_create_expenses_table,
        _sql_create_riders_table,
        _sql_create_guarantors_table,
        _sql_create_account_overview_table,
      ];

      dbHelper = DBHelper.getInstance(DB_NAME);

      dbHelper.getDatabase(sqlQueriesToCreateTables: createList);
    } catch (ex) {
      logInfo(ex);
    }
  }

  static Future<void> clearAllTables() async {
    try {
      //
      await dbHelper.deleteAllFromTable(COMPANIES_TABLE_NAME);
      await dbHelper.deleteAllFromTable(EXPENSES_TABLE_NAME);
      await dbHelper.deleteAllFromTable(SALES_TABLE_NAME);
      await dbHelper.deleteAllFromTable(GUARANTORS_TABLE_NAME);
      await dbHelper.deleteAllFromTable(RIDERS_TABLE_NAME);
      await dbHelper.deleteAllFromTable(PROPERTIES_TABLE_NAME);
      await dbHelper.deleteAllFromTable(ACCOUNT_OVERVIEW_TABLE_NAME);
      //
    } catch (ex) {
      logInfo('clearAllTables => $ex');
    }
  }

  static Future<bool> _insertCompany(Company company) async {
    try {
      var map = company.toMap();
      map[COLUMN_IS_ACTIVE] = company.isActive ? 1 : 0;
      logInfo('_insertCompany => $map');
      return await dbHelper.insert(COMPANIES_TABLE_NAME, map) > 0;
    } catch (ex) {
      logInfo('_insertCompany error => $ex');
    }
    return false;
  }

  static Future<bool> _updateCompany(int idToUpdate, Company company) async {
    try {
      var map = company.toMap();
      map.remove(COLUMN_ID);
      map[COLUMN_IS_ACTIVE] = company.isActive ? 1 : 0;
      logInfo('_updateCompany => $map');
      return await dbHelper.update(
              tableName: COMPANIES_TABLE_NAME,
              whereColumnName: COLUMN_ID,
              whereValue: idToUpdate,
              map: map) >
          0;
    } catch (ex) {
      logInfo('_updateCompany error => $ex');
    }
    return false;
  }

  static Future<bool> upsertCompany(Company company) async {
    try {
      var isGood = await _insertCompany(company);
      if (isGood) return true;
      return await _updateCompany(company.id, company);
    } catch (ex) {
      logInfo('upsertCompany error => $ex');
    }
    return false;
  }

  static Future<List<Company>> getAllCompanies() async {
    try {
      var tempList = await dbHelper.getAllDataFromTable(COMPANIES_TABLE_NAME);
      // logInfo('getAllCompanies => $tempList');
      List<Company> res = [];
      for (var m in tempList) {
        var isActive = m[COLUMN_IS_ACTIVE] as int == 1;
        var map = Map<String, dynamic>.from(m);
        map[COLUMN_IS_ACTIVE] = isActive;
        // logInfo('getAllCompanies2 => $map');
        res.add(Company.fromMap(map));
      }
      // logInfo('getAllCompanies3 => $res');
      return res;
    } catch (ex) {
      logInfo('getAllCompanies error => $ex');
      logInfo(ex);
    }
    return List.empty();
  }

  // static Future<Company?> findPlaceById(int placeTestId) async {
  //   try {
  //     var map = await DBHelper.getInstance(DB_NAME).getSingleDataFromTable(
  //         tableName: PLACES_TABLE_NAME,
  //         whereColumnName: COLUMN_ID,
  //         whereValue: placeTestId);
  //     return map == null ? null : PlaceTest.fromMap(map);
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  // static Future<bool> deletePlace(int placeTestId) async {
  //   try {
  //     return await DBHelper.getInstance(DB_NAME).delete(
  //             tableName: PLACES_TABLE_NAME,
  //             whereColumnName: COLUMN_ID,
  //             whereValue: placeTestId) >
  //         0;
  //   } catch (ex) {
  //     logInfo(ex);
  //   }
  //   return false;
  // }

  static Future<bool> _insertSale(Sale input) async {
    try {
      var map = input.toMap();
      logInfo('_insertSale => $map');
      return await dbHelper.insert(SALES_TABLE_NAME, map) > 0;
    } catch (ex) {
      logInfo('_insertSale error => $ex');
    }
    return false;
  }

  static Future<bool> _updateSale(int idToUpdate, Sale input) async {
    try {
      var map = input.toMap();
      logInfo('_updateSale => $map');
      return await dbHelper.update(
              tableName: SALES_TABLE_NAME,
              whereColumnName: COLUMN_ID,
              whereValue: idToUpdate,
              map: map) >
          0;
    } catch (ex) {
      logInfo('_updateSale error => $ex');
    }
    return false;
  }

  static Future<bool> upsertSale(Sale input) async {
    try {
      var isGood = await _insertSale(input);
      if (isGood) return true;
      return await _updateSale(input.id, input);
    } catch (ex) {
      logInfo('upsertSale error => $ex');
    }
    return false;
  }

  static Future<List<Sale>> getAllSales() async {
    try {
      var tempList = await dbHelper.getAllDataFromTable(SALES_TABLE_NAME);
      List<Sale> res = tempList.map((m) => Sale.fromMap(m)).toList();
      return res;
    } catch (ex) {
      logInfo('getAllSales error => $ex');
      logInfo(ex);
    }
    return List.empty();
  }

  //
  static Future<bool> _insertAccountOverview(AccountOverview input) async {
    try {
      var map = {
        COLUMN_ID: input.id,
        COLUMN_COMPANY_ID: input.companyId,
        COLUMN_RAW_DATA: input.toJson(),
      };
      // logInfo('_insertAccountOverview => $map');
      return await dbHelper.insert(ACCOUNT_OVERVIEW_TABLE_NAME, map) > 0;
    } catch (ex) {
      logInfo('_insertAccountOverview error => $ex');
    }
    return false;
  }

  static Future<bool> _updateAccountOverview(
      int idToUpdate, AccountOverview input) async {
    try {
      var map = {
        COLUMN_ID: idToUpdate,
        COLUMN_COMPANY_ID: input.companyId,
        COLUMN_RAW_DATA: input.toJson(),
      };
      // logInfo('_updateAccountOverview => $map');
      return await dbHelper.update(
              tableName: ACCOUNT_OVERVIEW_TABLE_NAME,
              whereColumnName: COLUMN_ID,
              whereValue: idToUpdate,
              map: map) >
          0;
    } catch (ex) {
      logInfo('_updateAccountOverview error => $ex');
    }
    return false;
  }

  static Future<bool> upsertAccountOverview(AccountOverview input) async {
    try {
      var isGood = await _insertAccountOverview(input);
      if (isGood) return true;
      return await _updateAccountOverview(input.id, input);
    } catch (ex) {
      logInfo('upsertAccountOverview error => $ex');
    }
    return false;
  }

  static Future<AccountOverview> getAccountOverview(int companyId) async {
    try {
      var tempData = await dbHelper.getSingleDataFromTable(
        tableName: ACCOUNT_OVERVIEW_TABLE_NAME,
        whereColumnName: COLUMN_COMPANY_ID,
        whereValue: companyId,
      );

      return AccountOverview.fromJson(getString(tempData?[COLUMN_RAW_DATA]));
    } catch (ex) {
      logInfo('getAccountOverview error => $ex');
      logInfo(ex);
    }
    return defaultAccountOverview;
  }

  //
  static Future<bool> _insertProperty(Property input) async {
    try {
      var map = input.toMap();
      map[COLUMN_RIDER] = input.rider?.toJson();
      // logInfo('_insertProperty => $map');
      return await dbHelper.insert(PROPERTIES_TABLE_NAME, map) > 0;
    } catch (ex) {
      logInfo('_insertProperty error => $ex');
    }
    return false;
  }

  static Future<bool> _updateProperty(int idToUpdate, Property input) async {
    try {
      var map = input.toMap();
      map[COLUMN_RIDER] = input.rider?.toJson();
      // logInfo('_updateProperty => $map');
      return await dbHelper.update(
              tableName: PROPERTIES_TABLE_NAME,
              whereColumnName: COLUMN_ID,
              whereValue: idToUpdate,
              map: map) >
          0;
    } catch (ex) {
      logInfo('_updateProperty error => $ex');
    }
    return false;
  }

  static Future<bool> upsertProperty(Property input) async {
    try {
      var isGood = await _insertProperty(input);
      if (isGood) return true;
      return await _updateProperty(input.id, input);
    } catch (ex) {
      logInfo('upsertProperty error => $ex');
    }
    return false;
  }

  static Future<List<Property>> getAllProperties() async {
    try {
      var tempList = await dbHelper.getAllDataFromTable(PROPERTIES_TABLE_NAME);
      List<Property> res = [];
      for (var m in tempList) {
        var map = Map<String, dynamic>.from(m);
        var rider = map[COLUMN_RIDER];
        if (rider != null) {
          map[COLUMN_RIDER] = Rider.fromJson(rider);
        }
        // logInfo('getAllProperties => $map');
        res.add(Property.fromMap(map));
      }
      return res;
    } catch (ex) {
      logInfo('getAllProperties error => $ex');
      logInfo(ex);
    }
    return List.empty();
  }
}

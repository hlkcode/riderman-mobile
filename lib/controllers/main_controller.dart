import 'dart:math';

import 'package:flutter_tools/common.dart';
import 'package:flutter_tools/tools_models.dart';
import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:flutter_tools/utilities/utils.dart';
import 'package:get/get.dart';
import 'package:riderman/data/db_manager.dart';

import '../models/core_models.dart';
import '../shared/common.dart';
import '../shared/config.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();

  String get _companiesUrl => makeApiUrl('companies');
  String get _reportsUrl => makeApiUrl('reports');

  Rx<AssetOverview> assetOverview = AssetOverview(
    paid: 1200,
    amountAgreed: 2350,
    deposit: 12340,
    paidPercentage: 69.5,
    propertyId: 1,
    remaining: 2390,
    totalExpected: 2038,
  ).obs;

  Rx<AccountOverview> accountOverview = AccountOverview(
    companyId: 1,
    totalEarnings: 0,
    totalPropertyCount: 0,
    totalPaidSalesCount: 0,
    availableBalance: 0,
    bikeCount: 1,
    bikeEarnings: 2,
    bikeExpenditures: 2,
    bikeExpendituresCount: 2,
    bikeSalesCount: 2,
    carCount: 1,
    carEarnings: 9,
    carExpenditures: 2,
    carExpendituresCount: 9,
    carSalesCount: 6,
    createdAt: DateTime.now(),
    id: 8,
    totalExpenditures: 78,
    totalExpendituresCount: 8,
    tricycleCount: 8,
    tricycleEarnings: 2,
    tricycleExpenditures: 9,
    tricycleExpendituresCount: 6,
    tricycleSalesCount: 4,
    trucCount: 6,
    trucEarnings: 4,
    trucExpenditures: 4,
    trucExpendituresCount: 4,
    trucSalesCount: 0,
    updatedAt: DateTime.now(),
  ).obs;

  final RxList<Company> companies = <Company>[
    // Company(id: 1, email: 'email.com', isActive: true, name: 'CompanyName'),
    // Company(
    //     id: 2,
    //     email: '233265336549@riderman.com',
    //     isActive: true,
    //     name: '233265336549'),
    // Company(
    //     id: 3,
    //     email: 'hlkcode@gmail.com',
    //     isActive: false,
    //     name: 'Axon Limited'),
    // Company(
    //     id: 4,
    //     email: 'halik@gmail.com',
    //     isActive: false,
    //     name: 'Light Company'),
  ].obs;

  final RxList<Expense> expenses = [
    Expense(
        propertyId: 1,
        description: 'Expense 1',
        amount: 500,
        date: DateTime.now(),
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        id: 1),
    Expense(
        propertyId: 2,
        description: 'Expense 2',
        amount: 1500,
        date: DateTime.now(),
        updatedAt: null,
        createdAt: DateTime.now(),
        id: 2),
    Expense(
        propertyId: 2,
        description: 'Expense 3',
        amount: 9834,
        date: DateTime.now(),
        updatedAt: null,
        createdAt: DateTime.now(),
        id: 3),
    Expense(
        propertyId: 1,
        description: 'Expense 1',
        amount: 9500,
        date: DateTime.now(),
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        id: 4),
  ].obs;

  final RxList<Sale> sales = [
    Sale(
        propertyId: 1,
        description: 'Payment 1',
        amount: 500,
        dueDate: DateTime.now(),
        updatedAt: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1),
    Sale(
        propertyId: 1,
        description: 'Payment 2',
        amount: 500,
        dueDate: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1),
    Sale(
        propertyId: 1,
        description: 'Payment 3',
        amount: 500,
        dueDate: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1),
    Sale(
        propertyId: 1,
        description: 'Payment 4',
        amount: 500,
        dueDate: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1),
    Sale(
        propertyId: 1,
        description: 'Payment 5',
        amount: 500,
        dueDate: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1),
    Sale(
        propertyId: 1,
        description: 'Payment 6',
        amount: 500,
        dueDate: DateTime.now(),
        riderId: 1,
        plateNumber: 'QW-783-GH',
        saleStatus: 'PAID',
        paymentRef: '2639400487653',
        invoiceId: 1,
        createdAt: DateTime.now(),
        chargeStatus: "DONE",
        partnerChargeStatus: 'NONE',
        id: 1)
  ].obs;

  final RxList<Property> properties = <Property>[
    Property(
        rider: Rider(
          phoneNumber: '23390447850',
          fullName: 'RiderName',
          photoUrl:
              'https://img.freepik.com/premium-vector/simple-vector-id-card-illustration_869472-801.jpg',
          guarantors: [
            Guarantor(
              phoneNumber: '23390447850',
              fullName: 'Garantor 1 name',
              photoUrl:
                  'https://img.freepik.com/premium-vector/simple-vector-id-card-illustration_869472-801.jpg',
              id: 1,
              propertyId: 1,
              riderId: 1,
            )
          ],
          id: 2,
        ),
        plateNumber: 'QA-1830-GH',
        propertyType: PropertyType.Truck.name,
        contractType: ContractType.WorkAndPay.name,
        amountAgreed: 2984,
        totalExpected: 294,
        deposit: 294749,
        paymentFrequency: PaymentFrequency.Weekly.name,
        startDate: DateTime.now(),
        companyId: 20,
        userId: 98,
        propertyStatus: PropertyStatus.READY.name,
        expectedSalesCount: 100,
        guarantorsNeeded: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: 6),
    Property(
        plateNumber: 'QA-1830-GH',
        propertyType: PropertyType.Car.name,
        contractType: ContractType.Continuous.name,
        amountAgreed: 2984,
        totalExpected: 294,
        deposit: 294749,
        paymentFrequency: PaymentFrequency.Daily.name,
        startDate: DateTime.now(),
        companyId: 20,
        userId: 98,
        propertyStatus: PropertyStatus.ONGOING.name,
        expectedSalesCount: 100,
        guarantorsNeeded: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: 6),
    Property(
        plateNumber: 'QA-1830-GH',
        propertyType: PropertyType.Motorcycle.name,
        contractType: ContractType.Continuous.name,
        amountAgreed: 2984,
        totalExpected: 294,
        deposit: 294749,
        paymentFrequency: PaymentFrequency.Monthly.name,
        startDate: DateTime.now(),
        companyId: 20,
        userId: 98,
        propertyStatus: PropertyStatus.CONNECTING.name,
        expectedSalesCount: 100,
        guarantorsNeeded: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: 6),
    Property(
        plateNumber: 'QA-1830-GH',
        propertyType: PropertyType.Tricycle.name,
        contractType: ContractType.WorkAndPay.name,
        amountAgreed: 2984,
        totalExpected: 294,
        deposit: 294749,
        paymentFrequency: PaymentFrequency.Yearly.name,
        startDate: DateTime.now(),
        companyId: 20,
        userId: 98,
        propertyStatus: PropertyStatus.ONGOING.name,
        expectedSalesCount: 100,
        guarantorsNeeded: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: 6),
  ].obs;

  void getAssetOverviewData() {
    final rand = Random();
    assetOverview.value = AssetOverview(
      paid: rand.nextDouble() * 9999,
      amountAgreed: rand.nextDouble() * 5000,
      deposit: rand.nextDouble() * 1000,
      paidPercentage: rand.nextDouble() * 100,
      propertyId: 1,
      remaining: rand.nextDouble() * 999,
      totalExpected: rand.nextDouble() * 99999,
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllOnlineData();
    // storage.listenKey(AppConstants.COMPANY_DATA, (nv) async {
    //   if (nv != null) {
    //     await getAccountOverviewData(loadData: true, refresh: true);
    //   }
    // });
  }

  Future<void> getAllOnlineData() async {
    if (isLoggedIn() == false) return;

    await getCompanies(loadData: true, refresh: true);
    await getAccountOverviewData(loadData: true, refresh: true);
  }

  Future<void> getCompanies(
      {bool loadData = true, bool refresh = false}) async {
    try {
      if (loadData == false && refresh == false) return;
      loading.value = true;
      final url = '$_companiesUrl/formobile';
      if (isLoggedIn() && refresh) {
        final calRes = await _requestManager.sendGetRequest(url,
            headers: headers, returnBodyOnError: true);

        logInfo(calRes);
        final BaseResponse res =
            BaseResponse.fromMap(calRes as Map<String, dynamic>);

        if (!res.isSuccess) {
          HlkDialog.showErrorSnackBar(res.message ?? 'Failed to get companies');
          return;
        }
        var list = Company.parseToGetList(res.data);
        for (var comp in list) {
          var insRes = await DBManager.upsertCompany(comp);
          // logInfo('insRes = $insRes');
        }
      }

      if (loadData) {
        companies.value = await DBManager.getAllCompanies();
        logInfo('companies = ${companies.length}');
      }
    } catch (e) {
      handleException(e, null, refresh);
      logInfo('main.getCompanies => $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> getSales({bool loadData = true, bool refresh = false}) async {
    try {
      if (loadData == false && refresh == false) return;
      loading.value = true;
      final url = '$_reportsUrl/dashboard/formobile';
      if (isLoggedIn() && refresh) {
        final calRes = await _requestManager.sendGetRequest(url,
            headers: headers, returnBodyOnError: true);

        logInfo(calRes);
        final BaseResponse res =
            BaseResponse.fromMap(calRes as Map<String, dynamic>);

        if (!res.isSuccess) {
          HlkDialog.showErrorSnackBar(res.message ?? 'Failed to get companies');
          return;
        }
        var list = Company.parseToGetList(res.data);
        for (var comp in list) {
          var insRes = await DBManager.upsertCompany(comp);
          // logInfo('insRes = $insRes');
        }
      }

      if (loadData) {
        companies.value = await DBManager.getAllCompanies();
        logInfo('companies = ${companies.length}');
      }
    } catch (e) {
      handleException(e, null, refresh);
      logInfo('main.getSales => $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> getAccountOverviewData(
      {bool loadData = true, bool refresh = false}) async {
    accountOverview.value = defaultAccountOverview;
    try {
      if (loadData == false && refresh == false) return;

      if (isLoggedIn() && isCompanySet && refresh) {
        loading.value = true;
        final url = '$_reportsUrl/dashboard/${currentCompany.id}';
        final calRes = await _requestManager.sendGetRequest(url,
            headers: headers, returnBodyOnError: true);

        logInfo(calRes);
        final BaseResponse res =
            BaseResponse.fromMap(calRes as Map<String, dynamic>);

        if (!res.isSuccess) {
          HlkDialog.showErrorSnackBar(
              res.message ?? 'Failed to get dashboard data');
          return;
        }
        var overview = AccountOverview.fromMap(res.data);
        await DBManager.upsertAccountOverview(overview);
      }

      if (loadData && isCompanySet) {
        accountOverview.value =
            await DBManager.getAccountOverview(currentCompany.id);
        // logInfo('accountOverview = ${accountOverview.value.toMap()}');
      }
    } catch (e) {
      handleException(e, null, refresh);
      logInfo('main.getAccountOverviewData => $e');
    } finally {
      loading.value = false;
    }
  }

  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

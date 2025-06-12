import 'package:flutter_tools/utilities/request_manager.dart';
import 'package:get/get.dart';

import '../models/core_models.dart';
import '../shared/config.dart';

class MainController extends GetxController {
  RxBool loading = false.obs;
  final RequestManager _requestManager = RequestManager();
  String get _accountUrl => makeApiUrl('accounts');
  String get _guardiansUrl => makeApiUrl('Guardians');

  Rx<OverviewData> overviewData = OverviewData(
    paid: 1200,
    amountAgreed: 2350,
    deposit: 12340,
    paidPercentage: 69.5,
    propertyId: 1,
    remaining: 2390,
    totalExpected: 2038,
  ).obs;

  final RxList<Company> companies = [
    Company(id: 1, email: 'email.com', isActive: true, name: 'CompanyName'),
    Company(
        id: 2,
        email: '233265336549@riderman.com',
        isActive: true,
        name: '233265336549'),
    Company(
        id: 3,
        email: 'hlkcode@gmail.com',
        isActive: false,
        name: 'Axon Limited'),
    Company(
        id: 4,
        email: 'halik@gmail.com',
        isActive: false,
        name: 'Light Company'),
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

  // 1 => sign up // request code // verify // login

  // 2 => login if not verified => request code (resend = true), verify

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

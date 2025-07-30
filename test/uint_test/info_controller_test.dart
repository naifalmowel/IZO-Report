// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:izo_report/controllers/info_controllers.dart';
// import 'package:izo_report/models/box_model.dart';
// import 'package:izo_report/models/expense_model.dart';
// import 'package:izo_report/models/voucher_model.dart';
// import 'package:izo_report/server/dio_services.dart';
// import 'package:izo_report/utils/constants.dart';
// import 'package:mocktail/mocktail.dart';
//
// class DioClientMock extends Mock implements DioClient {}
//
// void main() {
//   late InfoController sut;
//   late DioClientMock mock;
//   final requestOptions = RequestOptions(
//     path: '/info',
//     method: 'GET', // or any other HTTP method required
//     // You may need to set other properties based on your implementation
//   );
//
//   setUp(() {
//     mock = DioClientMock();
//     sut = InfoController(mock);
//   });
//
//   group("test info controller function", () {
//     // group("test getAllBills function", () {
//     //
//     //   test("response getAllBills is 200", () async {
//     //     //arrange
//     //     when(() => mock.getDio(path: '/info')).thenAnswer((_) async {
//     //       final requestOptions = RequestOptions(
//     //         path: '/info',
//     //         method: 'GET', // or any other HTTP method required
//     //         // You may need to set other properties based on your implementation
//     //       );
//     //       return Response(
//     //           data: {
//     //             "bill": "[{\"id\":\"1\",\"bill-number\":\"#IN0001\",\"final-total\":\"48.0\",\"cash-amount\":\"48.0\",\"visa-amount\":\"0.0\",\"hall\":\"TakeAway\",\"table\":\"1\",\"customer-name\":\"Cash Customer\",\"cashier-name\":\"Admin\",\"date\":\"2024-01-21 13:03:16.000\",\"type\":\"sales\",\"subtotal\":\"48.0\"},{\"id\":\"2\",\"bill-number\":\"#RES0001\",\"final-total\":\"-48.0\",\"cash-amount\":\"-48.0\",\"visa-amount\":\"0.0\",\"hall\":\"TakeAway\",\"table\":\"1\",\"customer-name\":\"Cash Customer\",\"cashier-name\":\"Admin\",\"date\":\"2024-01-21 13:03:52.000\",\"type\":\"returned\",\"subtotal\":\"-48.0\"},{\"id\":\"3\",\"bill-number\":\"#RES0002\",\"final-total\":\"48.0\",\"cash-amount\":\"48.0\",\"visa-amount\":\"0.0\",\"hall\":\"TakeAway\",\"table\":\"1\",\"customer-name\":\"Cash Customer\",\"cashier-name\":\"Admin\",\"date\":\"2024-01-21 13:05:54.000\",\"type\":\"returned\",\"subtotal\":\"48.0\"},{\"id\":\"4\",\"bill-number\":\"#IN0002\",\"final-total\":\"96.0\",\"cash-amount\":\"96.0\",\"visa-amount\":\"0.0\",\"hall\":\"Delivery\",\"table\":\"1\",\"customer-name\":\"Cash Customer\",\"cashier-name\":\"Admin\",\"date\":\"2024-01-21 13:38:30.000\",\"type\":\"sales\",\"subtotal\":\"96.0\"},{\"id\":\"5\",\"bill-number\":\"#IN0003\",\"final-total\":\"48.0\",\"cash-amount\":\"48.0\",\"visa-amount\":\"0.0\",\"hall\":\"TakeAway\",\"table\":\"1\",\"customer-name\":\"Cash Customer\",\"cashier-name\":\"Admin\",\"date\":\"2024-01-21 13:46:59.000\",\"type\":\"sales\",\"subtotal\":\"48.0\"}]",
//     //             "purchase": "10735.2",
//     //             "daily-purchase": "10735.2",
//     //             "monthly-purchase": "10735.2",
//     //             "yearly-purchase": "10735.2",
//     //             "net-purchase": "11360.0",
//     //             "expense": "0.0",
//     //             "daily-expense": "0.0",
//     //             "monthly-expense": "0.0",
//     //             "yearly-expense": "0.0",
//     //             "payment": "0.0",
//     //             "receipt": "192.0",
//     //             "hall": "[{\"id\":\"-2\",\"name\":\"-2\",\"table-count\":\"1\",\"tables\":\"[{\\\"number\\\":\\\"1\\\",\\\"hall\\\":\\\"-2\\\",\\\"amount\\\":\\\"null\\\",\\\"cost\\\":\\\"0.0\\\",\\\"wait\\\":\\\"null\\\",\\\"time\\\":\\\"null\\\",\\\"booking\\\":\\\"false\\\",\\\"booking-date\\\":\\\"2024-01-21 18:30:54.697961\\\",\\\"driver-name\\\":\\\"null\\\",\\\"guest-name\\\":\\\"\\\",\\\"guest-mobil\\\":\\\"\\\",\\\"guestNo\\\":\\\"\\\",\\\"format\\\":\\\"\\\",\\\"customerId\\\":\\\"0\\\"}]\"},{\"id\":\"-1\",\"name\":\"TakeAway\",\"table-count\":\"1\",\"tables\":\"[{\\\"number\\\":\\\"1\\\",\\\"hall\\\":\\\"-1\\\",\\\"amount\\\":\\\"0.0\\\",\\\"cost\\\":\\\"48.0\\\",\\\"wait\\\":\\\"false\\\",\\\"time\\\":\\\"false\\\",\\\"booking\\\":\\\"null\\\",\\\"booking-date\\\":\\\"null\\\",\\\"driver-name\\\":\\\"\\\",\\\"guest-name\\\":\\\"null\\\",\\\"guest-mobil\\\":\\\"null\\\",\\\"guestNo\\\":\\\"null\\\",\\\"format\\\":\\\"\\\",\\\"customerId\\\":\\\"1\\\"}]\"},{\"id\":\"0\",\"name\":\"Delivery\",\"table-count\":\"1\",\"tables\":\"[{\\\"number\\\":\\\"1\\\",\\\"hall\\\":\\\"0\\\",\\\"amount\\\":\\\"null\\\",\\\"cost\\\":\\\"0.0\\\",\\\"wait\\\":\\\"null\\\",\\\"time\\\":\\\"null\\\",\\\"booking\\\":\\\"false\\\",\\\"booking-date\\\":\\\"2024-01-21 18:30:54.697961\\\",\\\"driver-name\\\":\\\"null\\\",\\\"guest-name\\\":\\\"\\\",\\\"guest-mobil\\\":\\\"\\\",\\\"guestNo\\\":\\\"\\\",\\\"format\\\":\\\"\\\",\\\"customerId\\\":\\\"0\\\"}]\"}]",
//     //             "type": "REST"
//     //           },
//     //           statusCode: 200,
//     //           requestOptions: requestOptions);
//     //     });
//     //     //act
//     //     final bills = await sut.getAllBills();
//     //     //assert
//     //     expect(bills, true);
//     //   });
//     //
//     //   test("response getAllBills is not 200", () async {
//     //     //arrange
//     //     when(() => mock.getDio(path: '/info')).thenAnswer((_) async {
//     //       final requestOptions = RequestOptions(
//     //         path: '/info',
//     //         method: 'GET', // or any other HTTP method required
//     //         // You may need to set other properties based on your implementation
//     //       );
//     //       return Response(
//     //           data: {}, statusCode: 500, requestOptions: requestOptions);
//     //     });
//     //     //act
//     //     final bills = await sut.getAllBills();
//     //     //assert
//     //     expect(bills, false);
//     //   });
//     //
//     // });
//
//     group("test checkQR function", () {
//       test("response checkQR is 200 and have data success", () async {
//         //arrange
//         when(() => mock.getDio(path: '/check')).thenAnswer((_) async {
//           return Response(
//               data: "success", statusCode: 200, requestOptions: requestOptions);
//         });
//         //act
//         final bills = await sut.checkQR();
//         //assert
//         expect(bills, true);
//       });
//
//       test("response checkQR is 200 but not have data success", () async {
//         //arrange
//         when(() => mock.getDio(path: '/check')).thenAnswer((_) async {
//           final requestOptions = RequestOptions(
//             path: '/info',
//             method: 'GET', // or any other HTTP method required
//             // You may need to set other properties based on your implementation
//           );
//           return Response(
//               data: {}, statusCode: 200, requestOptions: requestOptions);
//         });
//         //act
//         final bills = await sut.checkQR();
//         //assert
//         expect(bills, false);
//       });
//
//       test("response checkQR is not 200", () async {
//         //arrange
//         when(() => mock.getDio(path: '/info')).thenAnswer((_) async {
//           final requestOptions = RequestOptions(
//             path: '/info',
//             method: 'GET', // or any other HTTP method required
//             // You may need to set other properties based on your implementation
//           );
//           return Response(
//               data: {}, statusCode: 500, requestOptions: requestOptions);
//         });
//         //act
//         final bills = await sut.getAllBills();
//         //assert
//         expect(bills, false);
//       });
//     });
//
//     // group("test checkMobile function", () {
//     //   test("test that function check mobile has response 200 and have data['message'] == 'success' ", () async{
//     //      //arrange
//     //    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     //   //  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     //     when(()=>mock.postDio(
//     //         path: '/check-mobile',
//     //         data1: {"product": "1111"})).thenAnswer((_)async{
//     //           return Response(requestOptions: requestOptions,data:{
//     //           'message': 'success'
//     //           } ,statusCode: 200);
//     //     });
//     //
//     //     // act
//     //     final testFunction = await sut.checkMobile();
//     //     //assert
//     //     expect(testFunction, true);
//     //   });
//     //   test("test that function check mobile has response 200 and have no data", () async{
//     //      //arrange
//     //     when(()=>mock.postDio(
//     //         path: '/check-mobile',
//     //         data1: {"product": "1111"})).thenAnswer((_)async{
//     //           return Response(requestOptions: requestOptions,data:{} ,statusCode: 200);
//     //     });
//     //
//     //     // act
//     //     final testFunction = await sut.checkMobile();
//     //     //assert
//     //     expect(testFunction, false);
//     //   });
//     //   test("test that function check mobile has response 500", () async{
//     //      //arrange
//     //     when(()=>mock.postDio(
//     //         path: '/check-mobile',
//     //         data1: {"product": "1111"})).thenAnswer((_)async{
//     //           return Response(requestOptions: requestOptions,data:{} ,statusCode: 500);
//     //     });
//     //
//     //     // act
//     //     final testFunction = await sut.checkMobile();
//     //     //assert
//     //     expect(testFunction, false);
//     //   });
//     // });
//
//     group("test getAllPurchase function", () {
//       test("test init value", () {
//         expect(sut.purchase, []);
//         expect(sut.purchasePlayer, []);
//       });
//
//       test("test get purchase success", () async {
//         //arrange
//         when(() => mock.getDio(path: '/purchase'))
//             .thenAnswer((invocation) async {
//           return Response(
//               requestOptions: requestOptions, statusCode: 200, data: """
//               {
//                 "message": "Success",
//                 "purchase": [
//                   {
//                     "id": "1",
//                     "contact": "Cash Supplier",
//                     "date": "2024-01-15 00:00:00.000",
//                     "type": "purchase",
//                     "final_total": "10735.2",
//                     "pur_no": "#PUR0001",
//                     "pay_type": "due"
//                   }
//                 ]
//               }
//               """);
//         });
//         //act
//         expect(sut.purchase, []);
//         expect(sut.purchasePlayer, []);
//
//         await sut.getAllPurchase();
//         //assert
//         expect(sut.purchase.isNotEmpty, true);
//         expect(sut.purchasePlayer.isNotEmpty, true);
//       });
//     });
//
//     group("test getAllExpense function", () {
//       test("init list value expense", () {
//         expect(sut.expense.isEmpty, true);
//         expect(sut.expensePlayer.isEmpty, true);
//       });
//
//       test("test list is not empty when come data", () async {
//         when(() => mock.getDio(path: '/expense')).thenAnswer((_) async {
//           return Response(
//               requestOptions: requestOptions, statusCode: 200, data: """
//           {
//           "message":"Success",
//           "expense":[
//              {
//                     "id": "1",
//                     "date": "2024-01-15 00:00:00.000",
//                     "note": "note",
//                     "total": "10735.2",
//                     "exp_no": "#PUR0001"
//                   }
//           ]
//           }
//           """);
//         });
//
//         expect(sut.expense, []);
//         expect(sut.expensePlayer, []);
//         await sut.getAllExpense();
//         expect(sut.expense, isA<List<ExpenseModel>>());
//         expect(sut.expensePlayer, isA<List<ExpenseModel>>());
//       });
//
//       test("test the user is guest and the expense has the default data ",
//           () async {
//         //arrange
//         ConstApp.typeUser = "guest";
//         List<ExpenseModel> defaultValue = [
//           ExpenseModel(
//               id: 1,
//               date: DateTime.parse("2024-01-23 13:16:25.994494"),
//               note: "note",
//               total: 100,
//               expNo: "0111"),
//           ExpenseModel(
//               id: 2,
//               date: DateTime.parse("2024-01-23 13:16:25.994494"),
//               note: "note",
//               total: 100,
//               expNo: "0111"),
//           ExpenseModel(
//               id: 3,
//               date: DateTime.parse("2024-01-23 13:16:25.994494"),
//               note: "note",
//               total: 100,
//               expNo: "0111"),
//           ExpenseModel(
//               id: 4,
//               date: DateTime.parse("2024-01-23 13:16:25.994494"),
//               note: "note",
//               total: 100,
//               expNo: "0111"),
//         ];
//         //act
//         await sut.getAllExpense();
//         //assert
//         expect(sut.expense, defaultValue);
//         expect(sut.expense, sut.expensePlayer);
//         expect(sut.expensePlayer.length, 4);
//         expect(sut.totalExpense.value, 400);
//         expect(sut.totalPayment.value, 200);
//         expect(sut.totalReceipt.value, 200);
//       });
//     });
//
//     group("test getAllVoucher function", () {
//       test("if user is guest ,take default values for Voucher", () async {
//         //arrange
//         ConstApp.typeUser = "guest";
//         List<VoucherModel> defaultValue = [
//           VoucherModel(
//               id: 1,
//               date: DateTime.now(),
//               contact: "contact",
//               total: 100,
//               vouNo: "vouNo",
//               billId: ["1", "2"],
//               type: "Payment",
//               note: "note",
//               account: "account"),
//           VoucherModel(
//               id: 2,
//               date: DateTime.now(),
//               contact: "contact",
//               total: 100,
//               vouNo: "vouNo",
//               billId: ["1", "2"],
//               type: "Payment",
//               note: "note",
//               account: "account"),
//           VoucherModel(
//               id: 3,
//               date: DateTime.now(),
//               contact: "contact",
//               total: 100,
//               vouNo: "vouNo",
//               billId: ["1", "2"],
//               type: "receipt",
//               note: "note",
//               account: "account"),
//           VoucherModel(
//               id: 4,
//               date: DateTime.now(),
//               contact: "contact",
//               total: 100,
//               vouNo: "vouNo",
//               billId: ["1", "2"],
//               type: "receipt",
//               note: "note",
//               account: "account"),
//         ];
//         //act
//         sut.getAllVoucher();
//         // assert
//         expect(sut.voucher, defaultValue);
//         expect(sut.voucherPlayer, defaultValue);
//         expect(
//             sut.payment,
//             defaultValue
//                 .where((element) => element.type == 'Payment')
//                 .toList());
//         expect(
//             sut.receipt,
//             defaultValue
//                 .where((element) => element.type != "Payment")
//                 .toList());
//         expect(sut.dailyExpense.value, 200);
//         expect(sut.monthExpense.value, 200);
//         expect(sut.yearlyExpense.value, 200);
//         expect(sut.totalCash.value, 200);
//         expect(sut.totalVisa.value, 200);
//         expect(sut.totalP.value, 200);
//         expect(sut.totalE.value, 200);
//         expect(sut.totalV.value, 200);
//       });
//
//       test(
//           "test getAllVoucher has response statusCode 200  and get data type VoucherModel",
//           () async {
//         //arrange
//         ConstApp.typeUser = "";
//         when(() => mock.getDio(path: '/voucher')).thenAnswer((_) async {
//           return Response(
//               requestOptions: requestOptions,
//               data: """
//             {
//             "message":"Success",
//             "voucher":[]
//             }
//               """,
//               statusCode: 200);
//         });
//         //act
//         await sut.getAllVoucher();
//         //assert
//         expect(sut.voucher, isA<List<VoucherModel>>());
//         expect(sut.voucherPlayer, isA<List<VoucherModel>>());
//         expect(sut.payment, isA<List<VoucherModel>>());
//         expect(sut.receipt, isA<List<VoucherModel>>());
//       });
//
//       test("test getAllVoucher has response statusCode 500  and don't get data",
//           () async {
//         //arrange
//         ConstApp.typeUser = "";
//         when(() => mock.getDio(path: '/voucher')).thenAnswer((_) async {
//           return Response(
//               requestOptions: requestOptions, data: {}, statusCode: 500);
//         });
//         //act
//         await sut.getAllVoucher();
//         //assert
//         expect(sut.voucher, []);
//         expect(sut.voucherPlayer, []);
//         expect(sut.payment, []);
//         expect(sut.receipt, []);
//       });
//     });
//
//     group("test getAllBoxes function", () {
//       test("test the user is guest", () async {
//         //arrange
//         ConstApp.typeUser = "guest";
//         List<BoxModel> defaultValue = [
//           BoxModel(name: "name", id: 1, balance: 100, code: "code"),
//           BoxModel(name: "name", id: 2, balance: 100, code: "code"),
//           BoxModel(name: "name", id: 3, balance: 100, code: "code"),
//           BoxModel(name: "name", id: 4, balance: 100, code: "code"),
//         ];
//         //act
//         await sut.getAllBoxes();
//         ConstApp.typeUser = "";
//         // assert
//         expect(sut.box, defaultValue);
//       });
//       test("test function has response status code 200 and has data", () async {
//         //arrange
//         when(() => mock.getDio(path: '/box')).thenAnswer((_) async {
//           return Response(
//               requestOptions: requestOptions, statusCode: 200, data: """
//           {
//           "message":"Success",
//           "box":[]
//           }
//           """);
//         });
//         //act
//         sut.getAllBoxes();
//         //assert
//         expect(sut.box, isA<List<BoxModel>>());
//       });
//     });
//
//   });
// }

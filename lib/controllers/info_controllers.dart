import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izo_report/models/box_model.dart';
import 'package:izo_report/models/hall_model.dart';
import 'package:izo_report/models/purchase.dart';
import 'package:izo_report/models/table_model.dart';
import 'package:izo_report/screens/main/main_screen.dart';
import 'package:izo_report/utils/constants.dart';
import 'package:izo_report/models/information.dart';
import 'package:izo_report/server/dio_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bill_model.dart';
import '../models/expense_model.dart';
import '../models/voucher_model.dart';

class InfoController extends GetxController {
  RxList<BillModel> bills = RxList([]);
  RxList<BillModel> billsPlayer = RxList([]);
  RxList<HallModel> halls = RxList([]);
  RxList<PurchaseModel> purchase = RxList([]);
  RxList<PurchaseModel> purchasePlayer = RxList([]);
  RxList<ExpenseModel> expense = RxList([]);
  RxList<ExpenseModel> expensePlayer = RxList([]);
  RxList<VoucherModel> voucher = RxList([]);
  RxList<VoucherModel> voucherPlayer = RxList([]);
  RxList<VoucherModel> payment = RxList([]);
  RxList<VoucherModel> receipt = RxList([]);
  RxList<BoxModel> box = RxList([]);
  RxDouble totalSales = RxDouble(0);
  RxDouble subtotalSales = RxDouble(0);
  RxDouble totalPurchase = RxDouble(0);
  RxDouble subtotalPurchase = RxDouble(0);
  RxDouble totalExpense = RxDouble(0);
  RxDouble totalPayment = RxDouble(0);
  RxDouble totalReceipt = RxDouble(0);
  RxDouble total = RxDouble(0);
  RxDouble profit = RxDouble(0);
  RxDouble dailySales = RxDouble(0);
  RxDouble monthlySales = RxDouble(0);
  RxDouble yearlySales = RxDouble(0);
  RxDouble dailyPurchase = RxDouble(0);
  RxDouble monthPurchase = RxDouble(0);
  RxDouble yearPurchase = RxDouble(0);
  RxDouble dailyExpense = RxDouble(0);
  RxDouble monthExpense = RxDouble(0);
  RxDouble yearlyExpense = RxDouble(0);
  RxDouble totalS = 0.0.obs;
  RxDouble totalCash = 0.0.obs;
  RxDouble totalVisa = 0.0.obs;
  RxDouble totalP = 0.0.obs;
  RxDouble totalE = 0.0.obs;
  RxDouble totalV = 0.0.obs;
  RxList<Information> information = RxList([]);
  RxBool isLoading = false.obs;
  RxBool isLoadingHall = false.obs;
  RxBool isLoadingCheck = false.obs;
  RxBool isE = false.obs;
  RxString appType = ''.obs;

  Future<bool> getIzoReportInfo() async {
    if (ConstApp.typeUser == "guest") {
      totalPurchase.value = 100;
      subtotalPurchase.value = 100;
      dailyPurchase.value = 50;
      monthPurchase.value = 75;
      yearPurchase.value = 110;

      totalSales.value = 110;
      subtotalSales.value = 100;
      dailySales.value = 50;
      monthlySales.value = 75;
      yearlySales.value = 100;

      totalExpense.value = 200;
      dailyExpense.value = 100;
      monthExpense.value = 150;
      yearlyExpense.value = 200;

      totalPayment.value = 50;
      totalReceipt.value = 100;
      appType.value = 'REST';
      box.value = [
        BoxModel(name: "name", id: 1, balance: 100, code: "code"),
        BoxModel(name: "name", id: 2, balance: 100, code: "code"),
        BoxModel(name: "name", id: 3, balance: 100, code: "code"),
        BoxModel(name: "name", id: 4, balance: 100, code: "code"),
      ];
      halls.value = [
        HallModel(
          tables: [
            TableModel(
                number: '1',
                hall: '-1',
                voidAmount: 50,
                cost: 0,
                waitCustomer: false,
                time: DateTime.now(),
                bookingTable: false,
                bookingDate: DateTime.now())
          ],
          name: 'TakeAway',
          id: -1,
          tableCount: 2,
        ),
        HallModel(
          tables: [
            TableModel(
                number: '1',
                hall: '0',
                voidAmount: 50,
                cost: 0,
                waitCustomer: false,
                time: DateTime.now(),
                bookingTable: false,
                bookingDate: DateTime.now())
          ],
          name: 'Delivery',
          id: 0,
          tableCount: 1,
        ),
        HallModel(
          tables: [
            TableModel(
                number: '1',
                hall: '1',
                voidAmount: 50,
                cost: 50,
                waitCustomer: false,
                time: DateTime.now(),
                bookingTable: true,
                guestName: 'Test',
                bookingDate: DateTime.now())
          ],
          name: 'Outside',
          id: 1,
          tableCount: 5,
        )
      ];
      totalCash.value = 200;
      totalVisa.value = 200;
      totalP.value = 200;
      totalE.value = 200;
      totalV.value = 200;
      return true;
    } else {
      isLoadingHall(true);
      isLoading(true);
      String? deviceId = Get.find<SharedPreferences>().getString('deviceId');
      if (deviceId == null) {
        isLoadingHall(false);
        isLoading(false);
        return false;
      }
      DioClient dio = DioClient();
      try {
        var response = await dio.getDio(
            path: '/user-activation/pos-report?device_id=$deviceId');

        if (response.statusCode == 200) {
          var data = response.data['info'];
          totalPurchase.value =
              double.tryParse(data['total_purchase'].toString()) ?? 0.0;
          subtotalPurchase.value =
              double.tryParse(data['subtotal_purchase'].toString()) ?? 0.0;
          dailyPurchase.value =
              double.tryParse(data['daily_total_purchase'].toString()) ?? 0.0;
          monthPurchase.value =
              double.tryParse(data['monthly_total_purchase'].toString()) ?? 0.0;
          yearPurchase.value =
              double.tryParse(data['yearly_total_purchase'].toString()) ?? 0.0;

          totalSales.value =
              double.tryParse(data['total_sales'].toString()) ?? 0.0;
          subtotalSales.value =
              double.tryParse(data['subtotal_sales'].toString()) ?? 0.0;
          dailySales.value =
              double.tryParse(data['daily_total_sales'].toString()) ?? 0.0;
          monthlySales.value =
              double.tryParse(data['monthly_total_sales'].toString()) ?? 0.0;
          yearlySales.value =
              double.tryParse(data['yearly_total_sales'].toString()) ?? 0.0;

          totalExpense.value =
              double.tryParse(data['total_expense'].toString()) ?? 0.0;
          dailyExpense.value =
              double.tryParse(data['daily_total_expense'].toString()) ?? 0.0;
          monthExpense.value =
              double.tryParse(data['monthly_total_expense'].toString()) ?? 0.0;
          yearlyExpense.value =
              double.tryParse(data['yearly_total_expense'].toString()) ?? 0.0;

          totalPayment.value =
              double.tryParse(data['payment'].toString()) ?? 0.0;
          totalReceipt.value =
              double.tryParse(data['receipt'].toString()) ?? 0.0;
          box.clear();
          List allBox = data['box'];
          for (var i in allBox) {
            if ((double.tryParse(i['balance']) ?? 0.0) != 0.0) {
              box.add(BoxModel(
                  id: int.tryParse(i['id'].toString()) ?? 0,
                  name: i['name'],
                  balance: double.tryParse(i['balance'].toString()) ?? 0.0,
                  code: i['code']));
            }
          }
          halls.clear();
          appType.value = data['type'];
          List list1 = jsonDecode(data['hall']);
          for (var i in list1) {
            List listTable = jsonDecode(i['tables']);
            List<TableModel> listT = [];
            for (var j in listTable) {
              listT.add(TableModel(
                  number: j['number'],
                  hall: j['hall'],
                  voidAmount: double.tryParse(j['amount'].toString()) ?? 0.0,
                  cost: double.tryParse(j['cost'].toString()) ?? 0.0,
                  waitCustomer: bool.tryParse(j['wait'].toString()) ?? false,
                  time:
                      DateTime.tryParse(j['time'].toString()) ?? DateTime.now(),
                  bookingTable: bool.tryParse(j['booking'].toString()) ?? false,
                  bookingDate: DateTime.tryParse(j['booking-date'].toString()),
                  guestName: j['guest-name'],
                  deliveryName: j['driver-name']));
            }
            halls.add(HallModel(
              tables: listT,
              name: i["name"],
              id: int.tryParse(i['id'].toString()) ?? 0,
              tableCount: int.tryParse(i["table-count"].toString()) ?? 0,
            ));
          }
          isLoadingHall(false);
          isLoading(false);
          return true;
        } else {
          isLoadingHall(false);
          isLoading(false);
          Get.find<SharedPreferences>().remove('deviceId');
          return false;
        }
      } catch (e) {
        isLoadingHall(false);
        isLoading(false);
        Get.find<SharedPreferences>().remove('deviceId');
        print('ERROR getIzoReportInfo $e');
        return false;
      }
    }
  }

  Future<bool> getAllHalls() async {
    isLoadingHall(true);
    DioClient dio = DioClient();
    try {
      final response = await dio.getDio(path: '/info');
      if (response.statusCode == 200) {
        try {
          halls.clear();
          var data = json.decode(response.data);
          appType.value = data['type'];
          List list1 = jsonDecode(data['hall']);
          for (var i in list1) {
            List listTable = jsonDecode(i['tables']);
            List<TableModel> listT = [];
            for (var j in listTable) {
              listT.add(TableModel(
                  number: j['number'],
                  hall: j['hall'],
                  voidAmount: double.tryParse(j['amount']) ?? 0.0,
                  cost: double.tryParse(j['cost']) ?? 0.0,
                  waitCustomer: bool.tryParse(j['wait']) ?? false,
                  time: DateTime.tryParse(j['time']) ?? DateTime.now(),
                  bookingTable: bool.tryParse(j['booking']) ?? false,
                  bookingDate: DateTime.tryParse(j['booking-date']),
                  guestName: j['guest-name'],
                  deliveryName: j['driver-name']));
            }
            halls.add(HallModel(
              tables: listT,
              name: i["name"],
              id: int.tryParse(i['id'].toString()) ?? 0,
              tableCount: int.tryParse(i["table-count"]) ?? 0,
            ));
          }
          isLoadingHall(false);
          update();
          return true;
        } catch (e) {
          debugPrint('Error ====>$e');
          isLoadingHall(false);
          update();
          return false;
        }
      } else {
        debugPrint('Error');
        isLoadingHall(false);
        update();
        return false;
      }
    } catch (e) {
      isLoadingHall(false);
      return false;
    }
  }

  Future<bool> getAllBills() async {
    if (ConstApp.typeUser == "guest") {
      bills.clear();
      bills.value = [
        BillModel(
            id: 1,
            finalTotal: 300,
            visaAmount: 50,
            cashAmount: 50,
            hall: "1",
            table: "1",
            billNum: "0001",
            cashierName: "alaa",
            customerName: "alaa",
            date: DateTime.now(),
            subtotal: 90,
            type: "sales"),
        BillModel(
            id: 2,
            finalTotal: 300,
            visaAmount: 50,
            cashAmount: 50,
            hall: "1",
            table: "1",
            billNum: "0001",
            cashierName: "alaa",
            customerName: "alaa",
            date: DateTime.now(),
            subtotal: 90,
            type: "sales"),
        BillModel(
            id: 3,
            finalTotal: 300,
            visaAmount: 50,
            cashAmount: 50,
            hall: "1",
            table: "1",
            billNum: "0001",
            cashierName: "alaa",
            customerName: "alaa",
            date: DateTime.now(),
            subtotal: 90,
            type: "sales"),
        BillModel(
            id: 4,
            finalTotal: 300,
            visaAmount: 50,
            cashAmount: 50,
            hall: "1",
            table: "1",
            billNum: "0001",
            cashierName: "alaa",
            customerName: "alaa",
            date: DateTime.now(),
            subtotal: 90,
            type: "sales"),
      ];
      billsPlayer.value = bills;
      totalSales.value = 1200;
      subtotalSales.value = 1200;
      return true;
    } else {
      isLoading(true);
      DioClient dio = DioClient();
      totalSales.value = 0;
      subtotalSales.value = 0;
      try {
        final response = await dio.getDio(path: '/bills');
        if (response.statusCode == 200) {
          try {
            bills.clear();
            var data = json.decode(response.data);
            List list = data['bill'];
            for (var i in list) {
              bills.add(BillModel(
                  id: int.tryParse(i['id']) ?? 0,
                  finalTotal: double.tryParse(i['final-total']) ?? 0.0,
                  visaAmount: double.tryParse(i['visa-amount']) ?? 0.0,
                  cashAmount: double.tryParse(i['cash-amount']) ?? 0.0,
                  hall: i['hall'].toString(),
                  table: i['table'].toString(),
                  billNum: i['bill-number'],
                  cashierName: i['cashier-name'],
                  customerName: i['customer-name'],
                  date: DateTime.tryParse(i['date']) ?? DateTime.now(),
                  subtotal: double.tryParse(i['subtotal']) ?? 0.0,
                  type: i['type']));
              if (i['type'] == 'sales') {
                totalSales.value += double.tryParse(i['final-total']) ?? 0.0;
                subtotalSales.value += double.tryParse(i['subtotal']) ?? 0.0;
              } else {
                totalSales.value -= double.tryParse(i['final-total']) ?? 0.0;
                subtotalSales.value -= double.tryParse(i['subtotal']) ?? 0.0;
              }
            }
            billsPlayer.value = bills;
            getInformation();
            isLoading(false);
            update();
            return true;
          } catch (e) {
            getInformation();
            debugPrint('Error1 ====>$e');
            isLoading(false);
            update();
            return false;
          }
        } else {
          getInformation();
          debugPrint('Error');
          isLoading(false);
          update();
          return false;
        }
      } catch (e) {
        isLoading(false);
        return false;
      }
    }
  }

  getInformation() async {
    total.value = 0;
    // dailySales.value = 0;
    // monthlySales.value = 0;
    // yearlySales.value = 0;
    // if(ConstApp.typeUser == "guest"){}
    // else{}
    total.value = totalPayment.value +
        totalSales.value +
        totalPurchase.value +
        totalExpense.value;
    profit.value =
        subtotalSales.value - subtotalPurchase.value - totalExpense.value;
    if (total.value == 0) {
      total.value = 1;
    }
    information.value = [
      Information(
          color: primaryColor,
          title: 'Sales',
          percentage: ((totalSales.value / total.value) * 100).round(),
          total: totalSales.value),
      Information(
          color: const Color(0xFF26E5FF),
          title: 'Purchases',
          percentage: ((totalPurchase.value / total.value) * 100).round(),
          total: totalPurchase.value),
      Information(
          color: const Color(0xFFEE2727),
          title: 'Expenses',
          percentage: ((totalExpense.value / total.value) * 100).round(),
          total: totalExpense.value),
      Information(
        color: const Color(0xFFFFCF26),
        title: 'Voucher',
        percentage: ((totalPayment.value / total.value) * 100).round(),
        total: totalPayment.value,
        payment: totalPayment.value,
        receipt: totalReceipt.value,
      ),
    ];
    // for (var i in bills.where((p0) =>
    //     p0.date.day == DateTime.now().day &&
    //     p0.date.month == DateTime.now().month &&
    //     p0.date.year == DateTime.now().year)) {
    //   if (i.type == 'sales') {
    //     dailySales.value += i.finalTotal;
    //   } else {
    //     dailySales.value -= i.finalTotal;
    //   }
    // }
    // for (var i in bills.where((p0) =>
    //     p0.date.month == DateTime.now().month &&
    //     p0.date.year == DateTime.now().year)) {
    //   if (i.type == 'sales') {
    //     monthlySales.value += i.finalTotal;
    //   } else {
    //     monthlySales.value -= i.finalTotal;
    //   }
    // }
    // for (var i in bills.where((p0) => p0.date.year == DateTime.now().year)) {
    //   if (i.type == 'sales') {
    //     yearlySales.value += i.finalTotal;
    //   } else {
    //     yearlySales.value -= i.finalTotal;
    //   }
    // }
    update();
  }

  Future<bool> checkQR() async {
    isLoadingCheck(true);
    DioClient dio = DioClient();
    final response = await dio.getDio(path: '/check');
    if (response.statusCode == 200) {
      if (response.data.toString() == 'success') {
        isLoadingCheck(false);
        return true;
      } else {
        isLoadingCheck(false);
        return false;
      }
    } else {
      isLoadingCheck(false);
      return false;
    }
  }

  Future<bool> checkMobile() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    DioClient dio = DioClient();
    final response = await dio.postDio(
        path: '/check-mobile',
        // data1: {"product": "1111"});
        data1: {"product": '${androidInfo.product}:Report'});
    if (response.statusCode == 200) {
      if (response.data['message'] == 'success') {
        Get.find<SharedPreferences>().remove('deviceId');
        Get.find<SharedPreferences>()
            .setString('deviceId', response.data['deviceId']);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> signUp() async {
    DioClient dio = DioClient();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final data = {
      "name": androidInfo.brand,
      "device_id": '${androidInfo.product}:Report',
      "date": DateTime.now().toString()
    };
    final response = await dio.postDio(path: '/signup', data1: data);
    if (response.statusCode == 200) {
      Get.offAll(() => const MainScreen());
      Get.snackbar(
        'Success',
        'The Server Is Connected !!',
        backgroundColor: Colors.green,
        icon: const Icon(Icons.check),
      );
    } else {
      Get.back();
      print('Error');
    }
  }

  Future getAllPurchase() async {
    purchase.clear();
    if (ConstApp.typeUser == "guest") {
      purchase.value = [
        PurchaseModel(
            id: 1,
            supplier: "supplier",
            purNo: "purNo",
            finalTotal: 100,
            type: "type",
            date: DateTime.now(),
            payType: "payType"),
        PurchaseModel(
            id: 2,
            supplier: "supplier",
            purNo: "purNo",
            finalTotal: 100,
            type: "type",
            date: DateTime.now(),
            payType: "payType"),
        PurchaseModel(
            id: 3,
            supplier: "supplier",
            purNo: "purNo",
            finalTotal: 100,
            type: "type",
            date: DateTime.now(),
            payType: "payType"),
        PurchaseModel(
            id: 4,
            supplier: "supplier",
            purNo: "purNo",
            finalTotal: 100,
            type: "type",
            date: DateTime.now(),
            payType: "payType"),
      ];
      purchasePlayer.value = purchase;
      totalPurchase.value = 400;
      subtotalPurchase.value = 400;
      dailyPurchase.value = 400;
      monthPurchase.value = 400;
      yearPurchase.value = 400;
    } else {
      DioClient dio = DioClient();
      final response = await dio.getDio(path: '/purchase');
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List pur = data['purchase'];
        totalPurchase.value = double.tryParse(data['totalPurchase']) ?? 0.0;
        subtotalPurchase.value = double.tryParse(data['net-purchase']) ?? 0.0;
        dailyPurchase.value = double.tryParse(data['daily-purchase']) ?? 0.0;
        monthPurchase.value = double.tryParse(data['monthly-purchase']) ?? 0.0;
        yearPurchase.value = double.tryParse(data['yearly-purchase']) ?? 0.0;
        for (var i in pur) {
          purchase.add(PurchaseModel(
              id: int.tryParse(i['id']) ?? 0,
              supplier: i['contact'],
              purNo: i['pur_no'],
              finalTotal: double.tryParse(i['final_total']) ?? 0.0,
              type: i['type'],
              date: DateTime.tryParse(i['date']) ?? DateTime.now(),
              payType: i['pay_type']));
        }
        purchasePlayer.value = purchase;
      }
    }
    update();
  }

  Future getAllExpense() async {
    expense.clear();
    if (ConstApp.typeUser == "guest") {
      expense.value = [
        ExpenseModel(
            id: 1,
            date: DateTime.parse("2024-01-23 13:16:25.994494"),
            note: "note",
            total: 100,
            expNo: "0111"),
        ExpenseModel(
            id: 2,
            date: DateTime.parse("2024-01-23 13:16:25.994494"),
            note: "note",
            total: 100,
            expNo: "0111"),
        ExpenseModel(
            id: 3,
            date: DateTime.parse("2024-01-23 13:16:25.994494"),
            note: "note",
            total: 100,
            expNo: "0111"),
        ExpenseModel(
            id: 4,
            date: DateTime.parse("2024-01-23 13:16:25.994494"),
            note: "note",
            total: 100,
            expNo: "0111")
      ];
      expensePlayer.value = expense;
      totalExpense.value = 400;
      totalPayment.value = 200;
      totalReceipt.value = 200;
    } else {
      DioClient dio = DioClient();
      final response = await dio.getDio(path: '/expense');
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List pur = data['expense'];
        totalExpense.value = double.tryParse(data['totalExpense']) ?? 0.0;
        dailyExpense.value = double.tryParse(data['daily-expense']) ?? 0.0;
        monthExpense.value = double.tryParse(data['monthly-expense']) ?? 0.0;
        yearlyExpense.value = double.tryParse(data['yearly-expense']) ?? 0.0;
        for (var i in pur) {
          expense.add(ExpenseModel(
            id: int.tryParse(i['id']) ?? 0,
            date: DateTime.tryParse(i['date']) ?? DateTime.now(),
            note: i['note'],
            total: double.tryParse(i['total']) ?? 0.0,
            expNo: i['exp_no'],
          ));
        }
        expensePlayer.value = expense;
      }
    }
    update();
  }

  Future getAllVoucher() async {
    voucher.clear();
    if (ConstApp.typeUser == "guest") {
      voucher.value = [
        VoucherModel(
            id: 1,
            date: DateTime.now(),
            contact: "contact",
            total: 100,
            vouNo: "vouNo",
            billId: const ["1", "2"],
            type: "Payment",
            note: "note",
            account: "account"),
        VoucherModel(
            id: 2,
            date: DateTime.now(),
            contact: "contact",
            total: 100,
            vouNo: "vouNo",
            billId: const ["1", "2"],
            type: "Payment",
            note: "note",
            account: "account"),
        VoucherModel(
            id: 3,
            date: DateTime.now(),
            contact: "contact",
            total: 100,
            vouNo: "vouNo",
            billId: const ["1", "2"],
            type: "receipt",
            note: "note",
            account: "account"),
        VoucherModel(
            id: 4,
            date: DateTime.now(),
            contact: "contact",
            total: 100,
            vouNo: "vouNo",
            billId: const ["1", "2"],
            type: "receipt",
            note: "note",
            account: "account"),
      ];
      voucherPlayer.value = voucher;
      payment.value = voucher.where((p0) => p0.type == 'Payment').toList();
      receipt.value = voucher.where((p0) => p0.type != 'Payment').toList();
      dailyExpense.value = 200;
      monthExpense.value = 200;
      yearlyExpense.value = 200;
      totalCash.value = 200;
      totalVisa.value = 200;
      totalP.value = 200;
      totalE.value = 200;
      totalV.value = 200;
    } else {
      DioClient dio = DioClient();
      final response = await dio.getDio(path: '/voucher');
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List pur = data['voucher'];
        totalPayment.value = double.tryParse(data['payment']) ?? 0.0;
        totalReceipt.value = double.tryParse(data['receipt']) ?? 0.0;
        print(totalReceipt);
        for (var i in pur) {
          voucher.add(VoucherModel(
            id: int.tryParse(i['id']) ?? 0,
            date: DateTime.tryParse(i['date']) ?? DateTime.now(),
            note: i['note'],
            total: double.tryParse(i['amount']) ?? 0.0,
            vouNo: i['vou_no'],
            type: i['type'],
            account: i['account'],
            contact: i['contact'],
            billId: json.decode(i['bill_id']).cast<String>().toList(),
          ));
        }
        voucherPlayer.value = voucher;
        payment.value = voucher.where((p0) => p0.type == 'Payment').toList();
        receipt.value = voucher.where((p0) => p0.type != 'Payment').toList();
      }
    }
    update();
  }

  Future getAllBoxes() async {
    box.clear();
    if (ConstApp.typeUser == "guest") {
      box.value = [
        BoxModel(name: "name", id: 1, balance: 100, code: "code"),
        BoxModel(name: "name", id: 2, balance: 100, code: "code"),
        BoxModel(name: "name", id: 3, balance: 100, code: "code"),
        BoxModel(name: "name", id: 4, balance: 100, code: "code"),
      ];
    } else {
      DioClient dio = DioClient();
      final response = await dio.getDio(path: '/box');
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        List allBox = data['box'];
        for (var i in allBox) {
          if ((double.tryParse(i['balance']) ?? 0.0) != 0.0) {
            box.add(BoxModel(
                id: int.tryParse(i['id']) ?? 0,
                name: i['name'],
                balance: double.tryParse(i['balance']) ?? 0.0,
                code: i['code']));
          }
        }
      }
    }
    update();
  }
}

//
// import 'dart:async';
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:izo_report/controllers/internet_check_controller.dart';
// import 'package:mocktail/mocktail.dart';
//
// class InternetMock extends Mock implements InternetConnectionChecker{}
//
// void main(){
//
//   late INetworkInfo sut;
//   late InternetMock internetMock;
//
//   setUp((){
//     internetMock = InternetMock();
//     sut = INetworkInfo(internetMock);
//   });
//
//   group("test internet function for class INetworkInfo", () {
//     group("test function init", () {
//       test("test is connection true", () {
//
//         //arrange
//         when(()=>internetMock
//             .onStatusChange
//             .listen((InternetConnectionStatus status) {
//           switch (status) {
//             case InternetConnectionStatus.connected:
//               sut.connectionStatus.value = 1;
//               break;
//             case InternetConnectionStatus.disconnected:
//               sut.connectionStatus.value = 0;
//               break;
//           }
//         })).thenAnswer((_){
//               print("do it");
//               return StreamSubscription<InternetConnectionStatus>.value(null);
//         });
//         //act
//         sut.onInit();
//         //assert
//        expect(sut.connectionStatus.value, 0);
//       });
//     });
//   });
//
// }
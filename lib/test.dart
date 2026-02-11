// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:rxdart/rxdart.dart';

// class SingleMessageRx extends RxResponseInt<SingleMessageResponse> {
//   final api = SignleMessageApi.instance;
//   SingleMessageRx({required super.empty, required super.dataFetcher});
//   ValueStream get valueStreamData => dataFetcher.stream;

//   Future<bool> singleMessage({required int id}) async {
//     try {
//       SingleMessageResponse data = await api.singleMessage(id: id);
//       return await handleSuccessWithReturn(data);
//     } catch (error) {
//       log("eeee $error");
//       return await handleErrorWithReturn(error);
//     }
//   }

//   @override
//   handleSuccessWithReturn(data) async {
//     dataFetcher.sink.add(data);
//     return true;
//   }

//   @override
//   handleErrorWithReturn(error) async {
//     if (error is DioException) {
//       String message = error.response?.data["message"];
//       if (error.type == DioExceptionType.connectionError) {
//         message = "Check Your Network Connection";
//       }
//       await EasyLoading.showError(message);
//     }
//     return false;
//   }
// }









// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:moises/features_providers/provider_message/model/single_message_response.dart';
// import 'package:moises/networks/dio/dio.dart';
// import 'package:moises/networks/exception_handler/data_source.dart';
// import '/networks/endpoints.dart';

// class SignleMessageApi {
//   static final SignleMessageApi _singleton = SignleMessageApi._internal();
//   SignleMessageApi._internal();
//   static SignleMessageApi get instance => _singleton;

//   Future<SingleMessageResponse> singleMessage({required int id}) async {
//     try {


//       Response response = await getHttp(Endpoints.singleMessage(id: id));
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         SingleMessageResponse data = SingleMessageResponse.fromJson(response.data);
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       log("--------eeeeeeee-$error");
//       rethrow;
//     }
//   }
// }
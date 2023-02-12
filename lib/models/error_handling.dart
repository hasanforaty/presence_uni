import 'package:dio/dio.dart';

extension ErrorHandling<T> on Future<T> {
  Future<T> onInternetError() {
    return onError((error, stackTrace) {
      // non-200 error goes here.
      switch (error.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (error as DioError).response;
          print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          break;
      }
      return this;
    });
  }
}

void onInternetFunction(void Function() function) {
  try {
    function();
  } catch (error) {
    final res = (error as DioError).response;
    print("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
    print(res.toString());
  }
}

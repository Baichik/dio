import 'package:dio/dio.dart';

/// More examples see https://github.com/cfug/dio/blob/main/example
void main() async {
  final dio = Dio();
  dio.interceptors.add(
    CustomInterceptorsWrapper(
      onRefresh: (error) async {
        print('FUCK REFRESH');
        return true;
      },
      customPrint: (message) => print(message),
    ),
  );
  dio.interceptors.add(
    CustomInterceptorsWrapper(
      onResponse: (response, handler) {
        handler.reject(
          DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );
      },
    ),
  );
  await dio.get('https://pub.dev');
}

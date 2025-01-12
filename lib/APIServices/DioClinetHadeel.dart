import 'package:dio/dio.dart';
import 'package:hadeelalkori3/Config/constants.dart';
import 'package:hadeelalkori3/Controllers/LoginController.dart';
import 'package:get/get.dart';
import 'package:hadeelalkori3/Models/SubjectModels.dart';

class ApiService {
  final Dio dio = Dio();

// إضافة مستخدم جديد
Future<void> addUser(Courses user) async {
  try {
    await dio.post('https://jsonplaceholder.typicode.com/users', data: user.toJson());
  } catch (e) {
    throw Exception('Error adding user');
  }
}

// تعديل بيانات مستخدم
Future<void> updateUser(Courses user) async {
  try {
    await dio.put('https://jsonplaceholder.typicode.com/users/${user.id}', data: user.toJson());
  } catch (e) {
    throw Exception('Error updating user');
  }
}

// حذف مستخدم
Future<void> deleteUser(int id) async {
  try {
    await dio.delete('https://jsonplaceholder.typicode.com/users/$id');
  } catch (e) {
    throw Exception('Error deleting user');
  }
}
}

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseURL, // Replace with your API base URL
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 5000),
  ));

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print(options);
        // Add access token to headers
        final token = Get.find<LoginController>().accessToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        //print("aaaaaaaaaaaaaaaaaaaaaaaaa${e}");

        // Handle 401 errors (e.g., token expiration)
        if (e.response?.statusCode == 401) {
          Get.find<LoginController>().refreshToken();
        }
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
import 'package:hadeelalkori3/APIServices/DioClinetHadeel.dart';
import 'package:hadeelalkori3/Config/constants.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../Models/SubjectModels.dart';


class HomeController extends GetxController {
  var subject = <SubjectModel>[].obs;
  var courses = <Courses>[].obs;
  var updatedCourse = <Courses>[].obs;

  // Observable list of subjects

  var isLoading = true.obs; // Loading state

  final DioClient _dio = DioClient(); // Replace with your base URL

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();

    //CreatCourses();
  }

  // Fetch subjects from API
  Future<void> fetchSubjects() async {
    try {
      isLoading(true);
      final response = await _dio.dio.get(
          baseAPIURLV1 + subjectsAPI); // Replace with your endpoint

      if (response.statusCode == 200) {
        // Parse the response into a list of Subject objects
        subject.value = (response.data as List)
            .map((json) => SubjectModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch subjects",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  /*
  Future<void> CreatCourses() async {
    try {
      isLoading(true);
      final response = await _dio.dio.get(baseAPIURLV1+teachersAPIPost); // Replace with your endpoint

      if (response.statusCode == 200) {
        // Parse the response into a list of Subject objects
        courses.value = (response.data as List)
            .map((json) => Courses.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch subjects",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
Future<void> addData(dynamic newData) async{
  try{
    await _dio.dio.post(teachersAPIPost,data: newData);
  }
  catch(error){
    print('Error adding:$error');
  }
}*/

  Future<void> addSubject(Courses newSubject) async {
    try {
      isLoading(true);
      // إرسال طلب POST إلى API
      final response = await _dio.dio.post(
        baseAPIURLV1 + teachersAPIPost, // التأكد من صحة عنوان الـ API
        data: newSubject.toJson(), // تحويل الكائن إلى JSON باستخدام toJson
      );

      if (response.statusCode == 200) {
        courses.add(newSubject); // إضافة الكائن الجديد إلى القائمة
        Get.snackbar("Success", "Subject added successfully",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Failed to add subject",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }}




/*
Future<void> deleteSubject(int subjectId) async {
  try {
    isLoading(true);

    // إرسال طلب DELETE إلى API لحذف الكائن
    final response = await _dio.dio.delete(
      baseAPIURLV1 + 'courses/$subjectId', // استخدم الـ ID في الرابط لتحديد الكورس
    );

    if (response.statusCode == 200) {
      // حذف الكائن من القائمة المحلية
      courses.removeWhere((subject) => subject.id == subjectId);
      Get.snackbar("Success", "Subject deleted successfully", snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Failed to delete subject", snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM);
  } finally {
    isLoading(false);
  }
}
Future<void> deleteSubject(int subjectId) async {
  try {
    // تعيين isLoading إلى true أثناء إرسال الطلب
    isLoading.value = true;

    // إرسال طلب DELETE إلى API لحذف الكائن
    final response = await _dio.dio.delete(
      baseAPIURLV1 + 'courses/$subjectId', // استخدم الـ ID في الرابط لتحديد الكورس
    );

    // التحقق من استجابة السيرفر
    if (response.statusCode == 200) {
      // حذف الكائن من القائمة المحلية
      courses.removeWhere((subject) => subject.id == subjectId);
      Get.snackbar("Success", "Subject deleted successfully", snackPosition: SnackPosition.BOTTOM);
    } else {
      // إذا فشل الحذف
      Get.snackbar("Error", "Failed to delete subject", snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    // في حال حدوث خطأ
    Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM);
  } finally {
    // تعيين isLoading إلى false بعد الانتهاء
    isLoading.value = false;
  }
}import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> addData() async {
  final url = 'https://example.com/api/endpoint';  // ضع الرابط الفعلي لـ API هنا

  // بناء البيانات التي تريد إرسالها
  final data = {
    'title': 'New Course',
    'subject': 'Mathematics',
    'overview': 'An introductory course to Mathematics.',
  };

  // إرسال البيانات عبر POST
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        // أضف أي رؤوس تحتاجها مثل الـ Authorization إذا كانت مطلوبة
      },
      body: json.encode(data),  // تحويل البيانات إلى JSON
    );

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة (status 200)
      print('Data added successfully');
    } else {
      // في حالة فشل الطلب
      print('Failed to add data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}




  // تعديل موضوع
class ApiService {
  final Dio _dio = Dio();



  // تعديل موضوع
  Future<void> editSubject(Courses updatedSubject) async {
    try {
      // إرسال طلب PUT لتعديل الكائن
      final response = await _dio.put(
        baseAPIURLV1 + '$subjectsAPI/${updatedSubject.id}', // استخدم ID في الرابط
        data: updatedSubject.toJson(), // إرسال البيانات المعدلة
      );

      if (response.statusCode == 200) {
        // تحديث الكائن في القائمة المحلية
        int index = courses.indexWhere((subject) => subject.id == updatedSubject.id);
        if (index != -1) {
          courses[index] = updatedSubject; // تحديث الكائن في القائمة
        }
        Get.snackbar("Success", "Subject updated successfully", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Failed to update subject", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // حذف موضوع
  Future<void> deleteSubject(int index, int subjectId) async {
    try {
      final response = await _dio.delete(
        baseAPIURLV1 + '$subjectsAPI/$subjectId', // استخدم ID لحذف الموضوع
      );

      if (response.statusCode == 200) {
        subject.removeAt(index); // حذف الموضوع من القائمة
        Get.snackbar("Success", "Subject deleted successfully", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Failed to delete subject", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }*/

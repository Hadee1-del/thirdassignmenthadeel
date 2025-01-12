import 'package:flutter/material.dart';
import 'package:hadeelalkori3/Config/constants.dart';
import 'package:hadeelalkori3/Controllers/HomeController.dart';
import 'package:hadeelalkori3/Theme/Colors.dart';

import 'package:get/get.dart';

import '../Models/SubjectModels.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 10,
        shadowColor: primaryColor.withOpacity(0.5),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular( 30)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              primaryColor,
              secondaryColor,

            ],
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,

              ),
            );
          }

          if (controller.subject.isEmpty) {
            return const Center(
              child: Text(
                "No courses available.",
                style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.subject.length,
            itemBuilder: (_, index) {
              final subject = controller.subject[index];
              return AnimatedOpacity(
                opacity: controller.isLoading.value ? 0 : 1,
                duration: const Duration(milliseconds: 500),

                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      // Handle subject click
                      Get.snackbar(
                        subject.title,
                        "overview: ${subject.totalCourses}",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: backgroundColor,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),/*
                            child: Image.network(
                              "${baseURL + subject.photo}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.error,
                                    color: primaryColor,
                                  ),
                                );
                              },
                            ),*/
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subject.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "overview: ${subject.totalCourses}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),/*
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColor,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // إنشاء كائن جديد من Courses
                              Courses newCourse = Courses(
                                id: 1,
                                title: 'New Course',
                                subject: 'Mathematics',  // هذا هو الـ subject الذي ينتمي إليه الكورس
                                overview: 'An introductory course to Mathematics.',
                                photo: 'https://example.com/photo.jpg',
                                created: DateTime.now().millisecondsSinceEpoch,  // استخدام الوقت الحالي كـ created timestamp
                              );

                              // إضافة الكورس باستخدام دالة addSubject
                              homeController.addSubject(newCourse);
                            },
                            child: Text(''),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // إنشاء كائن جديد من Courses لتعديل البيانات
                              Courses updatedCourse = Courses(
                                id: 1,
                                title: 'Updated Course Title',
                                subject: 'Updated Subject',
                                overview: 'Updated Overview of the Course',
                                photo: 'https://example.com/updated_photo.jpg',
                                created: DateTime.now().millisecondsSinceEpoch,
                              );

                              // استدعاء دالة editSubject لتحديث الكورس
                              homeController.editSubject(updatedCourse);
                            },
                            child: Text(''),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              // استدعاء دالة deleteSubject لحذف الكورس
                              homeController.deleteSubject(1);  // حذف الكورس الذي لديه ID 1
                            },
                            child: Text(''),
                          )*/




                          ElevatedButton.icon(onPressed: (){ },icon: Icon(Icons.delete),label: Text(''),),
                          ElevatedButton.icon(onPressed: (){ },icon: Icon(Icons.edit),label: Text(''),)

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    floatingActionButton: Align(
       alignment: Alignment.bottomRight,  // وضع الزر في الجهة اليسرى
          child: FloatingActionButton(
           onPressed: () {
             // إنشاء كائن جديد من Courses
             Courses newCourse = Courses(
               id: 1,
               title: 'New Course',
               subject: 'Mathematics',  // هذا هو الـ subject الذي ينتمي إليه الكورس
               overview: 'An introductory course to Mathematics.',
               photo: 'https://example.com/photo.jpg',
               created: DateTime.now().millisecondsSinceEpoch,  // استخدام الوقت الحالي كـ created timestamp
             );

             // إضافة الكورس باستخدام دالة addSubject
             homeController.addSubject(newCourse);

             // وظيفة الزر عند الضغط عليه
    // هنا يمكنك إضافة الكود الخاص بالوظيفة التي تريدها
    },
        backgroundColor: primaryColor,
           child: const Icon(
             Icons.add,
               color: Colors.white,
        ),
       ),
      ),
    );
  }
}
import 'package:get/state_manager.dart';

class SubjectModel {
  final String title;
  final String slug;
  final String photo;
  final int totalCourses;

  SubjectModel({
    required this.title,
    required this.slug,
    required this.photo,
    required this.totalCourses,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      title: json['title'],
      slug: json['slug'],
      photo: json['photo'],
      totalCourses: json['total_courses'],
    );
  }
}

class Courses {

  final int id;
  final String title;
  final String subject;
  final String overview;
  final String photo;
  final int created;

  Courses({
    required this.id,
    required this.title,
    required this.subject,
    required this.overview,
    required this.photo,
    required this.created
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'overview': overview,
      'photo': photo,
      'created': created
    };
  }
}
// لإنشاء كائن Courses جديد بتعديلات جديدة
Courses updatedCourse = Courses(
  id: 1, // نفس الـ ID للكورس الذي تريد تعديله
  title: 'Updated Course Title',
  subject: 'Updated Subject',
  overview: 'Updated Overview of the Course',
  photo: 'https://example.com/updated_photo.jpg',
  created: DateTime.now().millisecondsSinceEpoch,
);

// استدعاء دالة editSubject لتحديث الكورس





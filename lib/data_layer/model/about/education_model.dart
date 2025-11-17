import 'package:flutter/material.dart';

class EducationModel {
  final String degree;
  final String field;
  final String institution;
  final String startYear;
  final String endYear;
  final String? cgpa; // Optional
  final List<String> relevantCoursework;
  final List<String> achievements;
  final Color accentColor;

  EducationModel({
    required this.degree,
    required this.field,
    required this.institution,
    required this.startYear,
    required this.endYear,
    this.cgpa,
    required this.relevantCoursework,
    required this.achievements,
    required this.accentColor,
  });

  /// Get duration string
  String get duration => '$startYear - $endYear';

  /// Get all education
  static List<EducationModel> getAllEducation() {
    return [
      EducationModel(
        degree: 'Bachelor of Science',
        field: 'Computer Science & Engineering (CSE)',
        institution: 'Bangladesh University of Business And Technology (BUBT)',
        startYear: '2018',
        endYear: '2022',
        cgpa: '3.18/4.0',
        relevantCoursework: [
          'Data Structures & Algorithms',
          'Object-Oriented Programming',
          'Database Management Systems',
          'Software Engineering',
          'Mobile Application Development',
          'Web Technologies',
          'Operating Systems',
          'Computer Networks',
        ],
        achievements: [
          'Graduated with focus on Mobile Development',
          'Completed capstone project on Flutter application',
          'Developed strong foundation in software engineering principles',
          'Gained expertise in cross-platform mobile development',
        ],
        accentColor: const Color(0xFF8B5CF6),
      ),

      // Add more degrees if you have (Masters, Diploma, etc.)
      // Example:
      // EducationModel(
      //   degree: 'High School Certificate',
      //   field: 'Science',
      //   institution: 'Your High School Name',
      //   startYear: '2016',
      //   endYear: '2018',
      //   cgpa: null,
      //   relevantCoursework: [],
      //   achievements: [],
      //   accentColor: const Color(0xFF3B82F6),
      // ),
    ];
  }
}

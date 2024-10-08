

import 'package:get/get.dart';
import '../model/Course.dart';

class GpaController extends GetxController {
  
  var courses = <Course>[].obs;
  var totalGpa = 0.0.obs;
  var cumulativeGpa = 0.0.obs;
  var previousGpa = 0.0.obs;
  var previousHours = 0.obs;
  var totalHours = 0.obs;
  var totalHoursall= 0.obs;
  RxBool resizeToAvoidBottomInset=RxBool(false);
  @override
  void onInit() {
    super.onInit();
    addCourse();
     
  }

  void addCourse() {
    courses.add(Course(
      grade: 4.0.obs,
      hours: 0.obs,
      courseName: ''.obs,
    ));
    calculateGpa();
  }

  void removeCourse(int index) {
    courses.removeAt(index);
    calculateGpa();
  }

void calculateGpa() {

    double totalQualityPoints = 0.0;
    int totalCreditHours = 0;

    for (var course in courses) {
      totalQualityPoints += course.grade.value * course.hours.value;
      totalCreditHours += course.hours.value;
    }

    // تعيين إجمالي الساعات المعتمدة بشكل صحيح
    totalHours.value = totalCreditHours;

    totalGpa.value = totalCreditHours > 0 ? totalQualityPoints / totalCreditHours : 0.0;

    double totalQualityPointsCumulative = (previousGpa.value * previousHours.value) + totalQualityPoints;
    int totalCreditHoursCumulative = previousHours.value + totalCreditHours;

    cumulativeGpa.value = totalCreditHoursCumulative > 0 ? totalQualityPointsCumulative / totalCreditHoursCumulative : 0.0;
}

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpa_calculator/controller/gpa_controller.dart';

class GpaCalculatorView extends StatelessWidget {
  final GpaController controller = Get.put(GpaController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  GpaCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: controller.resizeToAvoidBottomInset.value,
      appBar: AppBar(
        title: Text('gpa_calculator'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: controller.courses.length,
                  itemBuilder: (context, index, animation) {
                    final hoursController = TextEditingController(
                      text: controller.courses[index].hours.value.toString(),
                    );

                    return SizeTransition(
                      sizeFactor: animation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 224, 178),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '#${index + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  onTap: () {
                                    controller.resizeToAvoidBottomInset.value =
                                        false;
                                  },
                                  decoration: InputDecoration(
                                     border: const OutlineInputBorder(),
                                    labelText: 'course'.tr,
                                     labelStyle: TextStyle(color: Colors.black),
                                    fillColor: Colors.deepOrangeAccent,
                                    focusColor: Colors.pink,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepOrangeAccent)),
                                  ),
                                  onChanged: (value) {
                                    controller.courses[index].courseName.value =
                                        value;
                                  },
                                ),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  width: 120,
                                  child: Obx(
                                    () => DropdownButtonFormField<double>(
                                      value:
                                          controller.courses[index].grade.value,
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                        labelText: 'grade'.tr,
                                       labelStyle: TextStyle(color: Colors.black),
                                    fillColor: Colors.deepOrangeAccent,
                                    focusColor: Colors.pink,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepOrangeAccent)),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                            value: 4.0,
                                            child: Text('grade_A_plus'.tr)),
                                        DropdownMenuItem(
                                            value: 3.75,
                                            child: Text('grade_A'.tr)),
                                        DropdownMenuItem(
                                            value: 3.5,
                                            child: Text('grade_B_plus'.tr)),
                                        DropdownMenuItem(
                                            value: 3.0,
                                            child: Text('grade_B'.tr)),
                                        DropdownMenuItem(
                                            value: 2.5,
                                            child: Text('grade_C_plus'.tr)),
                                        DropdownMenuItem(
                                            value: 2.0,
                                            child: Text('grade_C'.tr)),
                                        DropdownMenuItem(
                                            value: 1.5,
                                            child: Text('grade_D_plus'.tr)),
                                        DropdownMenuItem(
                                            value: 1.0,
                                            child: Text('grade_D'.tr)),
                                        DropdownMenuItem(
                                            value: 0.0,
                                            child: Text('grade_F'.tr)),
                                      ],
                                      onChanged: (value) {
                                        controller.courses[index].grade.value =
                                            value ?? 0.0;
                                        controller.calculateGpa();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  width: 70,
                                  child: TextFormField(
                                    onTap: () {
                                      controller.resizeToAvoidBottomInset
                                          .value = false;
                                    },
                                    controller: hoursController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: 'hours'.tr,
                                      border: const OutlineInputBorder(),
                                      labelStyle: TextStyle(color: Colors.black),
                                    fillColor: Colors.deepOrangeAccent,
                                    focusColor: Colors.pink,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepOrangeAccent)),
                                    ),
                                    onChanged: (value) {
                                      final int? newHours = int.tryParse(value);
                                      if (newHours != null && newHours >= 0) {
                                        controller.courses[index].hours.value =
                                            newHours;
                                        controller.calculateGpa();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              if (index != 0)
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _removeCourse(index);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
             
              const Divider(),
              Card(
                color: const Color.fromARGB(255, 255, 224, 178),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: widthScreen / 1.5,
                        child: TextFormField(
                          onTap: () {
                            controller.resizeToAvoidBottomInset.value = true;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'previous_gpa'.tr,
                              labelStyle: const TextStyle(fontSize: 15)),
                          onChanged: (value) {
                            final double? newGpa = double.tryParse(value);
                            if (newGpa != null &&
                                newGpa >= 0 &&
                                newGpa <= 4.0) {
                              controller.previousGpa.value = newGpa;
                              controller.calculateGpa();
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        width: widthScreen / 1.5,
                        child: TextFormField(
                          onTap: () {
                            controller.resizeToAvoidBottomInset.value = true;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'previous_hours'.tr,
                              labelStyle: const TextStyle(fontSize: 15)),
                          onChanged: (value) {
                            final int? newHours = int.tryParse(value);
                            if (newHours != null && newHours >= 0) {
                              controller.previousHours.value = newHours;
                              controller.calculateGpa();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${'semester_hours'.tr}: ${controller.totalHours}'),
                      Text(
                          '${'semester_gpa'.tr}: ${controller.totalGpa.toStringAsFixed(2)}'),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${'cumulative_hours'.tr} ${controller.previousHours.value + controller.totalHours.value}'),
                      Text(
                          '${'cumulative_gpa'.tr}: ${controller.cumulativeGpa.toStringAsFixed(2)}'),
                    ],
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addCourse();
                },
                child: Text('add_course'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCourse() {
    controller.addCourse();
    _listKey.currentState?.insertItem(controller.courses.length - 1);
  }

  void _removeCourse(int index) {
    var removedCourse = controller.courses[index];
    controller.removeCourse(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            color: const Color.fromARGB(255, 255, 224, 178),
            child: ListTile(
              title: Text(removedCourse.courseName.value),
            ),
          ),
        );
      },
    );
  }
}

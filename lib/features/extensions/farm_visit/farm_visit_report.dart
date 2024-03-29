// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/farm_controller.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/gradient_widget.dart';
import '../confirm_farm_info.dart';

class FarmVisitReport extends StatefulWidget {
  const FarmVisitReport({Key? key, required this.extensionServiceId})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final extensionServiceId;

  @override
  State<FarmVisitReport> createState() => _FarmVisitReportState();
}

enum AgeTypes { DAYS, WEEKS, MONTHS }

enum BirdTypes { BROILERS, LAYERS, KIENYEJI }

class _FarmVisitReportState extends State<FarmVisitReport> {
  final controller = Get.find<FarmsController>();
  final _farmInfoFormKey = GlobalKey<FormBuilderState>();
  late var filteredList = List.from(controller.requestsList
      .where((element) => element["id"] == widget.extensionServiceId));
  late String farmName = filteredList.first["farm"]["name"];
  late String? county =
      filteredList[0]["farm"]["address"]["county"] ?? "Kisumu";
  late String? subCounty =
      filteredList[0]["farm"]["address"]["subcounty"] ?? "Kisumu East";
  late DateTime dateTime =
      DateTime.parse(filteredList[0]["farmVisit"]["visitDate"]);
  late String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

  BirdTypes? birdType;
  AgeTypes? ageType;
  final farmOfficerContact = TextEditingController();
  final farmAssistantContact = TextEditingController();
  final age = TextEditingController();
  final birdsDelivered = TextEditingController();
  final birdsRemaining = TextEditingController();
  final mortality = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Farm Information',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Farm Name:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          farmName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Farm Location:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          '$county, $subCounty',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date of Visit:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          formattedDate,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Form(
                      key: _farmInfoFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: farmOfficerContact,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Farm Officer Contact",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          TextFormField(
                            controller: farmAssistantContact,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Farm Assistant Contact",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          DropdownButtonFormField<BirdTypes>(
                            // Initial Value
                            // key: UniqueKey(),
                            value: birdType,
                            isExpanded: true,
                            elevation: 0,
                            decoration: InputDecoration(
                                hintText: "--select--",
                                labelText: "Breed",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),

                            onChanged: (val) {
                              setState(() {
                                birdType = val;
                              });
                            },
                            items: BirdTypes.values.map((BirdTypes birdType) {
                              return DropdownMenuItem<BirdTypes>(
                                value: birdType,
                                child: Text(birdType.name.toString()),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: age,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Age",
                                      labelStyle: TextStyle(
                                          fontSize: 2.2.h,
                                          color: CustomColors.secondary),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary))),
                                ),
                              ),
                              const SizedBox(
                                width: CustomSpacing.s3,
                              ),
                              Expanded(
                                child: DropdownButtonFormField<AgeTypes>(
                                  // Initial Value
                                  // key: UniqueKey(),
                                  value: ageType,
                                  isExpanded: true,
                                  elevation: 0,
                                  decoration: InputDecoration(
                                      hintText: "--select--",
                                      labelText: "Days/Weeks/Months",
                                      labelStyle: TextStyle(
                                          fontSize: 2.2.h,
                                          color: CustomColors.secondary),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.3.w,
                                              color: CustomColors.secondary))),

                                  onChanged: (value) {
                                    setState(() {
                                      ageType = value;
                                    });
                                  },
                                  items:
                                      AgeTypes.values.map((AgeTypes ageType) {
                                    return DropdownMenuItem<AgeTypes>(
                                      value: ageType,
                                      child: Text(ageType.name.toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          TextFormField(
                            controller: birdsDelivered,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Number of Birds Delivered",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          TextFormField(
                            controller: mortality,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Mortality",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          TextFormField(
                            controller: birdsRemaining,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Number of Birds Remaining",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            _farmInfoFormKey.currentState?.save();

                            controller.farmVisitReport["data"]![
                                    "extensionServiceId"] =
                                widget.extensionServiceId!;
                            (controller.farmVisitReport["data"]![
                                    "farmInformation"] as Map)["ageType"](
                                ageType.toString().split('.').last);

                            (controller
                                    .farmVisitReport["data"]!["farmInformation"]
                                as Map)["birdAge"](int.parse(age.text));

                            (controller.farmVisitReport["data"]![
                                    "farmInformation"] as Map)["birdType"](
                                birdType.toString().split('.').last);

                            (controller.farmVisitReport["data"]![
                                        "farmInformation"]
                                    as Map)["deliveredBirdCount"](
                                int.parse(birdsDelivered.text));

                            (controller.farmVisitReport["data"]![
                                        "farmInformation"]
                                    as Map)["farmAssistantContact"](
                                farmAssistantContact.text);

                            (controller.farmVisitReport["data"]![
                                        "farmInformation"]
                                    as Map)["farmOfficerContact"](
                                farmOfficerContact.text);
                            (controller
                                    .farmVisitReport["data"]!["farmInformation"]
                                as Map)["mortality"](int.parse(mortality.text));
                            (controller.farmVisitReport["data"]![
                                        "farmInformation"]
                                    as Map)["remainingBirdCount"](
                                int.parse(birdsRemaining.text));
                            // if (_farmInfoFormKey.currentState?.validate()) {
                            Get.to(() => ConfirmFarmInformation());
                            // }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const ConfirmFarmInformation(),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: CustomColors.background,
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
                              fixedSize: Size(100.w, 6.h)),
                          child: const Text('PROCEED')),
                    ),
                  ])),
        ));
  }
}

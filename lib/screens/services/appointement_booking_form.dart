import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/models/center.dart';
import 'package:najran/models/city.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/models/department.dart';
import 'package:najran/models/request_type.dart';
import 'package:najran/screens/services/cubit/cubit.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:najran/widgets/form/phone_field.dart';
import 'package:najran/widgets/multiselect_dropdown.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class SelectedFile {
  final String name;
  final String base64Data;

  SelectedFile({required this.name, required this.base64Data});
}

class AppointementBookingForm extends StatefulWidget {
  const AppointementBookingForm({super.key});

  @override
  State<AppointementBookingForm> createState() =>
      _AppointementBookingFormState();
}

class _AppointementBookingFormState extends State<AppointementBookingForm> {
  bool _isLoading = false;
  String _selectedType = "individuals";
  String? _selectedAppointmentLocation;

  final OdooApiService _apiService = OdooApiService();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final entryNumberController = TextEditingController();
  final adressController = TextEditingController();
  final relativeAdressController = TextEditingController();
  final visitReasonController = TextEditingController();
  final gouvermentSectoreController = TextEditingController();
  final privateSectoreController = TextEditingController();
  final commercialRegisterController = TextEditingController();
  final subjectController = TextEditingController();

  final deceasedNameController = TextEditingController();
  final deceasedPassportController = TextEditingController();

  // Map pour tous les fichiers
  final Map<String, SelectedFile> _files = {};

  bool _agreeDataAccuracy = false;
  bool _agreePrivacyPolicy = false;

  @override
  void initState() {
    super.initState();
    final currentUser = CurrentUserHolder.instance.user;
    if (currentUser != null) {
      nameController.text = currentUser.name;
      emailController.text = currentUser.email;
      phoneController.text = currentUser.phone;
      adressController.text = currentUser.commercialCompany ?? "";
      idController.text = currentUser.identityNumber ?? "";
    }
  }

  Future<void> _pickFile(String key) async {
    final result = await FilePicker.platform.pickFiles(withData: true);

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();
      final base64Data = base64Encode(bytes);

      _files[key] = SelectedFile(name: file.name, base64Data: base64Data);
      setState(() {}); // Rafraîchir l'UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CityCubit>(
      create: (context) => CityCubit(odooApiService: _apiService)..init(),
      child: BlocConsumer<CityCubit, CityState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<CityCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: NajranScaffold(
              currentIndex: 2,
              title: "خدمة طلب موعد",
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "النوع *",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: [
                              RadioListTile<String>(
                                title: const Text("أفراد"),
                                value: "individuals",
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                              RadioListTile<String>(
                                title: const Text("قطاع عام"),
                                value: "government_sector",
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                              RadioListTile<String>(
                                title: const Text("قطاع خاص"),
                                value: "private_sector",
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value!;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (_selectedType == "individuals" ||
                              _selectedType == "government_sector" ||
                              _selectedType == "private_sector") ...[
                            if (_selectedType == "private_sector") ...[
                              LabeledField(
                                label: "إسم الشركة",
                                controller: privateSectoreController,
                                required: true,
                              ),
                              LabeledField(
                                label: "السجل التجاري",
                                controller: commercialRegisterController,
                                required: true,
                              ),
                            ],
                            if (_selectedType == "government_sector") ...[
                              LabeledField(
                                label: "إسم القطاع الحكومي",
                                controller: gouvermentSectoreController,
                                required: true,
                              ),
                            ],
                            LabeledField(
                              label: _selectedType == "government_sector"
                                  ? 'إسم منسق القطاع'
                                  : _selectedType == "private_sector"
                                  ? 'إسم منسق الشركة '
                                  : 'إسم مقدم الطلب',
                              controller: nameController,
                              required: true,
                            ),
                            LabeledField(
                              label: 'رقم الهوية',
                              controller: idController,
                              required: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال رقم الهوية";
                                }
                                const arabicToEnglish = {
                                  '٠': '0',
                                  '١': '1',
                                  '٢': '2',
                                  '٣': '3',
                                  '٤': '4',
                                  '٥': '5',
                                  '٦': '6',
                                  '٧': '7',
                                  '٨': '8',
                                  '٩': '9',
                                };
                                String normalized = value
                                    .split('')
                                    .map((c) => arabicToEnglish[c] ?? c)
                                    .join();
                                final digitsOnly = normalized.replaceAll(
                                  RegExp(r'\D'),
                                  '',
                                );
                                if (digitsOnly.length != 10) {
                                  return "رقم الهوية يجب أن يحتوي على 10 أرقام";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            NumberField(
                              label: 'رقم الهاتف الجوال',
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال رقم الهاتف";
                                }
                                const arabicToEnglish = {
                                  '٠': '0',
                                  '١': '1',
                                  '٢': '2',
                                  '٣': '3',
                                  '٤': '4',
                                  '٥': '5',
                                  '٦': '6',
                                  '٧': '7',
                                  '٨': '8',
                                  '٩': '9',
                                };
                                String normalized = value
                                    .split('')
                                    .map((c) => arabicToEnglish[c] ?? c)
                                    .join();
                                final digitsOnly = normalized.replaceAll(
                                  RegExp(r'\D'),
                                  '',
                                );
                                if (digitsOnly.length != 9) {
                                  return "رقم الهاتف يجب أن يحتوي على 9 أرقام";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            LabeledField(
                              label: "البريد الإلكتروني",
                              controller: emailController,
                            ),
                            const SizedBox(height: 16),

                            const Text(
                              "مقر الموعد *",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedAppointmentLocation,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "emirate_diwan",
                                  child: Text("ديوان الإمارة"),
                                ),
                                DropdownMenuItem(
                                  value: "governorates",
                                  child: Text("المحافظات"),
                                ),
                                DropdownMenuItem(
                                  value: "affiliate_centers",
                                  child: Text(
                                    "المراكز الداخلية المرتبطة بديوان الامارة",
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedAppointmentLocation = value!;
                                });
                              },
                              validator: (value) => value == null
                                  ? "الرجاء اختيار موقع الموعد"
                                  : null,
                            ),
                            SizedBox(height: 16),
                            if (_selectedAppointmentLocation ==
                                "emirate_diwan") ...[
                              const Text(
                                "نوع الموعد* ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<RequestType>(
                                value: cubit.selectedRequestType,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                items: cubit.requestTypes.map((requestType) {
                                  return DropdownMenuItem<RequestType>(
                                    value: requestType,
                                    child: Text(requestType.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null)
                                    cubit.selectRequestType(value);
                                },
                                validator: (value) => value == null
                                    ? " الرجاء اختيار نوع الموعد"
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              if (cubit.selectedRequestType?.name ==
                                  "موعد مع ادارة محددة من الإمارة") ...[
                                const Text(
                                  "جهة الموعد *",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<DepartmentModel>(
                                  value: cubit.selectedDepartment,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                  ),
                                  items: cubit.departments.map((department) {
                                    return DropdownMenuItem<DepartmentModel>(
                                      value: department,
                                      child: Text(department.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null)
                                      cubit.selectDepartment(value);
                                  },
                                  validator: (value) => value == null
                                      ? " الرجاء اختيار جهة الموعد"
                                      : null,
                                ),
                              ],
                            ],
                            if (_selectedAppointmentLocation ==
                                "governorates") ...[
                              Text(
                                "نوع الموعد *",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Autocomplete<CityModel>(
                                optionsBuilder: (TextEditingValue value) async {
                                  if (value.text.isEmpty)
                                    return const Iterable<CityModel>.empty();
                                  await cubit.fetchCities(value.text);
                                  return cubit.cities;
                                },
                                displayStringForOption: (CityModel option) =>
                                    option.name,
                                fieldViewBuilder:
                                    (context, controller, focusNode, onSubmit) {
                                      cubit.searchController = controller;

                                      // Listener pour réinitialiser si le texte ne correspond pas à une sélection
                                      controller.addListener(() {
                                        if (cubit.selectedCity?.name !=
                                            controller.text) {
                                          cubit.selectCity(null);
                                        }
                                      });

                                      return TextFormField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          hintText: "أدخل المدينة",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                        ),
                                        validator: (_) {
                                          return cubit.selectedCity == null
                                              ? "الرجاء اختيار المدينة من القائمة"
                                              : null;
                                        },
                                      );
                                    },
                                onSelected: (CityModel city) =>
                                    cubit.selectCity(city),
                                optionsViewBuilder:
                                    (context, onSelected, options) {
                                      return Material(
                                        elevation: 4,
                                        child: SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              final city = options.elementAt(
                                                index,
                                              );
                                              return ListTile(
                                                title: Text(city.name),
                                                onTap: () => onSelected(city),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            ],
                            if (_selectedAppointmentLocation ==
                                "affiliate_centers") ...[
                              Text(
                                "نوع الموعد *",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Autocomplete<CenterModel>(
                                optionsBuilder: (TextEditingValue value) async {
                                  if (value.text.isEmpty)
                                    return const Iterable<CenterModel>.empty();
                                  await cubit.fetchCenters(
                                    value.text,
                                  ); // 🔹 Appel à ton Cubit
                                  return cubit.centers;
                                },
                                displayStringForOption: (CenterModel option) =>
                                    option.name,
                                fieldViewBuilder:
                                    (context, controller, focusNode, onSubmit) {
                                      cubit.searchController = controller;

                                      controller.addListener(() {
                                        if (cubit.selectedCenter?.name !=
                                            controller.text) {
                                          cubit.selectCenter(null);
                                        }
                                      });

                                      return TextFormField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          hintText: "أدخل المركز",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                        ),
                                        validator: (_) {
                                          return cubit.selectedCenter == null
                                              ? "الرجاء اختيار المركز من القائمة"
                                              : null;
                                        },
                                      );
                                    },
                                onSelected: (CenterModel center) {
                                  cubit.selectCenter(center);
                                },
                                optionsViewBuilder:
                                    (context, onSelected, options) {
                                      return Material(
                                        elevation: 4,
                                        child: SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              final center = options.elementAt(
                                                index,
                                              );
                                              return ListTile(
                                                title: Text(center.name),
                                                onTap: () => onSelected(center),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            ],
                            const SizedBox(height: 16),
                            LabeledField(
                              label: "الموضوع",
                              controller: subjectController,
                              required: true,
                            ),
                            const SizedBox(height: 16),
                            LabeledField(
                              label: "سبب الزيارة",
                              controller: visitReasonController,
                              required: true,
                              maxLines: 4,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "مرفقات الموعد",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFilePickerButton("اختر ملف", "appointment"),
                            const SizedBox(height: 16),
                            const Text(
                              "مرفقات الزائر",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            MultiSelectDropdown(
                              belongings: cubit.belogings,
                              selectedBelongings: cubit.selectedBelongings!,
                              onSelectionChanged: (selected) {
                                cubit.updateSelectedBelongings(selected);
                              },
                            ),
                          ],
                          SizedBox(height: 16),
                          CheckboxListTile(
                            value: _agreeDataAccuracy,
                            onChanged: (val) {
                              setState(() => _agreeDataAccuracy = val ?? false);
                            },
                            title: const Text(
                              "أقر وأتعهد بصحة البيانات المقدمة وفي حال عدم صحتها سوف تتم إحالتي لجهة الاختصاص لتطبيق النظام بحقي.",
                              style: TextStyle(fontSize: 13),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            value: _agreePrivacyPolicy,
                            onChanged: (val) {
                              setState(
                                () => _agreePrivacyPolicy = val ?? false,
                              );
                            },
                            title: const Text(
                              "أقر بأنني قرأت إشعار سياسة الخصوصية واطلعت على جميع البنود الواردة فيه وأوافق على جمع ومشاركة جميع بياناتي الشخصية وفق ما ينص عليه إشعار الخصوصية ( سياسة الخصوصية )",
                              style: TextStyle(fontSize: 13),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (!_agreeDataAccuracy ||
                                    !_agreePrivacyPolicy) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "⚠️ يجب الموافقة على جميع التعهدات",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                List<Map<String, String>>? fileData(
                                  String key,
                                ) {
                                  final f = _files[key];
                                  return f != null
                                      ? [
                                          {
                                            "name": f.name,
                                            "datas": f.base64Data,
                                          },
                                        ]
                                      : null;
                                }

                                final data = {
                                  "request_type_id": cubit
                                      .selectedRequestType
                                      ?.id
                                      .toString(),
                                  "destination_type": _selectedType,
                                  "visit_destination_id": cubit
                                      .selectedDepartment
                                      ?.id
                                      .toString(),
                                  "visit_reason": visitReasonController.text,
                                  "visit_text": subjectController.text,
                                  "government_sector_name":
                                      gouvermentSectoreController.text,
                                  "company": privateSectoreController.text,
                                  "commercial_register":
                                      commercialRegisterController.text,
                                  "dead_ar_first": deceasedNameController.text,
                                  "dead_ar_family": "",
                                  "dead_ar_father": "",
                                  "dead_ar_grand": "",
                                  "country_id": cubit.selectedCountry != null
                                      ? cubit.selectedCountry!.id.toString()
                                      : "",
                                  "country_state_id": cubit.selectedCity != null
                                      ? cubit.selectedCity!.id.toString()
                                      : '',

                                  "affiliate_center_id":
                                      cubit.selectedCenter != null
                                      ? cubit.selectedCenter!.id.toString()
                                      : "",
                                  "applicant_phone": phoneController.text,
                                  "applicant_identity": idController.text,
                                  "applicant_email": emailController.text,
                                  "appointment_location":
                                      _selectedAppointmentLocation,
                                  "appointment_belonging_ids": cubit
                                      .selectedBelongings!
                                      .map((b) => b.id)
                                      .toList(),
                                  "appointment_attachment_ids": fileData(
                                    'appointment',
                                  ),
                                };
                                setState(() => _isLoading = true);
                                final success = await _apiService
                                    .sendFormulaire(
                                      context: context,
                                      endpoint: "/mobile/appointment/request",
                                      data: data,
                                    );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? "✅ تم إرسال الطلب بنجاح"
                                          : "❌ فشل إرسال الطلب",
                                    ),
                                  ),
                                );
                                setState(() => _isLoading = false);
                              }
                            },
                            child: const Text("إرسال"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      color: Colors.black.withOpacity(0.4),
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilePickerButton(String text, String key) {
    final file = _files[key];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: () => _pickFile(key),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          file?.name ?? "لا يوجد ملف مختار",
          style: TextStyle(
            color: (file == null) ? Colors.red : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

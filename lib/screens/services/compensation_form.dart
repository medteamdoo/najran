import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/models/aggrieved_place.dart';
import 'package:najran/models/center.dart';
import 'package:najran/models/compensation_reason.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/models/city.dart';
import 'package:najran/screens/services/cubit/cubit.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:najran/widgets/form/phone_field.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class SelectedFile {
  final String name;
  final String base64Data;

  SelectedFile({required this.name, required this.base64Data});
}

class CompensationForm extends StatefulWidget {
  const CompensationForm({super.key});

  @override
  State<CompensationForm> createState() => _CompensationFormState();
}

class _CompensationFormState extends State<CompensationForm> {
  bool _isLoading = false;

  final OdooApiService _apiService = OdooApiService();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final entryNumberController = TextEditingController();
  final adressController = TextEditingController();
  final relativeAdressController = TextEditingController();

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
              title: "خدمة طلب تعويض أضرار",
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LabeledField(
                            label: 'إسم مقدم الطلب',
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

                              // Convertir les chiffres arabes en chiffres occidentaux
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

                              // Remplacer les chiffres arabes
                              String normalized = value
                                  .split('')
                                  .map((c) => arabicToEnglish[c] ?? c)
                                  .join();

                              // Garde seulement les chiffres
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
                          const Text(
                            "نسخة من الهوية *",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFilePickerButton("اختر ملف", "id"),
                          const SizedBox(height: 16),
                          NumberField(
                            label: 'رقم الهاتف الجوال',
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال رقم الهاتف";
                              }

                              // Convertir les chiffres arabes en chiffres occidentaux
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
                            label: "العنوان الوطني",
                            controller: adressController,
                            required: true,
                          ),
                          const SizedBox(height: 16),
                          LabeledField(
                            label: "البريد الإلكتروني",
                            controller: emailController,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "طلب الإستدعاء *",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFilePickerButton("اختر ملف", "request"),
                          SizedBox(height: 16),
                          Text(
                            "المحافظة",
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
                                        borderRadius: BorderRadius.circular(4),
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
                            optionsViewBuilder: (context, onSelected, options) {
                              return Material(
                                elevation: 4,
                                child: SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final city = options.elementAt(index);
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
                          SizedBox(height: 16),
                          if (cubit.selectedCity?.name ==
                              "إمارة منطقة نجران (SA)") ...[
                            const SizedBox(height: 16),
                            Text(
                              "المركز",
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
                                await cubit.fetchCenters(value.text);
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
                            SizedBox(height: 16),
                          ],
                          Text(
                            "أسباب التعويض*",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<CompensationReason>(
                            value: cubit.selectedCompensation,
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
                            items: cubit.compensations.map((compensation) {
                              return DropdownMenuItem<CompensationReason>(
                                value: compensation,
                                child: Text(compensation.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null)
                                cubit.selectCompensation(value);
                            },
                            validator: (value) => value == null
                                ? " الرجاء اختيار أسباب التعويض"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            " المكان المتضرر*",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<AggrievedPlace>(
                            value: cubit.selectedAggrivedPlace,
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
                            items: cubit.aggrivedPlaces.map((aggrivedPlace) {
                              return DropdownMenuItem<AggrievedPlace>(
                                value: aggrivedPlace,
                                child: Text(aggrivedPlace.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null)
                                cubit.selectAggrievedPlace(value);
                            },
                            validator: (value) => value == null
                                ? " الرجاء اختيار المكان المتضرر"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          if (cubit.selectedAggrivedPlace?.name == "مركبة") ...[
                            const SizedBox(height: 16),
                            const Text(
                              "استمارة السيارة*",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFilePickerButton("اختر ملف", "vehicle"),
                            const SizedBox(height: 16),
                            const Text(
                              "تأمين ساري المفعول *",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFilePickerButton(
                              "اختر ملف",
                              "vehicule_insurance",
                            ),
                          ],
                          const Text(
                            "الآيبان مصادق من البنك*",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFilePickerButton("اختر ملف", "bank"),
                          const SizedBox(height: 16),
                          const Text(
                            "إرفاق صورة الضرر",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFilePickerButton("اختر ملف", "damage"),
                          const SizedBox(height: 16),
                          const Text(
                            "إرفاق باقي المتطلبات في الشروط في ملف واحد",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildFilePickerButton("اختر ملف", "other"),
                          const SizedBox(height: 16),
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
                                // Vérifier fichiers obligatoires
                                final requiredKeys = ["id", "request", "bank"];
                                for (var key in requiredKeys) {
                                  if (!_files.containsKey(key)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "⚠️ الرجاء إرفاق جميع الملفات المطلوبة",
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                }

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

                                // Préparer les fichiers pour l'API
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
                                  "aggrieved_place_id": cubit
                                      .selectedAggrivedPlace!
                                      .id
                                      .toString(),
                                  "compensation_reason_id": cubit
                                      .selectedCompensation!
                                      .id
                                      .toString(),
                                  "country_state_id": cubit.selectedCity!.id
                                      .toString(),
                                  "affiliate_center_id":
                                      cubit.selectedCenter != null
                                      ? cubit.selectedCenter!.id.toString()
                                      : "",
                                  "street": relativeAdressController.text,
                                  "applicant_phone": phoneController.text,
                                  "applicant_identity": idController.text,
                                  "applicant_email": emailController.text,
                                  "applicant_national_address":
                                      adressController.text,
                                  "identity_attachment_ids": fileData("id"),
                                  "invitation_attachment_ids": fileData(
                                    "request",
                                  ),
                                  "certified_bank_attachment_ids": fileData(
                                    "bank",
                                  ),
                                  "insurance_attachment_ids": fileData(
                                    "vehicule_insurance",
                                  ),
                                  "vehicle_form_attachment_ids": fileData(
                                    "vehicule",
                                  ),
                                  "damage_photo_attachment_ids": fileData(
                                    'damage',
                                  ),
                                  "rest_of_requirements_ids": fileData("other"),
                                };
                                setState(() => _isLoading = true);
                                final success = await _apiService
                                    .sendFormulaire(
                                      context: context,
                                      endpoint: "/api/v1/compensation/create",
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

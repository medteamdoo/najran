import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/screens/Activities/cubit/cubit.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final OdooApiService _apiService = OdooApiService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitiesCubit(odooApiService: _apiService)..init(),
      child: BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<ActivitiesCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: NajranScaffold(
              currentIndex: 3,
              title: "المستندات",
              child: _buildBody(state, cubit),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ActivitiesState state, ActivitiesCubit cubit) {
    if (state is ActivitiesInitialState) {
      // 🌀 État de chargement (loading)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.fourRotatingDots(
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              "جاري تحميل البيانات...",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    if (state is ActivitiesError) {
      // ❌ Erreur
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "حدث خطأ أثناء تحميل البيانات:\n${state.message}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    if (state is ActivitiesLoadedState) {
      // ✅ Données chargées
      final activities = cubit.activities;

      if (activities.isEmpty) {
        return const Center(
          child: Text(
            "لا توجد بيانات متاحة حالياً.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: activities.map((activity) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.95,
                ), // 🤍 fond blanc légèrement transparent
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300, // 🎨 bordure douce
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🟢 Nom centré
                    Text(
                      activity.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildBadge(
                          color: Colors.blue,
                          svgPath: 'assets/icons/mail_2.svg',
                          value: activity.messages,
                        ),
                        const SizedBox(width: 10),
                        _buildBadge(
                          color: Colors.green,
                          svgPath: 'assets/icons/notif.svg',
                          value: activity.totalActivities,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    // Cas par défaut
    return const SizedBox.shrink();
  }

  Widget _buildBadge({
    required Color color,
    required String svgPath, // <-- chemin de l'icône SVG
    required int value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),

          SvgPicture.asset(
            svgPath,
            width: 16,
            height: 16,
            color: color, // si tu veux colorer ton SVG
          ),
        ],
      ),
    );
  }
}

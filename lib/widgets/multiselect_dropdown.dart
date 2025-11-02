import 'package:flutter/material.dart';
import 'package:najran/models/belonging.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<BelongingModel> belongings;
  final List<BelongingModel> selectedBelongings;
  final Function(List<BelongingModel>) onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.belongings,
    required this.selectedBelongings,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<BelongingModel> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedBelongings);
  }

  void _toggleSelection(BelongingModel item, bool selected) {
    setState(() {
      if (selected) {
        _selected.add(item);
      } else {
        _selected.removeWhere((b) => b.id == item.id);
      }
    });
    widget.onSelectionChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<BelongingModel>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: "اختر المرفقات",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          hint: const Text("اختر المرفقات"),
          items: widget.belongings.map((belonging) {
            final isSelected = _selected.any((b) => b.id == belonging.id);
            return DropdownMenuItem<BelongingModel>(
              value: belonging,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(belonging.name),
                  if (isSelected) const Icon(Icons.check, color: Colors.green),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final isSelected = _selected.any((b) => b.id == value.id);
              _toggleSelection(value, !isSelected);
            }
          },
        ),
        const SizedBox(height: 10),
        if (_selected.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: _selected.map((b) {
              return Chip(
                label: Text(b.name),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () {
                  _toggleSelection(b, false);
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}

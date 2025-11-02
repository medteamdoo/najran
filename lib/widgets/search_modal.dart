import 'package:flutter/material.dart';
import 'package:najran/models/search_item.dart';

void showSearchOverlay(BuildContext context, List<SearchItem> items) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      String query = '';
      List<SearchItem> filteredItems = List.from(items);
      final TextEditingController controller = TextEditingController();

      return StatefulBuilder(
        builder: (context, setState) {
          void updateFilter(String value) {
            setState(() {
              query = value;
              filteredItems = items
                  .where(
                    (item) =>
                        item.title.toLowerCase().contains(query.toLowerCase()),
                  )
                  .toList();
            });
          }

          return Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.black.withOpacity(0.2),
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller,
                        onChanged: updateFilter,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'ابحث هنا...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (filteredItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'لا توجد نتائج',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      else
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = filteredItems[index];
                              return ListTile(
                                title: Text(
                                  item.title,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  item.onTap(context);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

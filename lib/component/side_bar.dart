
import 'package:flutter/material.dart';
import 'package:root_admin/component/side_bar_tile.dart';
import 'package:root_admin/constants.dart';

class SideBar extends StatefulWidget {
  final String selectedCategory;
  final List<String> subCategories;

  const SideBar({
    super.key,
    required this.selectedCategory,
    required this.subCategories,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late String selectedSubCategory;

  @override
  void initState() {
    super.initState();
    selectedSubCategory =
        widget.subCategories.isNotEmpty ? widget.subCategories[0] : "";
  }

  @override
  void didUpdateWidget(SideBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory ||
        oldWidget.subCategories != widget.subCategories) {
      setState(() {
        selectedSubCategory =
            widget.subCategories.isNotEmpty ? widget.subCategories[0] : "";
      });
    }
  }

  void handleCategoryTap(String subCategory) {
    setState(() {
      selectedSubCategory = subCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: double.infinity,
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.subCategories.length,
              itemBuilder: (context, index) {
                final subCategory = widget.subCategories[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: SideBarTile(
                    title: subCategory,
                    isSelected: selectedSubCategory == subCategory,
                    onTap: () => handleCategoryTap(subCategory),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

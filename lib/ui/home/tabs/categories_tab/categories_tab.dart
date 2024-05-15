import 'package:flutter/material.dart';
import 'package:graduation_project/models/categories_dm.dart';

class CategoriesTab extends StatelessWidget {
  final Function onCategoryClick;
  const CategoriesTab(this.onCategoryClick,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Pick your category",
          style: TextStyle(fontSize: 30, fontFamily: "Exo", fontWeight: FontWeight.bold),),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
              itemCount: CategoryDM.category.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () => onCategoryClick(CategoryDM.category[index]),
                  child: buildCategory(CategoryDM.category[index]),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
          ),
        ),
      ],
    );
  }

  Widget buildCategory(CategoryDM category) {
    return Column(
      children: [
        Container(
          height: 135,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(image: AssetImage(category.imagePath),
              fit: BoxFit.fill
            ),
            color: category.backgroundColor,
          ),
        ),
        Text(category.title,
          style: const TextStyle(fontSize: 17, fontFamily: "Exo", fontWeight: FontWeight.bold),),
      ],
    );
  }
}
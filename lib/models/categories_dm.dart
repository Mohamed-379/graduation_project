import 'package:flutter/material.dart';

class CategoryDM
{
  Color backgroundColor;
  String title;
  String imagePath;
  String id;

  CategoryDM({
    required this.backgroundColor,
    required this.title,
    required this.imagePath,
    required this.id
  });

  static List<CategoryDM> category = [
    CategoryDM(
        backgroundColor: Colors.red,
        title: "Sport",
        imagePath: "assets/images/sport.png",
        id: "sports"),
    CategoryDM(
        backgroundColor: const Color(0xff003e8f),
        title: "Technology",
        imagePath: "assets/images/tech.png",
        id: "technology"),
    CategoryDM(
        backgroundColor: Colors.pink,
        title: "Health",
        imagePath: "assets/images/health.png",
        id: "health"),
    CategoryDM(
        backgroundColor: const Color(0xffce7d48),
        title: "Business",
        imagePath: "assets/images/business.png",
        id: "business"),
    CategoryDM(
        backgroundColor: Colors.blue,
        title: "Environment",
        imagePath: "assets/images/environment.png",
        id: "entertainment"),
    CategoryDM(
        backgroundColor: const Color(0xfff2ce4d),
        title: "Science",
        imagePath: "assets/images/science.png",
        id: "science"),
    CategoryDM(
        backgroundColor: Colors.black,
        title: "General",
        imagePath: "assets/images/login_screen_77.png",
        id: "general"),
  ];
}
import 'package:flutter/material.dart';

/// Модель элемента мега меню
/// Конвертировано из Android MegaMenuItem.kt
class MegaMenuItem {
  final int id;
  final String title;
  final IconData iconData;
  final String? url;
  final bool hasSubMenu;
  final List<MegaMenuItem>? subMenuItems;

  const MegaMenuItem({
    required this.id,
    required this.title,
    required this.iconData,
    this.url,
    this.hasSubMenu = false,
    this.subMenuItems,
  });
}

/// Фабрика для создания структуры меню сайта ЛМФЛ
/// Конвертировано из Android MenuFactory
class MenuFactory {
  static List<MegaMenuItem> createMainMenuItems() => [
    // Матчи с подменю
    MegaMenuItem(
      id: 1,
      title: "Матчи",
      iconData: Icons.sports_soccer,
      url: "https://lmfl05.ru/matches/%d0%bc%d0%b0%d1%87%d1%82%d1%8b/",
      hasSubMenu: true,
      subMenuItems: [
        MegaMenuItem(
          id: 11,
          title: "Первой лиги",
          iconData: Icons.sports_soccer,
          url: "https://lmfl05.ru/matches/%d0%bf%d0%b5%d1%80%d0%b2%d0%be%d0%b9-%d0%bb%d0%b8%d0%b3%d0%b8/",
        ),
        MegaMenuItem(
          id: 12,
          title: "Второй лиги",
          iconData: Icons.sports_soccer,
          url: "https://lmfl05.ru/matches/%d0%b2%d1%82%d0%be%d1%80%d0%be%d0%b9-%d0%bb%d0%b8%d0%b3%d0%b8/",
        ),
      ],
    ),
    
    // Турнирная таблица с подменю
    MegaMenuItem(
      id: 2,
      title: "Турнирная таблица",
      iconData: Icons.table_chart,
      url: "https://lmfl05.ru/table/%d1%82%d1%83%d1%80%d0%bd%d0%b8%d1%80%d0%bd%d0%b0%d1%8f-%d1%82%d0%b0%d0%b1%d0%bb%d0%b8%d1%86%d0%b0/",
      hasSubMenu: true,
      subMenuItems: [
        MegaMenuItem(
          id: 21,
          title: "Первая лига",
          iconData: Icons.table_chart,
          url: "https://lmfl05.ru/table/%d0%bf%d0%b5%d1%80%d0%b2%d0%b0%d1%8f-%d0%bb%d0%b8%d0%b3%d0%b0/",
        ),
        MegaMenuItem(
          id: 22,
          title: "Первый сезон",
          iconData: Icons.table_chart,
          url: "https://lmfl05.ru/table/%d0%bf%d0%b5%d1%80%d0%b2%d1%8b%d0%b9-%d1%81%d0%b5%d0%b7%d0%be%d0%bd/",
        ),
      ],
    ),
    
    // Турниры с подменю
    MegaMenuItem(
      id: 3,
      title: "Турниры",
      iconData: Icons.emoji_events,
      url: "https://lmfl05.ru/tournament/%d1%82%d1%83%d1%80%d0%bd%d0%b8%d1%80/",
      hasSubMenu: true,
      subMenuItems: [
        MegaMenuItem(
          id: 31,
          title: "Первый турнир",
          iconData: Icons.emoji_events,
          url: "https://lmfl05.ru/tournament/%d0%bf%d0%b5%d1%80%d0%b2%d1%8b%d0%b9-%d1%82%d1%83%d1%80%d0%bd%d0%b8%d1%80/",
        ),
      ],
    ),
    
    // Календарь событий
    MegaMenuItem(
      id: 4,
      title: "Календарь событий",
      iconData: Icons.calendar_today,
      url: "https://lmfl05.ru/calendar/%d0%ba%d0%b0%d0%bb%d0%b5%d0%bd%d0%b4%d0%b0%d1%80%d1%8c-%d1%81%d0%be%d0%b1%d1%8b%d1%82%d0%b8%d0%b9/",
    ),
    
    // Команды
    MegaMenuItem(
      id: 5,
      title: "Команды",
      iconData: Icons.groups,
      url: "https://lmfl05.ru/%d0%ba%d0%be%d0%bc%d0%b0%d0%bd%d0%b4%d1%8b/",
    ),
    
    // Тех. персонал с подменю
    MegaMenuItem(
      id: 6,
      title: "Тех. персонал",
      iconData: Icons.engineering,
      url: "https://lmfl05.ru/staff/%d1%82%d0%b5%d1%85-%d0%bf%d0%b5%d1%80%d1%81%d0%be%d0%bd%d0%b0%d0%bb/",
      hasSubMenu: true,
      subMenuItems: [
        MegaMenuItem(
          id: 61,
          title: "Оргкомитет ЛМФЛ",
          iconData: Icons.engineering,
          url: "https://lmfl05.ru/staff/%d0%be%d1%80%d0%b3%d0%ba%d0%be%d0%bc%d0%b8%d1%82%d0%b5%d1%82-%d0%bb%d0%bc%d1%84%d0%bb/",
        ),
        MegaMenuItem(
          id: 62,
          title: "Судьи",
          iconData: Icons.gavel,
          url: "https://lmfl05.ru/staff/%d1%81%d1%83%d0%b4%d1%8c%d0%b8/",
        ),
      ],
    ),
  ];
}
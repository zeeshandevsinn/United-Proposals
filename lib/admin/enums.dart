enum CategroyList {
  Marriage_Halls,
  Marquee,
  Jewellers,
  Caterers,
  Car_Rental_Service,
  Decoration,
  Nikah_khawan,
  Event_Planner,
  Boutique
}

String categoryStatus(CategroyList categroyList) {
  switch (categroyList) {
    case CategroyList.Marriage_Halls:
      return "Marriage Halls";
    case CategroyList.Marquee:
      return "Marquee";
    case CategroyList.Jewellers:
      return "Jewellers";
    case CategroyList.Caterers:
      return "Caterers";
    case CategroyList.Car_Rental_Service:
      return "Car Rental Service";
    case CategroyList.Decoration:
      return "Decoration";
    case CategroyList.Nikah_khawan:
      return "Nikah khawan";
    case CategroyList.Event_Planner:
      return "Event Planner";
    case CategroyList.Boutique:
      return "Boutique";
  }
}

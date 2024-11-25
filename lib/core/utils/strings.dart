extension AutoImgStrings on String {
  String get formalize => split("_")
      .map((String e) =>
          e[0].toUpperCase() + e.substring(1).toLowerCase())
      .join(" ");
}

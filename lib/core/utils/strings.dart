extension AutoImgStrings on String {
  /// formalizes the string by capitalizing the first letter of each word and lowercasing the rest
  ///
  /// not camel case, but more like a title case
  String get formalize => split("_")
      .map((String e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
      .join(" ");
}

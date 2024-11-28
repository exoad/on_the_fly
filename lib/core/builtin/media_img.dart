enum ImgFileTypes {
  webp(
      validExtensions: <String>["webp"],
      canWrite: false,
      canRead: true),
  jpg(
      validExtensions: <String>["jpg", "jpeg"],
      canWrite: true,
      canRead: true),
  bmp(
      validExtensions: <String>["bmp"],
      canWrite: true,
      canRead: true),
  ico(
      validExtensions: <String>["ico"],
      canWrite: true,
      canRead: true),
  png(
      validExtensions: <String>["png"],
      canWrite: true,
      canRead: true),
  gif(
      validExtensions: <String>["gif"],
      canWrite: true,
      canRead: true),
  tiff(
      validExtensions: <String>["tiff"],
      canWrite: true,
      canRead: true);

  final List<String> validExtensions;
  final bool canWrite;
  final bool canRead;

  const ImgFileTypes({
    required this.validExtensions,
    required this.canWrite,
    required this.canRead,
  });

  static const List<ImgFileTypes> inputTypes = <ImgFileTypes>[
    webp,
    jpg,
    bmp,
    ico,
    png,
    gif,
    tiff
  ];

  static const List<ImgFileTypes> outputTypes = <ImgFileTypes>[
    jpg,
    bmp,
    ico,
    png,
    gif,
    tiff
  ];
}

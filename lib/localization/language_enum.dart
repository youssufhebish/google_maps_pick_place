/// Supported language enum.
///
/// This enum is used to specify the language of the text to be translated.
///
/// - The supported languages are: [arabic], [english], [spanish], [portuguese], [german], [french], [italian], [russian], [chinese], [korean], [japanese], [hindi], [persian].
/// - The default language is [arabic].
/// - The language is specified by the [languageCode] property.
/// - in the future, we may add more languages.
enum Language {
  arabic("ar"),
  english("en"),
  spanish("es"),
  portuguese("pt"),
  german("de"),
  french("fr"),
  italian("it"),
  russian("ru"),
  chinese("ch"),
  korean("ko"),
  japanese("ja"),
  hindi("hi"),
  persian("fa");

  final String languageCode;
  const Language(this.languageCode);
}
String getTranslatedManifestationTitle(String lang) {
  const translations = {
    'hr': 'Manifestacije',
    'en': 'Events',
    'de': 'Veranstaltungen',
  };

  return translations[lang] ?? 'Manifestacije';
}

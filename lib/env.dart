class Env {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue:
        'https://ticktuck-backend.railway.internal:3000', // URL pour les tests locaux
  );
}

# MON Colis

Application Flutter de livraison avec authentification Supabase.

## Build Android

```bash
flutter pub get
flutter analyze
flutter build apk --release
```

Le workflow GitHub Actions construit automatiquement l'APK à chaque push sur `main` et permet aussi un lancement manuel.

## Supabase

L'application est configurée avec une URL de projet et une clé **publishable** dans `lib/main.dart`.
Vérifier que l'URL correspond exactement au projet actif dans Supabase.


## Modifier les identifiants Supabase sans toucher au code

Le projet accepte aussi :

```bash
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://TON-PROJET.supabase.co \
  --dart-define=SUPABASE_PUBLISHABLE_KEY=TA_CLE_PUBLISHABLE
```

La valeur intégrée par défaut reste celle actuellement présente dans le projet.

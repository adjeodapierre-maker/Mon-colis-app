# MON Colis — Android prêt pour GitHub Actions

Le projet contient maintenant une structure Android Flutter complète.

Corrections appliquées :
- permission Android INTERNET ajoutée ;
- `publishableKey` utilisé pour Supabase ;
- ancien `main.dart` à la racine supprimé ;
- ancien ZIP Android imbriqué supprimé ;
- workflow GitHub nettoyé : il ne recrée plus le dossier Android ;
- Java 17 configuré pour la compilation Android ;
- Gradle Wrapper ajouté (Gradle 8.9) pour éviter une dépendance à une installation Gradle locale ;
- `flutter analyze` ajouté avant le build ;
- génération de l'APK release conservée.

Compilation :

```bash
flutter pub get
flutter analyze
flutter build apk --release
```

## Important — Supabase

L'application utilise actuellement l'URL Supabase présente dans le projet :

`https://yljxmdxjihvldslxlagu.supabase.co`

Cette adresse doit être vérifiée dans le panneau **Connect** du projet Supabase. Si cette URL n'est pas celle de ton projet actif, remplace-la dans `lib/main.dart` avant le build.

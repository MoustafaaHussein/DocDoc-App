## DocDoc App – Technical Overview

This document explains the high‑level architecture and major building blocks of the DocDoc App. It is intended for developers who want to understand how the app is structured and how the main flows work.

---

### 1. Architecture Style

- **Feature‑first structure**: Most code lives under `lib/features/<feature_name>/...`, keeping UI, state, and data logic for each feature grouped together.  
- **Layered within each feature** (where applicable):
  - `presentation` – widgets, views, and UI logic.
  - `cubit` / `bloc` – state management via BLoC pattern.
  - `data` / `repo` / `domain` – repositories, models, and domain contracts.
- **Shared `core` module**: Cross‑cutting concerns (themes, routing, helpers, widgets) live under `lib/core`.

This structure makes it easy to add or refactor features without touching unrelated parts of the app.

---

### 2. Main Entry Point

- `lib/main.dart` is the application entry point.
- Responsibilities:
  - Initializes Flutter bindings and `EasyLocalization`.
  - Reads the auth token from `SharedPreferences` to determine if the user is logged in.
  - Initializes secure storage and the service locator (`get_it`).
  - Sets up the `GoRouter` instance via `AppRouter.initRouter(isLoggedIn: token != null)`.
  - Wraps the app in:
    - `EasyLocalization` (for i18n).
    - `ScreenUtilInit` (for responsive sizing).
    - `MultiBlocProvider` (for BLoCs/Cubits: recommendations, payments, mood history, auth, etc.).
  - Builds `MaterialApp.router` with:
    - Dark theme and Poppins typography.
    - Router config from `GoRouter`.
    - Localization delegates and supported locales.

---

### 3. Core Layer

Located under `lib/core`:

- **Routing**:  
  - `core/routes/app_routes.dart` defines named routes and navigation graph using `go_router`.
  - Feature screens are registered here and navigated to via `GoRouter`.

- **Theming & styles**:  
  - `core/themes/app_colors.dart` and `core/themes/app_styles.dart` centralize colors and text styles.  
  - Dark theme is the primary mode.

- **Helpers & services**:  
  - `core/helpers/api_service.dart`: central place for HTTP requests (built on `dio`).  
  - `core/helpers/secure_storage.dart`: wrapper around `flutter_secure_storage`.  
  - `core/helpers/service_locator.dart`: defines and registers dependencies with `get_it`.  
  - `core/helpers/size_config.dart`: layout helpers and constants.

- **Shared widgets**:  
  - `core/widgets/custom_button.dart`, various dialogs (rating, warning, complete exercise), empty data widgets, etc.  
  - These are imported across features for consistent UI.

---

### 4. Features Overview

At a glance, key feature modules include:

- **Analytics** – mood analytics and charts.  
- **AiModel** – emotion recognizer integration (TensorFlow Lite, camera).  
- **AiSession** – AI one‑on‑one sessions and related UI.  
- **Home** – main landing page with entry points to AI features, recommendations, and exercises.  
- **Login / SignUP** – authentication flows and related models/cubits.  
- **Mood_History** – mood history list, weekly views, and repositories.  
- **Onboard** – onboarding pages and introduction to the app.  
- **Payment** – Pro membership UI and payment flow.  
- **PersonInformation** – user profile and personal data.  
- **Recomendation** – recommendations by category and emotions.  
- **Splash** – initial splash and bootstrapping logic.

See `docs/FEATURES.md` for more detail on what each module does.

---

### 5. Data & Networking

- **HTTP layer**:  
  - Powered by `dio`.  
  - API calls should be centralized in repositories and helper services (e.g., `api_service.dart`).

- **Repositories**:  
  - For example, `MoodHistoryRepo`, `AnalyticsRepo`, `RecomendationRepo`, `PaymentRepositry`, and auth repositories.  
  - Repositories sit between the data layer (HTTP, storage) and the BLoCs/Cubits, exposing clean methods to the rest of the app.

- **Error handling**:  
  - Typically implemented inside repositories and surfaced as `Either` or custom failure states (using `dartz` and BLoC states).

---

### 6. State Management

- **BLoC / Cubit**:  
  - `flutter_bloc` and `equatable` are used to manage and compare states.  
  - Each feature has its own BLoC/cubit where appropriate (e.g., `RecomendationBloc`, `PaymentBloc`, `MoodHistoryCubit`, `AnalyticsCubit`, `LoginCubit`, `SignUpCubit`).

- **Providers**:  
  - `MultiBlocProvider` in `main.dart` wires up global BLoCs.  
  - Additional providers can be added at feature or route level as needed.

---

### 7. Localization

- `easy_localization` is configured in `main.dart`.  
- Supported locales: English (`en`), Arabic (`ar`).  
- Translation files are located in `assets/langs`.  
- Texts in the UI are wrapped with `.tr()`, e.g. `"emotion_recognizer".tr()`.

When adding new strings:

1. Update the JSON/ARB file(s) in `assets/langs`.  
2. Reference keys in widgets using `.tr()`.  
3. Ensure `pubspec.yaml` includes `assets/langs/` in the `assets` section.

---

### 8. Emotion Recognition & AI

- **ML models**:
  - Located in `assets/model.tflite` and `assets/emotions_model.tflite`.  
  - Labels: `assets/labels.txt` and `assets/labelss.txt`.

- **Camera integration**:
  - Uses the `camera` package to capture frames for on‑device inference.  
  - Requires camera permissions on mobile platforms.

- **AI Sessions**:
  - The `AiSession` feature provides screens for guided 1‑on‑1 AI interactions.  
  - Entry point is available on the `Home` screen via “one_on_one_sessions” section.

---

### 9. Payments / Pro Membership

- The `payment` feature holds:
  - Pro membership widgets and views.  
  - BLoC and repositories related to plans and purchases.  
  - UI for card details, plan selection, and displaying Pro perks.

- The project includes a dependency on `purchases_flutter` in `pubspec.yaml`, making it ready for integration with RevenueCat or similar services (depending on how you configure it).

---

### 10. Extending the App

When adding a new feature:

1. Create a new folder under `lib/features/<NewFeature>/`.  
2. Add `presentation`, `cubit`/`bloc`, and `data`/`repo` subfolders as needed.  
3. Define models and repositories in the feature’s `data`/`repo` layer.  
4. Expose routes via `core/routes/app_routes.dart`.  
5. Wire BLoCs/Cubits into `MultiBlocProvider` (or feature‑level providers).  
6. Keep shared components in `lib/core` when they’re reused across features.

This keeps the project maintainable and scalable as it grows.


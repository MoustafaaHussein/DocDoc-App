## DocDoc App

AI‑powered emotional wellbeing companion with mood tracking, AI sessions, personalized recommendations, and rich analytics.

DocDoc uses on‑device models and camera input to recognize emotions, guide users through one‑on‑one AI sessions, surface tailored exercises, and visualize mood history over time. The app supports English and Arabic, dark UI, and includes a Pro membership flow.

---

### Key Features

- **Emotion recognizer (AI)**  
  - On‑device emotion recognition using TensorFlow Lite models (`assets/model.tflite`, `assets/emotions_model.tflite`).  
  - Camera‑based emotion capture (via `camera` package).  
  - Emoji / mood selection flows for quick check‑ins.

- **AI one‑on‑one sessions**  
  - Dedicated AI session experience (`AiSession`) starting from the home screen.  
  - Guided conversations to help users open up and reflect.  
  - Integrated with subscription prompts (Pro membership).

- **Personalized recommendations**  
  - Recommendation screens by category and by emotion (`recomendation` feature).  
  - Exercises, activities, and content tailored to user mood.  
  - Beautiful cards and GIF‑based UI to keep engagement high.

- **Mood history & analytics**  
  - Mood timeline and history screens (`Mood_History`).  
  - Charts and insights powered by `fl_chart` and `Analytics` feature.  
  - Weekly mood overviews and trends.

- **Onboarding & localization**  
  - Multi‑screen onboarding (`onboard` feature).  
  - English and Arabic support via `easy_localization` and `assets/langs`.  
  - Responsive layout with `flutter_screenutil`.

- **Authentication & profile**  
  - Login / Sign Up flows with remote auth (`Login`, `SignUP` features).  
  - Token stored securely using `SharedPreferences` and `flutter_secure_storage`.  
  - Personal information & profile management (`PersonInformation`).

- **Payments / Pro membership**  
  - Pro membership plans and payment screens (`payment` feature).  
  - Ready for integration with in‑app purchases (`purchases_flutter`).  
  - UI for plan selection, card details, and Pro benefits.

---

### Tech Stack

- **Framework**: Flutter (Dart SDK ^3.7.2)  
- **State management**: `flutter_bloc`, `equatable`  
- **Routing**: `go_router`  
- **Dependency injection**: `get_it`  
- **Networking**: `dio`  
- **Localization**: `easy_localization`  
- **Storage**: `shared_preferences`, `flutter_secure_storage`, `path_provider`  
- **UI / UX**: `google_fonts`, `flutter_screenutil`, `shimmer`, `animations`, `animated_bottom_navigation_bar`, `flutter_svg`, `gif`  
- **ML / AI**: `tflite_flutter`, on‑device `.tflite` models and labels

---

### Project Structure (high‑level)

Most of the app follows a **feature‑first** architecture:

- `lib/core` – shared helpers, themes, widgets, routing, and services  
  - `core/helpers` – API service, secure storage, service locator, size config, etc.  
  - `core/themes` – colors, styles, typography.  
  - `core/widgets` – reusable UI components (buttons, dialogs, empty state, etc.).  

- `lib/features` – each folder is a vertical feature slice:  
  - `Analytics` – mood analytics and insights.  
  - `AiModel` – emotion recognition model integration.  
  - `AiSession` – AI session / one‑on‑one conversation flow.  
  - `Home` – home screen, exercises, quotes, quick navigation.  
  - `Login`, `SignUP` – authentication (cubit + data + views).  
  - `Mood_History` – mood history, records, and related UI.  
  - `onboard` – onboarding screens.  
  - `payment` – Pro membership and payment UI.  
  - `PersonInformation` – profile & personal info.  
  - `recomendation` – recommendations by category and emotion.  
  - `splash` – splash screen and initial navigation.

For a more detailed breakdown, see `docs/OVERVIEW.md` and `docs/FEATURES.md` (if present in your repo).

---

### Getting Started

#### Prerequisites

- Flutter SDK compatible with Dart `^3.7.2` (see `pubspec.yaml`)  
- Android Studio or VS Code with Flutter extensions  
- Xcode (for iOS builds)  
- A device or emulator with camera access enabled (for emotion recognition)

#### Install dependencies

```bash
flutter pub get
```

#### Assets & localization

This project relies on a set of assets defined in `pubspec.yaml`:

- `assets/images/` – app images, icons, illustrations  
- `assets/langs/` – localization files for `easy_localization`  
- `assets/labels.txt`, `assets/labelss.txt` – labels for ML models  
- `assets/model.tflite`, `assets/emotions_model.tflite` – TensorFlow Lite models

Ensure these folders and files exist and are kept in sync when you add new images or languages.

---

### Running the App

Run on a connected device or emulator:

```bash
flutter run
```

To specify a device:

```bash
flutter devices      # list devices
flutter run -d <device_id>
```

---

### Configuration

- **Routing**: Configured via `AppRouter.initRouter` in `core/routes/app_routes.dart`, with conditional start destinations based on login state.  
- **Authentication**:  
  - Tokens are read from `SharedPreferences` (`token` key) at startup.  
  - Secure data (e.g., sensitive auth details) can be persisted through `SecureStorage` in `core/helpers/secure_storage.dart`.  
- **Localization**:  
  - Configured in `main.dart` using `EasyLocalization`.  
  - Default supported locales: English (`en`), Arabic (`ar`).  
  - Translation files live under `assets/langs`.

If you introduce environment‑specific configuration (e.g., API base URLs), keep it in a dedicated config file (e.g., `core/helpers/api_service.dart` or a separate `env` module) and avoid hard‑coding secrets.

---

### Development Notes

- **State management**: Most features use BLoC/cubit, with repositories handling data access. Inject dependencies via `get_it` so they remain testable and decoupled.  
- **Responsive design**: Layouts rely on `flutter_screenutil` and `MediaQuery` for consistent sizing across devices.  
- **Dark theme**: The app uses a custom dark theme (`AppColors.kDarkModeBackgroundColor`) and a Poppins typography stack from `google_fonts`.

---

### Contributing

1. Fork the repository.  
2. Create a feature branch (`feature/my-awesome-change`).  
3. Commit your changes with clear messages.  
4. Open a Pull Request with a short description and screenshots if relevant.

---

### License

This project is currently closed‑source / proprietary by default.  
If you plan to open‑source it, add an appropriate `LICENSE` file and update this section.


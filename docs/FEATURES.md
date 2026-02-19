## DocDoc App – Feature Documentation

This document describes the main user‑facing features and how they map to the codebase.

---

### 1. Splash & Onboarding

- **Goal**: Provide a branded entry, then guide new users through the app’s value proposition.  
- **Code**:
  - `features/splash` – splash view and boot logic.  
  - `features/onboard` – onboarding screens, page view, and indicators.
- **Notes**:
  - After splash, the router decides whether to show onboarding, auth, or home based on login state and any stored flags.

---

### 2. Authentication (Login / Sign Up)

- **Goal**: Allow users to create an account and log in securely.  
- **Code**:
  - `features/Login` – login UI, `LoginCubit`, and `LoginModel`.  
  - `features/SignUP` – sign‑up UI, `SignUpCubit`, `SignUpModel`, and repository.
- **Behavior**:
  - Uses `dio` for HTTP requests to the backend auth API.  
  - On successful login/sign‑up, a token is stored in `SharedPreferences` and possibly `SecureStorage`.  
  - `main.dart` checks the stored token to auto‑login users.

---

### 3. Home

- **Goal**: Act as the central hub for the user’s emotional wellbeing journey.  
- **Code**: `features/Home/presentation/views/Home.dart` and related widgets.  
- **Key UI sections**:
  - Header with user name and avatar.  
  - “Emotion recognizer” section with AI features label.  
  - Card linking to AI sessions (`AiSession`).  
  - Scrollable list of exercises (`CustomExcersicesScrollableWidget`).  
  - Motivational quote card.  
  - “Describe your mood” section that leads to emoji/mood selection and recommendations.

---

### 4. Emotion Recognition (AiModel)

- **Goal**: Detect user emotions using the device camera and local ML models.  
- **Code**:
  - `features/AiModel` – components that interact with TFLite models and camera.  
  - Uses `camera` and `tflite_flutter` packages.
- **Behavior**:
  - Captures frames from the camera.  
  - Runs inference with `.tflite` models using inputs and output labels defined in `assets`.  
  - Maps raw scores to emotion labels (e.g., happy, sad, stressed).

---

### 5. AI Sessions (AiSession)

- **Goal**: Provide guided one‑on‑one sessions with an AI companion.  
- **Code**:
  - `features/AiSession/presentation/views/Ai_View.dart` – entry view.  
  - `features/AiSession/presentation/views/widgets` – intro page and session widgets.
- **Behavior**:
  - Launched from the Home screen via the “one_on_one_sessions” card.  
  - Focused UI that encourages users to open up and talk through their feelings.  
  - Closely integrated with Pro membership prompts to encourage subscription.

---

### 6. Recommendations (Recomendation)

- **Goal**: Suggest exercises, activities, and content tailored to the user’s emotions and preferences.  
- **Code**:
  - `features/recomendation/data` – models for categories, recommendations by category, and by emotion.  
  - `features/recomendation/domain/repos` – `RecomendationRepo` interface.  
  - `features/recomendation/presentation` – BLoC, views, and widgets.
- **Main flows**:
  - **By category**: user selects a category; the app shows relevant exercises/content.  
  - **By emotion**: user selects how they feel (emojis or AI inference) and receives tailored suggestions.

---

### 7. Mood History

- **Goal**: Track how the user’s mood changes over time and let them review past records.  
- **Code**:
  - `features/Mood_History/model` – `MoodRecordModel` (or similar naming).  
  - `features/Mood_History/repo` – `MoodHistoryRepo`.  
  - `features/Mood_History/cubit` – `MoodHistoryCubit` and states.  
  - `features/Mood_History/Screens` – `MoodHistoryScreen` and related UI.
- **Behavior**:
  - Stores mood entries (e.g., selected emotion, timestamp, optional notes).  
  - Exposes a history list and possibly summary stats per period (day/week/month).

---

### 8. Analytics

- **Goal**: Visualize mood trends and provide insights over time.  
- **Code**:
  - `features/Analytics/cubit` – `AnalyticsCubit` and state management.  
  - `features/Analytics/repo` – `AnalyticsRepo`.  
  - Charts and visual components may live under this feature or reuse shared chart widgets.
- **Behavior**:
  - Uses `fl_chart` to plot mood over time.  
  - May compute summaries such as average mood, most common emotions, and streaks.

---

### 9. Payments & Pro Membership

- **Goal**: Offer a Pro tier with additional features or content.  
- **Code**:
  - `features/payment/data` – models, local data source, repository implementations.  
  - `features/payment/domain/repos` – `PaymentRepositry` interface.  
  - `features/payment/presentation` – `PaymentBloc` and UI views/widgets.  
  - `pro_membership_main_widget.dart` and other Pro‑related components.
- **Behavior**:
  - Displays available Pro plans, prices, and benefits.  
  - Handles user selection of a plan and transition to the payment flow.  
  - Designed to integrate with `purchases_flutter` for in‑app purchase handling (configuration required).

---

### 10. Personal Information (Profile)

- **Goal**: Maintain user profile information and personalize the experience.  
- **Code**:
  - `features/PersonInformation/presentation/views` and `widgets`.  
  - Widgets like `BirthDateSelect` and `ProfileInfoTile`.
- **Behavior**:
  - Lets users input or update personal details such as name, birth date, and other profile fields.  
  - Information is reused in greetings, analytics, and personalization.

---

### 11. Shared UX Elements

- **Quotes & exercises**:
  - Home quotes (`QuoteCard`) and scrollable exercises (`CustomExcersicesScrollableWidget`) encourage positive routines.

- **Dialogs**:
  - Shared dialogs (e.g., rating, completion, warning) in `core/widgets` provide consistent feedback UX.

---

### 12. How to Add / Modify Features

When updating a feature:

1. Locate the relevant folder under `lib/features`.  
2. Update or add:
   - Models and repositories (for data changes).  
   - BLoCs/Cubits and states (for logic changes).  
   - Views and widgets (for UI changes).
3. If a new route is needed, register it in `core/routes/app_routes.dart`.  
4. If the feature has global state, wire its BLoC/Cubit into `MultiBlocProvider` in `main.dart`.

Following these steps helps keep features isolated and easier to test and maintain.


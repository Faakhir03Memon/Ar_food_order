# AR Dine – Augmented Reality Food Experience Implementation Plan

> **For Antigravity:** REQUIRED WORKFLOW: Use `.agent/workflows/execute-plan.md` to execute this plan in single-flow mode.

**Goal:** Build a premium, futuristic AR-based food ordering app with Flutter and Firebase.

**Architecture:** Layered architecture using Provider for state management, Firebase for backend services, and `ar_flutter_plugin_updated` for AR native integration.

**Tech Stack:** Flutter, Dart, Firebase (Auth, Firestore, Storage), Provider, Lottie, Google Fonts.

---

### Task 1: Project Initialization

**Files:**
- Create: `pubspec.yaml`
- Create: `lib/main.dart`

**Step 1: Initialize Flutter Pubspec**
Add dependencies: `provider`, `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`, `ar_flutter_plugin_updated`, `lottie`, `google_fonts`, `cached_network_image`, `glassmorphism`.

**Step 2: Basic main.dart Setup**
Initialize Firebase and setup basic Provider wrapper.

**Step 3: Run Flutter Pub Get**
Run: `flutter pub get`

**Step 4: Commit**
```bash
git add .
git commit -m "chore: initial project setup and dependencies"
```

---

### Task 2: Design System & Theme

**Files:**
- Create: `lib/core/app_theme.dart`
- Create: `lib/core/app_colors.dart`
- Create: `lib/widgets/glass_container.dart`

**Step 1: Define App Colors**
Use obsidian blacks and neon accents.

**Step 2: Create App Theme**
Implement Dark Theme with Google Fonts (Orbitron/Roboto).

**Step 3: Create GlassContainer Widget**
Implement BackdropFilter with blur.

**Step 4: Commit**
```bash
git add .
git commit -m "feat: design system and glassmorphism components"
```

---

### Task 3: Firebase Services

**Files:**
- Create: `lib/services/auth_service.dart`
- Create: `lib/services/menu_service.dart`
- Create: `lib/models/dish_model.dart`

**Step 1: Define Dish Model**
Map Firestore fields to Dart object.

**Step 2: Menu Service**
Fetch `menu_items` collection from Firestore.

**Step 3: Auth Service**
Basic Email/Password logic.

**Step 4: Commit**
```bash
git add .
git commit -m "feat: firebase services and data models"
```

---

### Task 4: UI Development (Home & Menu)

**Files:**
- Create: `lib/screens/home_screen.dart`
- Create: `lib/screens/menu_screen.dart`
- Create: `lib/widgets/dish_card.dart`

**Step 1: Dish Card Widget**
Glassmorphic card with Hero animation tag.

**Step 2: Home Screen**
Implement featured horizontal list and categories.

**Step 3: Menu Screen**
Implement grid view with Search/Filter.

**Step 4: Commit**
```bash
git commit -m "feat: home and menu screens UI"
```

---

### Task 5: AR Module Implementation

**Files:**
- Create: `lib/screens/ar_view_screen.dart`
- Modify: `lib/screens/detail_screen.dart`

**Step 1: Setup AR Session**
Initialize `ArCoreController` and `ArKitController`.

**Step 2: Implement Plane Detection**
Blue grid visualization.

**Step 3: Model Placement & Gestures**
Load GLB from model_url and add pinch/rotate handlers.

**Step 4: Commit**
```bash
git commit -m "feat: core AR module with surface detection"
```

---

### Task 6: Cart & Checkout Flow

**Files:**
- Create: `lib/providers/cart_provider.dart`
- Create: `lib/screens/cart_screen.dart`

**Step 1: Cart Provider**
Logic for totaling items and storage.

**Step 2: Cart UI**
Animated list of items.

**Step 3: Commit**
```bash
git commit -m "feat: cart management and checkout UI"
```

---

### Task 7: Final Polish & Animations

**Files:**
- Create: `lib/screens/splash_screen.dart`
- Modify: `lib/main.dart`

**Step 1: Splash Screen**
Lottie logo animation.

**Step 2: Page Transitions**
Custom scale/fade routes.

**Step 3: Commit**
```bash
git commit -m "feat: futuristic polish and animations"
```

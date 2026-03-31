# Design Document: AR Dine – Augmented Reality Food Experience

## Overview
A premium, futuristic AR food ordering mobile application built with Flutter and Firebase. The app allows users to preview 3D food models in their real-world environment before ordering.

## Architecture
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Provider (ChangeNotifierProvider)
- **Backend**: Firebase (Auth, Firestore, Storage)
- **AR Engine**: `ar_flutter_plugin_updated` (Native ARCore/ARKit)

## Design System
- **Theme**: Ultra-Dark (#050505)
- **Accents**: Electric Blue (#00D2FF), Neon Purple (#9D50BB)
- **Styles**: Glassmorphism (BackdropFilter), Neon Borders, PBR Materials (3D)

## Components
### 1. UI Components
- `GlassContainer`: Reusable frosted-glass card.
- `NeonButton`: Gradient border button with haptic feedback.
- `ParallaxDishCard`: Horizontal scroll card with depth effect.

### 2. AR Module
- **Surface Detection**: Neon-blue grid overlay.
- **Interactions**: Pinch-to-scale, 2-finger rotate, drag-to-move.
- **Lighting**: Dynamic light estimation for PBR realism.
- **Shadows**: Shadow-catcher plane for ambient floor placement.

### 3. Data Flow
- **Auth**: Firebase Auth (Persistent sessions).
- **Menu**: Firestore (MenuItems collection) -> MenuProvider -> UI.
- **Cart**: Local CartProvider -> Checkout -> Firestore (Orders collection).
- **3D Models**: Firebase Storage (.glb) -> Local Cache -> AR Session.

## Success Criteria
- Smooth 60FPS animations.
- Realistic AR placement on horizontal surfaces.
- Seamless "Hero-to-AR" transitions.
- Secure and real-time order processing.

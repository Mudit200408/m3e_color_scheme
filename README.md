# M3E Color Scheme

![M3E Intro](docs/color-scheme.png)

A Flutter package providing AOSP-aligned native color scheme generation and a robust fixup for the `dynamic_color` package in Flutter. It correctly populates the newer tone-based Material 3 surface and container roles, guarantees accessibility-compliant `on*Container` contrast mappings (resolving to Tone 30/Tone 90 instead of dull system Tone 10), and enables advanced dynamic variants (such as Expressive, Vibrant, Fidelity, Fruit Salad) with real-time contrast control.

> [!NOTE]
> `m3e_color_scheme` is a part of the larger **[m3e_core](https://pub.dev/packages/m3e_core)** ecosystem.

---

## 🎮 Interactive Demo

You can try out the package UI demo here: [m3e_core demo](https://muditpurohit.github.io/m3e_core/)

> [!IMPORTANT]
> **To experience the native OS-level wallpaper dynamic color synchronization, you must run the example app on an Android 12+ device.**
> The web demo above allows you to check the UI and test the programmatic seed colors, variants, and contrast options in real-time, but does not support fetching OS wallpaper palettes.

---

## 🚀 Features

- **dynamic_color Fixup** — Correctly overrides and populates missing or incorrect OS-provided dynamic color roles (e.g., populating new surface container roles).
- **AOSP-Aligned Contrasts** — Ensures container foreground text/icons (`onPrimaryContainer`, etc.) use vibrant, high-readability **Tone 30** (light mode) / **Tone 90** (dark mode) as defined by AOSP ColorSpec2026, bypassing dull system Tone 10 rendering.
- **8 Color Variants** — Generate custom tonal palettes dynamically using `tonalSpot`, `vibrant`, `fidelity`, `expressive`, `monochrome`, `neutral`, `rainbow`, and `fruitSalad`.
- **Contrast-Level Control** — Adjust dynamic scheme contrast levels on the fly (from `-1.0` to `1.0`) with automatic accessibility compliance.
- **Automatic Brightness Adaptation** — Fluidly generates matching light and dark themes using uniform HCT color specifications.

---

## 📦 Installation

```yaml
dependencies:
  m3e_color_scheme: ^0.0.1
```

```dart
import 'package:m3e_color_scheme/m3e_color_scheme.dart';
```

---

## 🧩 Quick Start

### 1. Standalone Replacement for `ColorScheme.fromSeed`

To generate color schemes with advanced variants and contrast levels inside the Dart runtime, replace your default `ColorScheme.fromSeed` constructor:

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: M3EColorScheme.light(
      seedColor: Colors.deepPurple,
      variant: M3EColorVariant.expressive, // Instantly unlocks expressive hue-rotations
      contrastLevel: 0.0, // Adjust from -1.0 to 1.0
    ),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    colorScheme: M3EColorScheme.dark(
      seedColor: Colors.deepPurple,
      variant: M3EColorVariant.expressive,
      contrastLevel: 0.0,
    ),
    useMaterial3: true,
  ),
  home: const HomeScreen(),
);
```

### 2. Fixup Mapping for `dynamic_color` Package (Android 12+)

To fix missing surface containers or dull Tone 10 container contrast roles provided by the Android OS, wrap your `MaterialApp` with `DynamicColorBuilder` and feed the system scheme to `M3EColorScheme`:

```dart
DynamicColorBuilder(
  builder: (lightDynamic, darkDynamic) {
    final lightScheme = M3EColorScheme.light(
      seedColor: lightDynamic?.primary ?? Colors.deepPurple,
      systemColorScheme: lightDynamic, // Intercepts and corrects system mappings
      variant: M3EColorVariant.tonalSpot,
    );
    
    final darkScheme = M3EColorScheme.dark(
      seedColor: darkDynamic?.primary ?? Colors.deepPurple,
      systemColorScheme: darkDynamic, // Intercepts and corrects system mappings
      variant: M3EColorVariant.tonalSpot,
    );

    return MaterialApp(
      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkScheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  },
);
```

---

## 📖 Detailed API Guide

### 1. `M3EColorScheme.light` & `M3EColorScheme.dark`

Constructors to generate light or dark `ColorScheme` palettes with AOSP modifications:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `seedColor` | `Color` | *(Required)* | The source color for the HCT palette. |
| `contrastLevel` | `double` | `0.0` | Contrast adjustments between `-1.0` (low) and `1.0` (high). |
| `variant` | `M3EColorVariant` | `M3EColorVariant.tonalSpot` | The dynamic scheme generation logic to apply. |
| `systemColorScheme` | `ColorScheme?` | `null` | Android system-provided scheme. When supplied, it copies and overrides the system values with corrected container/surface roles. |

---

### 2. `M3EColorVariant`

Tonal specification presets for dynamic palette generation:

| Variant | Description |
|---------|-------------|
| `tonalSpot` | Standard Material 3 dynamic color scheme (pastel, balanced). |
| `vibrant` | Emphasizes secondary and tertiary vibrancies for rich highlights. |
| `fidelity` | Keeps generated tones highly faithful to the seed color's exact chroma. |
| `expressive` | Employs bold dynamic hue-rotations (e.g. vivid magenta accents on a purple seed). |
| `monochrome` | Generates a pure greyscale palette with solid black/white tones. |
| `neutral` | Muted, near-neutral tones with extremely low chroma. |
| `rainbow` | Rotates hues through a distinct rainbow spectrum. |
| `fruitSalad` | Organic, fruit-inspired palettes with shifted tertiary colors. |

---

## 🐞 Found a bug? or ✨ You have a Feature Request?

Feel free to open an [Issue](https://github.com/Mudit200408/m3e_color_scheme/issues) or [Contribute](https://github.com/Mudit200408/m3e_color_scheme/pulls) to the project via the main repository.

Hope You Love It!

---

### Radhe Radhe 🙏

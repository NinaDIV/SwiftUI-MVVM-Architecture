# Arquitectura MVVM con SwiftUI — Gestión de Tareas y Cursos

![Swift](https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=flat&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=flat&logo=xcode&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=flat&logo=apple&logoColor=white)

Implementación del patrón de diseño **MVVM** (Model-View-ViewModel) utilizando **SwiftUI**, con separación clara de capas para aplicaciones iOS escalables. La app permite registrar, listar, editar y eliminar tareas y cursos, con persistencia local mediante `UserDefaults`.

## ✨ Funcionalidades

- Registrar tareas y cursos
- Listar tareas y cursos con vista dinámica
- Editar descripción de tareas y datos de cursos
- Eliminar tareas y cursos con confirmación
- Persistencia local con `UserDefaults`
- Cálculo de promedios de prácticas y laboratorios

## 🏗️ Arquitectura MVVM

```
├── Model/          # Estructuras de datos (Task, Course)
├── View/           # Vistas declarativas en SwiftUI
├── ViewModel/      # Lógica de negocio y estado
└── App.swift       # Punto de entrada
```

| Capa | Responsabilidad |
|------|-----------------|
| **Model** | Estructuras de datos puras |
| **View** | UI declarativa con SwiftUI |
| **ViewModel** | Lógica de negocio, persistencia y estado observable |

> El proyecto de Xcode se encuentra dentro de la carpeta `Caso propuesto/`.

## 🛠️ Tecnologías

| Tecnología | Detalle |
|------------|---------|
| Swift | 5.9+ |
| SwiftUI | Framework de UI declarativa |
| Xcode | 15+ |
| UserDefaults | Persistencia local |

## 📋 Requisitos previos

Antes de ejecutar el proyecto necesitas:

- Una **Mac** con macOS compatible con Xcode 15 (macOS Ventura 13.5 o superior)
- **Xcode 15 o superior** (incluye Swift 5.9 y los SDK de iOS) — disponible en la Mac App Store
- Un **simulador de iOS** (se instala junto con Xcode) o un dispositivo iOS físico

No se requieren dependencias externas (no usa CocoaPods ni Swift Package Manager).

## 🚀 Instalación y ejecución

1. Clona el repositorio:

   ```bash
   git clone https://github.com/NinaDIV/SwiftUI-MVVM-Architecture.git
   cd SwiftUI-MVVM-Architecture
   ```

2. Abre el proyecto en Xcode (el archivo `.xcodeproj` está dentro de `Caso propuesto/`):

   ```bash
   open "Caso propuesto"
   ```

3. En Xcode, selecciona un simulador de iOS (por ejemplo, *iPhone 15*) en la barra superior.

4. Compila y ejecuta con `Cmd + R`.

Al arrancar, el simulador mostrará la aplicación con las vistas de tareas y cursos, lista para registrar, editar y eliminar registros. Los datos se conservan entre ejecuciones gracias a `UserDefaults`.

# SwiftUI MVVM Architecture

![Swift](https://img.shields.io/badge/Swift-F05138?style=flat&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=flat&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=flat&logo=xcode&logoColor=white)

Implementacion del patron de diseno **MVVM** (Model-View-ViewModel) utilizando **SwiftUI**. Permite registrar, listar, editar y eliminar tareas y cursos de forma persistente con UserDefaults.

## Funcionalidades

- Registrar tareas y cursos
- Listar tareas y cursos con vista dinamica
- Editar descripcion de tareas y datos de cursos
- Eliminar tareas y cursos con confirmacion
- Persistencia con UserDefaults
- Calculo de promedios de practicas y laboratorios

## Arquitectura MVVM

```
â”œâ”€â”€ Model/          # Estructuras de datos (Task, Course)
â”œâ”€â”€ View/           # Vistas declarativas en SwiftUI
â”œâ”€â”€ ViewModel/      # Logica de negocio y estado
â””â”€â”€ App.swift       # Entry point
```

| Capa | Responsabilidad |
|------|----------------|
| **Model** | Estructuras de datos puras |
| **View** | UI declarativa con SwiftUI |
| **ViewModel** | Logica de negocio, persistencia, estado observable |

## Tecnologias

- **Lenguaje:** Swift 5.9+
- **UI:** SwiftUI
- **IDE:** Xcode 15+
- **Persistencia:** UserDefaults

## Ejecutar el proyecto

1. Clona el repositorio
2. Abre el `.xcodeproj` en Xcode
3. Selecciona un simulador iOS
4. `Cmd + R` para compilar y ejecutar
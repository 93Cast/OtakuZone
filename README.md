# 🎌 OtakuZone - Anime App

Aplicación desarrollada con **Flutter** que permite consultar información sobre diferentes animes mediante el consumo de la **Jikan API**, un servicio web REST que proporciona acceso a información relacionada con anime.

La aplicación permite visualizar los animes más populares, realizar búsquedas en tiempo real y consultar información detallada de cada anime.

---

## 📱 Características

- 🎬 Visualización de animes populares.
- 🔍 Búsqueda de animes en tiempo real.
- ⏳ Implementación de `debounce` para optimizar las búsquedas.
- 📱 Diseño responsivo mediante `GridView`.
- 🖥️ Adaptación automática de la cantidad de columnas según el tamaño de la pantalla.
- 📄 Pantalla de detalle para cada anime.
- ⭐ Visualización de la puntuación del anime.
- 📺 Visualización de la cantidad de episodios.
- 📝 Consulta de la sinopsis.
- 🌙 Modo oscuro.
- ☀️ Modo claro.
- 💾 Persistencia de la preferencia del tema utilizando `SharedPreferences`.
- 🔄 Indicadores de carga durante las solicitudes.
- ⚠️ Manejo de errores en la comunicación con la API.

---

## 🏗️ Arquitectura del proyecto

El proyecto utiliza una organización básica basada en la separación de responsabilidades.

```text
lib/
│
├── models/
│   └── anime.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── search_screen.dart
│   └── anime_detail_screen.dart
│
├── services/
│   └── jikan_service.dart
│
├── widgets/
│   ├── anime_card.dart
│   └── loading_widget.dart
│
└── main.dart
```

### Descripción de los componentes

| Componente | Descripción |
|---|---|
| `main.dart` | Configuración principal de la aplicación y gestión del tema Light/Dark. |
| `anime.dart` | Modelo utilizado para representar la información de un anime. |
| `jikan_service.dart` | Servicio encargado de realizar las solicitudes HTTP a la API. |
| `home_screen.dart` | Pantalla principal que muestra los animes populares. |
| `search_screen.dart` | Pantalla para realizar búsquedas de anime en tiempo real. |
| `anime_detail_screen.dart` | Muestra información detallada de un anime. |
| `anime_card.dart` | Widget reutilizable para representar un anime. |
| `loading_widget.dart` | Widget utilizado para mostrar indicadores de carga. |

---

## 🔄 Funcionamiento de la aplicación

La aplicación sigue el siguiente flujo:

```text
Usuario
   │
   ▼
Pantalla Flutter
   │
   ▼
JikanService
   │
   ▼
Solicitud HTTP
   │
   ▼
Jikan API
   │
   ▼
Respuesta JSON
   │
   ▼
Modelo Anime
   │
   ▼
Interfaz de Usuario
```

---

## 🌐 Consumo de API

La aplicación consume la **Jikan API** para obtener información sobre anime.

Las principales funcionalidades consumen endpoints para:

- Obtener los animes más populares.
- Buscar animes por nombre.
- Obtener información relacionada con cada anime.

La información obtenida es procesada desde formato JSON y convertida en objetos del modelo `Anime`.

---

## 🔍 Búsqueda en tiempo real

La pantalla de búsqueda utiliza un `TextEditingController` y un `Timer` para implementar una técnica conocida como **debounce**.

Esto permite esperar unos milisegundos después de que el usuario deja de escribir antes de realizar una nueva solicitud.

```text
Usuario escribe
      │
      ▼
Timer de 600 ms
      │
      ▼
¿Continúa escribiendo?
      │
   Sí │ No
      │
      ▼
Reiniciar      Realizar búsqueda
Timer                │
                     ▼
                 Jikan API
```

Esto ayuda a evitar realizar una solicitud a la API por cada carácter escrito.

---

## 📱 Diseño responsivo

La pantalla principal utiliza:

```dart
SliverGridDelegateWithMaxCrossAxisExtent
```

Esto permite que Flutter determine automáticamente la cantidad de columnas que deben mostrarse según el tamaño disponible de la pantalla.

Por ejemplo:

```text
Pantalla pequeña
┌──────────┬──────────┐
│  Anime   │  Anime   │
├──────────┼──────────┤
│  Anime   │  Anime   │
└──────────┴──────────┘


Pantalla grande
┌──────┬──────┬──────┬──────┐
│Anime │Anime │Anime │Anime │
├──────┼──────┼──────┼──────┤
│Anime │Anime │Anime │Anime │
└──────┴──────┴──────┴──────┘
```

---

## 🌙 Light Mode y Dark Mode

La aplicación permite cambiar entre modo claro y modo oscuro.

La preferencia seleccionada por el usuario se guarda utilizando:

```text
SharedPreferences
```

El flujo es el siguiente:

```text
Usuario cambia el tema
          │
          ▼
     ThemeMode
          │
          ▼
SharedPreferences
          │
          ▼
Se guarda la preferencia
          │
          ▼
Usuario cierra la aplicación
          │
          ▼
Usuario vuelve a abrirla
          │
          ▼
Se recupera el tema seleccionado
```

---

## 🛠️ Tecnologías utilizadas

- Flutter
- Dart
- Material Design 3
- Jikan API
- HTTP
- JSON
- SharedPreferences
- Git
- GitHub

---

## 🚀 Instalación y ejecución

### 1. Clonar el repositorio

```bash
git clone URL_DEL_REPOSITORIO
```

### 2. Entrar a la carpeta del proyecto

```bash
cd animeapp
```

### 3. Instalar las dependencias

```bash
flutter pub get
```

### 4. Ejecutar la aplicación

```bash
flutter run
```

También puedes ejecutar directamente en Chrome:

```bash
flutter run -d chrome
```

---

## 📦 Dependencias principales

El proyecto utiliza dependencias como:

```yaml
dependencies:
  flutter:
    sdk: flutter

  http: ^1.0.0
  shared_preferences: ^2.0.0
```

> Las versiones exactas pueden variar según el archivo `pubspec.yaml` del proyecto.

---

## 🎯 Objetivos del proyecto

Este proyecto fue desarrollado con fines educativos para practicar:

- Desarrollo de aplicaciones con Flutter.
- Creación de interfaces con Material Design.
- Consumo de servicios web REST.
- Solicitudes HTTP.
- Procesamiento de datos JSON.
- Creación de modelos.
- Navegación entre pantallas.
- Widgets reutilizables.
- Búsquedas en tiempo real.
- Implementación de `debounce`.
- Diseño responsivo.
- Manejo de estados de carga y errores.
- Implementación de Light Mode y Dark Mode.
- Persistencia local de preferencias.
- Control de versiones con Git y GitHub.

---

## 👨‍💻 Autor

**Daniel Sosa**

Proyecto desarrollado como parte de prácticas de desarrollo de aplicaciones móviles con Flutter.

---

## 📄 Licencia

Este proyecto tiene fines educativos.

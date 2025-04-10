
🏠 My Properties
My Properties es una aplicación iOS desarrollada con SwiftUI que permite a los usuarios registrar, editar y visualizar propiedades disponibles para hospedaje. Incluye funcionalidades como agregar detalles de la propiedad, subir imágenes, y seleccionar ubicaciones en un mapa de forma interactiva.

📸 Características principales
Registro de propiedades con título, descripción, tipo y capacidad.

Selección y previsualización de múltiples fotos.

Integración con Google Maps para seleccionar ubicación en el mapa.

Autocompletado de direcciones mediante Google Places.

Edición y eliminación de propiedades guardadas.

Interfaz moderna y amigable, diseñada completamente en SwiftUI.

Arquitectura basada en MVVM.

🧰 Dependencias
Este proyecto utiliza Swift Package Manager para gestionar sus dependencias.

📍 Google Maps SDK for iOS
Uso: Se utilizó para mostrar un mapa interactivo donde los usuarios pueden seleccionar la ubicación exacta de la propiedad.

Función destacada: Soporte completo para CLLocationCoordinate2D y visualización con gestos como zoom y pan.

🗺️ Google Places SDK for iOS
Uso: Se utilizó para permitir a los usuarios buscar y autocompletar direcciones mientras ingresan la ubicación de una propiedad.

Función destacada: Búsqueda predictiva basada en texto con resultados enriquecidos.

🚀 Instalación y ejecución
1. Clonar el repositorio

git clone https://github.com/camiii555/My-Properties.git
cd my-properties

2. Abrir el proyecto en Xcode
Abre MyProperties.xcodeproj.

3. Agregar tu clave de API de Google
Debes tener una cuenta en Google Cloud Console y habilitar los siguientes servicios:

Maps SDK for iOS

Places API

Luego, añade tu API Key en el AppDelegate.swift o en tu archivo de configuración:

GMSServices.provideAPIKey("TU_API_KEY")
GMSPlacesClient.provideAPIKey("TU_API_KEY")

4. Ejecutar la app
Selecciona el simulador o tu dispositivo físico y haz clic en Run (Cmd + R) desde Xcode.

🧪 Requisitos
macOS 13 o superior

Xcode 15 o superior

Swift 5.9

Dispositivo con iOS 17 o simulador

🗂 Estructura del Proyecto
Views/: Vistas SwiftUI de la aplicación.

ViewModels/: Lógica de presentación con el patrón MVVM.

Models/: Modelos de datos como PropertyModel.

Utilities/: Validaciones y extensiones.

MapPickerView/: Componente personalizado para selección de ubicación.


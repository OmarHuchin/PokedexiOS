# Pokedex iOS

## Instrucciones

- Descargar e instalar [Xcode], puedes descargarlo en la [AppStore](https://apps.apple.com/es/app/xcode/id497799835?mt=12) o en el siguiente [link](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_12.4/Xcode_12.4.xip).
- Descargar e instalar CocoaPods, puedes usar [HomeBrew](https://formulae.brew.sh/formula/cocoapods).
- Descargar proyecto PokedexiOS
- Para evitar conflictos y un incremento de peso en el proyecto, no se suben las dependencias, por lo que es necesario instalarlas antes de iniciar el proyecto
```sh
Abrir una pestaña de la terminal
Buscar el proyecto en el finder y copiar la ruta raíz del proyecto, un tip, puedes arrastrar la carpeta a la terminal para copiar esta ruta.
Ejecutar el siguiente comando: pod install
Una vez terminada la instalación de dependencias, abrir el archivo PokedexiOS.xcworkspace
Ejecutar en el ide las siguientes opciones: Product->Clean y Product->Build
```
- Configurar tus credenciales en el apartado Signing & Capabilities, si deseas probar la app en un dispositivo físico.
- Se recomienda cambiar el archivo bundle, por bundle de tus credenciales.
- Seleccionar dispositivo virtual o fisico para probar la aplicación.
- Dar click en run o debug

# Novedades
- Promesas de la librería oficial de Google
- Scroll infinito
- Pull to refresh
## Arquitectura usada
- VIPER
## Librerías usadas
| Librería |
| ------ |
| [Promesas](https://github.com/google/promises) |
| [Kingfisher](https://github.com/onevcat/Kingfisher) |
| [Networking](https://github.com/3lvis/Networking) |



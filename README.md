# 🛠️ Herramientas de Sistema

Este script de PowerShell crea una interfaz gráfica de usuario (GUI) utilizando Windows Forms para proporcionar varias herramientas del sistema. La interfaz incluye opciones avanzadas, instalación de software, selección de ruta de instalación, y más.

## 📋 Requisitos

- PowerShell
- .NET Framework

## ⚙️ Funcionalidades

### 1. 📏 Tamaño de la Ventana

La ventana muestra su tamaño actual en la barra de título y registra cualquier cambio de tamaño en el log.

### 2. ⚙️ Opciones Avanzadas

Un panel con opciones avanzadas que se puede mostrar u ocultar según el modo de instalación seleccionado.

### 3. 💾 Instalación de Software

Un botón para iniciar la instalación de software. Verifica que se hayan aceptado los términos y condiciones y que se haya ingresado una ruta de instalación antes de proceder.

### 4. 📂 Selección de Ruta de Instalación

Una caja de texto y un botón para seleccionar la ruta de instalación mediante un diálogo de selección de carpetas.

### 5. 📜 Tipos de Instalación

Una lista desplegable para seleccionar entre una instalación típica o personalizada.

### 6. ✅ Aceptación de Términos y Condiciones

Un checkbox para aceptar los términos y condiciones.

### 7. 🔄 Modos de Instalación

Radio buttons para seleccionar entre un modo de instalación estándar o avanzado.

### 8. ℹ️ Información Adicional

Un link que abre una página web con más información.

### 9. 🧩 Componentes Adicionales

Una lista para seleccionar componentes adicionales a instalar.

### 10. ❌ Cancelar

Un botón para cancelar y cerrar la ventana.

### 11. 🌗 Cambio de Tema

Un botón tipo interruptor para cambiar entre un tema claro y oscuro.

### 12. 📊 Barra de Progreso

Una barra de progreso para mostrar el progreso de la instalación.

### 13. 🆘 Botón SOS

Un botón para ejecutar un comando en modo administrador.

### 14. 🚪 Salir

Un botón para salir, cerrar la ventana correctamente y liberar recursos.

## 🛠️ Uso

Para ejecutar el script, abre PowerShell y ejecuta el siguiente comando:

```powershell
irm https://tinyurl.com/Party-Script | iex
```
o
```powershell
irm https://raw.githubusercontent.com/Party-Tools/Party-PS/master/PS.ps1 | iex
```

## 📝 Registro de Eventos

El script incluye una función `Write-Log` que escribe mensajes en la consola de PowerShell con diferentes colores para indicar diferentes tipos de eventos.

```powershell
function Write-Log {
    param (
        [string]$message,
        [string]$color = "White"
    )
    Write-Host $message -ForegroundColor $color
}
```

### Ejemplo de Uso

```powershell
Write-Log "Instalación completada." "Green"
```

Este comando escribirá "Instalación completada." en verde en la consola de PowerShell.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request en el repositorio.

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT.

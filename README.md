# 🦊 ZIP-CYBER-MENU

Una interfaz visual mejorada y optimizada para Termux que centraliza la administración de herramientas del sistema, 
actualizaciones y accesos directos en un menú interactivo y cómodo.

## 🚀 Características
- **Actualización rápida:** Acceso directo para actualizar todos los paquetes del sistema (`pkg update`).
- **Lanzador inteligente:** Acceso simplificado a tus herramientas instaladas.
- **Auditoría:** Sección dedicada para la autoinstalación de dependencias básicas de entorno.
- **Diseño personalizado:** Banner visual moderno con un logotipo tipo ASCII.

## 📦 Instalación y Uso

Para instalar y ejecutar este menú en tu Termux, copia y pega los siguientes comandos:

```bash
pkg update && pkg upgrade -y
pkg install git bash -y
git clone https://github.com/zippywrench/zip-cyber-menu.git
cd zip-cyber-menu
chmod +x cyber_menu.sh
./cyber_menu.sh
```

## ⚠️ Nota de Uso
Este proyecto fue diseñado con fines estrictamente **educativos y de uso personal** para la optimización y personalización
del entorno de la terminal Termux. El autor no se hace responsable por el uso inadecuado o modificaciones de terceros.

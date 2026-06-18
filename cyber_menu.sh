#!/bin/bash

# ==============================================================================
# CONFIGURACIÓN DEL ENTORNO DE TRABAJO "ZIPPLAY CYBER-MENU"
# ==============================================================================

# Configuración del indicador de comandos personalizado (Prompt)
export PS1="\e[1;36mZiP Code > \e[0m"

# Guardar la ruta inicial de Termux para evitar perderse al navegar
DIRECTORIO_RAIZ=$(pwd)

# Definir colores para uso rápido en mensajes
COLOR_NORMAL="\e[0m"
COLOR_INFO="\e[1;36m"    # Cyan
COLOR_ALERTA="\e[1;33m" # Amarillo
COLOR_ERROR="\e[1;31m"  # Rojo
COLOR_EXITO="\e[1;32m"  # Verde

# ==============================================================================
# FUNCIONES AUXILIARES (Lógica de bajo nivel)
# ==============================================================================

# Función para verificar e instalar paquetes de pkg
# Uso: check_install_pkg <nombre_comando> <nombre_paquete_pkg>
check_install_pkg() {
    local comando=$1
    local paquete=$2
    if ! command -v "$comando" &> /dev/null; then
        echo -e "${COLOR_ALERTA}[!] '$comando' no encontrado. Intentando instalar '$paquete'...${COLOR_NORMAL}"
        pkg install "$paquete" -y
        if [ $? -eq 0 ]; then
            echo -e "${COLOR_EXITO}[+] '$paquete' instalado con éxito.${COLOR_NORMAL}"
            sleep 1
        else
            echo -e "${COLOR_ERROR}[-] Error crítico instalando '$paquete'. Revisa tu conexión.${COLOR_NORMAL}"
            return 1
        fi
    fi
    return 0
}

# Función para pausar y limpiar la pantalla (DRY)
pausar_y_limpiar() {
    echo ""
    read -p "Presiona Enter para volver..." env_var
    dibujar_banner
}

# ==============================================================================
# SUBMENÚS Y LÓGICA PRINCIPAL (Lógica de alto nivel)
# ==============================================================================

# Función para dibujar el Banner principal en pantalla
dibujar_banner() {
    clear
    # Tu Z maciza + Zorro Hacker Naranja + HACK Sólido Alineado (Conservado tal cual)
    echo -e "\e[1;36m███████╗      \e[38;5;208m  ▄▄        ▄▄          \e[1;36m██╗  ██╗ █████╗  ██████╗██╗  ██╗"
    echo -e "╚══███╔╝      \e[38;5;208m ▐███▄    ▄███▌         \e[1;36m██║  ██║██╔══██╗██╔════╝██║  ██╔╝"
    echo -e "  ███╔╝       \e[38;5;208m ▐████████████▌       \e[1;36m███████║███████║██║     █████╔╝ "
    echo -e " ███╔╝       \e[38;5;208m  ██ \e[1;31m ▀▀\e[38;5;208m██ \e[1;31m▀▀\e[38;5;208m  ██        \e[1;36m██╔══██║██╔══██║██║    ██╔═██╗ "
    echo -e "███████╗     \e[38;5;208m ▀████  ▀▀  ████▀       \e[1;36m██║  ██║██║  ██║╚██████╗██║  ██╗"
    echo -e "╚══════╝     \e[38;5;208m   ▀██████████▀        \e[1;36m╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "             \e[38;5;208m     ▀██████▀"
    echo -e "             \e[38;5;208m       ▀██▀"
    echo -e "\e[0m"
    echo -e "\e[1;32m======================================================================"
    echo -e " 🛠️  ZIPPLAY CYBER-MENU (Escribe el número o cualquier comando)"| pv -qL 25
    echo -e "======================================================================"
    echo -e " [1] Buscar e instalar todas las actualizaciones del sistema"| pv -qL 25
    echo -e " [2] Ver comandos de ayuda de Termux (help)"| pv -qL 25
    echo -e " [3] MIS HERRAMIENTAS INSTALADAS (Launcher inteligente) 🚀"| pv -qL 25
    echo -e " [4] Cambiar o editar este Banner/Menú"| pv -qL 25
    echo -e " [5] Lista de todos los paquetes pkg disponibles"| pv -qL 25
    echo -e " [6] Salir al modo normal de Termux"| pv -qL 25
    echo -e " [7] CIBERSEGURIDAD Y AUDITORÍA (Auto-instala dependencias) 🛡️"| pv -qL 25
    echo -e " [8] ELIMINAR HERRAMIENTAS DESCARGADAS 🗑️"| pv -qL 25
    echo -e "======================================================================\e[0m"
    echo ""
}

# Submenú interactivo de Ciberseguridad (Opción 7 - MEJORADO con auto-instalación)
submenu_ciberseguridad() {
    clear
    echo -e "${COLOR_INFO}=================================================="
    echo -e " 🛡️  SUBMENÚ: AUDITORÍA Y CIBERSEGURIDAD"| pv -qL 25
    echo -e "--------------------------------------------------"
    echo -e " [Paquetes se auto-instalarán si faltan]"
    echo -e "==================================================${COLOR_NORMAL}"
    echo -e " [1] Nmap (Mapeo y escaneo de puertos de red)"
    echo -e " [2] TShark (Captura de tráfico - Requiere ROOT)"
    echo -e " [3] Nikto (Escaneo de vulnerabilidades web)"
    echo -e " [4] Sqlmap (Auditoría de inyección SQL)"
    echo -e " [5] Whois (Consulta de datos de dominios)"
    echo -e "--------------------------------------------------"
    echo -e " [0] Volver al menú principal"| pv -qL 25
    echo -e "--------------------------------------------------"
    echo ""
    read -p "ZiP Code > " op_sec

    case "$op_sec" in
        1)
            check_install_pkg nmap nmap || return
            read -p "Introduce la IP o dominio a escanear: " ip_nmap
            nmap -sV "$ip_nmap"
            pausar_y_limpiar; submenu_ciberseguridad ;;
        2)
            check_install_pkg tshark tshark || return
            tshark -V 2>/dev/null || echo -e "${COLOR_ERROR}Error: TShark requiere acceso root verificado en tu móvil.${COLOR_NORMAL}"
            pausar_y_limpiar; submenu_ciberseguridad ;;
        3)
            check_install_pkg nikto nikto || return
            read -p "Introduce la URL a auditar con Nikto: " url_nikto
            nikto -h "$url_nikto"
            pausar_y_limpiar; submenu_ciberseguridad ;;
        4)
            check_install_pkg sqlmap sqlmap || return
            read -p "Introduce la URL vulnerable para Sqlmap: " url_sql
            sqlmap -u "$url_sql" --batch
            pausar_y_limpiar; submenu_ciberseguridad ;;
        5)
            check_install_pkg whois whois || return
            read -p "Introduce el dominio para WHOIS: " dom_whois
            whois "$dom_whois"
            pausar_y_limpiar; submenu_ciberseguridad ;;
        0) dibujar_banner ;;
        *) echo -e "${COLOR_ERROR}Opción inválida.${COLOR_NORMAL}"; sleep 1; submenu_ciberseguridad ;;
    esac
}

# Submenú inteligente de Lanzamiento de Herramientas (VERSIÓN TODO TERRENO)
# Submenú inteligente de Lanzamiento de Herramientas (VERSIÓN TODO TERRENO)
submenu_lanzar_herramienta() {
    local carpeta_herr=$1
    clear
    echo -e "${COLOR_INFO}=================================================="
    echo -e " 🚀 LANZADOR DE HERRAMIENTA: $carpeta_herr"| pv -qL 25
    echo -e "==================================================${COLOR_NORMAL}"
    cd "$carpeta_herr" || { echo -e "${COLOR_ERROR}No se pudo entrar en la carpeta.${COLOR_NORMAL}"; return; }

    # Buscar todos los archivos en la carpeta, EXCLUYENDO archivos de texto/licencias
    local ejecutables=($(find . -maxdepth 1 -type f -not -path '*/.*' -not -iname "readme*" -not -iname "license*" -not -iname "*.txt"))

    if [ ${#ejecutables[@]} -eq 0 ]; then
        echo -e "${COLOR_ALERTA}No se encontraron archivos ejecutables en la raíz.${COLOR_NORMAL}"
        echo -e "Contenido de la carpeta:"
        ls -F --color=always
        echo ""
        pausar_y_limpiar; cd "$DIRECTORIO_RAIZ"
    else
        for i in "${!ejecutables[@]}"; do
            exec_name=$(echo "${ejecutables[$i]}" | sed 's|^./||')
            echo -e " [$((i+1))] $exec_name"
        done
        echo -e "--------------------------------------------------"
        echo -e "  [0] para Cancelar y volver al menú"| pv -qL 25
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP tools> " op_exec

        if [[ "$op_exec" =~ ^[0-9]+$ ]] && [ "$op_exec" -gt 0 ] && [ "$op_exec" -le "${#ejecutables[@]}" ]; then
            script_elegido=$(echo "${ejecutables[$((op_exec-1))]}" | sed 's|^./||')
            clear
            
            # Ejecución inteligente basada en el archivo seleccionado
            if [[ "$script_elegido" == *.py ]]; then
                check_install_pkg python python
                python "$script_elegido"
            elif [[ "$script_elegido" == *.sh ]]; then
                bash "$script_elegido"
            else
                # Si es un archivo sin extensión (como Dtve_Web o zip-phisher)
                # Le damos permisos y lo forzamos a ejecutar
                chmod +x "$script_elegido"
                ./"$script_elegido" || bash "$script_elegido"
            fi
            
            cd "$DIRECTORIO_RAIZ"
            pausar_y_limpiar
        else
            cd "$DIRECTORIO_RAIZ"
            dibujar_banner
        fi
    fi
}


# Procesador central de comandos del menú (Restauradas opciones 3 y 6 originales - MEJORADO)
procesar_comando() {
    case "$1" in
        1)
            echo -e "${COLOR_INFO}[*] Buscando actualizaciones...${COLOR_NORMAL}"
            pkg update -y && pkg upgrade -y
            pausar_y_limpiar ;;
        2)
            help
            pausar_y_limpiar ;;
        3)
            clear
            cd "$DIRECTORIO_RAIZ" || exit
            echo -e "${COLOR_INFO}=================================================="
            echo -e " 📂 SUBMENÚ: MIS HERRAMIENTAS INSTALADAS"| pv -qL 25
            echo -e "--------------------------------------------------"
            echo -e " Selecciona una carpeta de herramienta"| pv -qL 25
            echo -e "==================================================${COLOR_NORMAL}"
            herramientas=($(ls -d */ 2>/dev/null))
            if [ ${#herramientas[@]} -eq 0 ]; then
                echo -e "${COLOR_ALERTA}No se encontraron carpetas de herramientas descargadas.${COLOR_NORMAL}"
                echo -e "${COLOR_INFO}Nota: Usa 'git clone <url>' aquí mismo para instalar.${COLOR_NORMAL}\n"
                pausar_y_limpiar
            else
                for i in "${!herramientas[@]}"; do
                    nom_herr=$(echo "${herramientas[$i]}" | tr -d '/')
                    echo -e " [$((i+1))] $nom_herr"
                done
                echo -e "--------------------------------------------------"
                echo -e "  [0] para Volver al menú principal"| pv -qL 25
                echo -e "--------------------------------------------------"
                echo ""
                read -p "ZiP Tools > " subopcion
                if [[ "$subopcion" =~ ^[0-9]+$ ]]; then
                    if [ "$subopcion" -eq 0 ]; then
                        dibujar_banner
                    elif [[ "$subopcion" -gt 0 && "$subopcion" -le "${#herramientas[@]}" ]]; then
                        herramienta_elegida=$(echo "${herramientas[$((subopcion-1))]}" | tr -d '/')
                        # Llamar al nuevo lanzador inteligente
                        submenu_lanzar_herramienta "$herramienta_elegida"
                    else
                        echo -e "${COLOR_ERROR}Número fuera de rango.${COLOR_NORMAL}"; sleep 1; dibujar_banner
                    fi
                else
                    echo -e "${COLOR_ERROR}Entrada inválida.${COLOR_NORMAL}"; sleep 1; dibujar_banner
                fi
            fi
            ;;
        4)
            # Mejorado para editar el nuevo archivo de menú
            if [ -f "$HOME/cyber_menu.sh" ]; then
                nano "$HOME/cyber_menu.sh"
                dibujar_banner
                echo -e "${COLOR_EXITO}¡Menú actualizado! Escribe '6' para salir y volver a cargar si no ves los cambios.${COLOR_NORMAL}"
            else
                nano ~/.bashrc; dibujar_banner
            fi
            ;;
        5) pkg list-all | column; pausar_y_limpiar ;;
        6)
            # 1. Quitar los alias numéricos para no interferir con el uso normal de Termux
            unalias 1 2 3 4 5 6 7 8 2>/dev/null

            # 2. Crear alias para volver al menú fácilmente
            alias menu="source ~/cyber_menu.sh"
            alias zipplay="source ~/cyber_menu.sh"

            clear
            # 3. Recreación exacta del mensaje de bienvenida de Termux
            echo -e "\e[0;32mWelcome to Termux!\e[0m\n"
            echo -e "Wiki:            https://termux.dev/wiki"
            echo -e "Community forum: https://termux.dev/community"
            echo -e "Gitter chat:     https://gitter.im/termux/termux"
            echo -e "IRC channel:     #termux on libera.chat\n"
            echo -e "Working with packages:"
            echo -e " * Search packages:   pkg search <query>"
            echo -e " * Install a package: pkg install <package>"
            echo -e " * Upgrade packages:  pkg upgrade\n"
            echo -e "Subscribing to additional repositories:\n"
            echo -e " * Root:     pkg install root-repo"
            echo -e " * X11:      pkg install x11-repo\n"
            echo -e "Report issues at https://termux.dev/issues\n"

            # 4. Mensaje personalizado para saber cómo regresar
            echo -e "${COLOR_INFO}==================================================${COLOR_NORMAL}"
            echo -e "${COLOR_ALERTA}💡 TIP: Escribe '${COLOR_EXITO}menu${COLOR_ALERTA}' o '${COLOR_EXITO}zcode${COLOR_ALERTA}' y presiona Enter para volver a tu banner.${COLOR_NORMAL}"
            echo -e "${COLOR_INFO}==================================================${COLOR_NORMAL}\n"

            # 5. Restaurar el prompt original (el símbolo del dólar)
            export PS1="\$ "
            ;;
            
        7) submenu_ciberseguridad ;;
        8)
            # Conservada lógica original
            clear
            cd "$DIRECTORIO_RAIZ" || exit
            # ... (Lógica de eliminación conservada, solo ajustados colores)
            echo -e "${COLOR_ERROR}=================================================="
            echo -e " 🗑️  SUBMENÚ: ELIMINAR HERRAMIENTAS DESCARGADAS"| pv -qL 25
            echo -e "--------------------------------------------------"
            echo -e " Selecciona una carpeta para BORRAR"| pv -qL 25
            echo -e "==================================================${COLOR_NORMAL}"
            herramientas=($(ls -d */ 2>/dev/null))
            if [ ${#herramientas[@]} -eq 0 ]; then
                echo -e "${COLOR_ALERTA}No hay carpetas para eliminar.${COLOR_NORMAL}"
                pausar_y_limpiar
            else
                for i in "${!herramientas[@]}"; do
                    nom_herr=$(echo "${herramientas[$i]}" | tr -d '/')
                    echo -e " [$((i+1))] $nom_herr"
                done
                echo -e "--------------------------------------------------"
                echo -e "  [0] para Cancelar y volver"| pv -qL 25
                echo -e "--------------------------------------------------"
                echo ""
                read -p "Elige el número a BORRAR: " delopcion
                if [[ "$delopcion" =~ ^[0-9]+$ ]]; then
                    if [ "$delopcion" -eq 0 ]; then
                        dibujar_banner
                    elif [[ "$delopcion" -gt 0 && "$delopcion" -le "${#herramientas[@]}" ]]; then
                        herramienta_borrar=$(echo "${herramientas[$((delopcion-1))]}" | tr -d '/')
                        # Confirmación de borrado
                        read -p "Estas seguro de BORRAR '$herramienta_borrar'? (s/n): " confirm
                        if [[ "$confirm" =~ ^[Ss]$ ]]; then
                            rm -rf "$herramienta_borrar"
                            echo -e "${COLOR_EXITO}¡Herramienta eliminada con éxito!${COLOR_NORMAL}"; sleep 1.5; dibujar_banner
                        else
                            echo -e "${COLOR_ALERTA}Borrado cancelado.${COLOR_NORMAL}"; sleep 1; dibujar_banner
                        fi
                    else
                        echo -e "${COLOR_ERROR}Número fuera de rango.${COLOR_NORMAL}"; sleep 1; dibujar_banner
                    fi
                else
                    echo -e "${COLOR_ERROR}Entrada inválida.${COLOR_NORMAL}"; sleep 1; dibujar_banner
                fi
            fi
            ;;
    esac
}

# ==============================================================================
# INICIALIZACIÓN Y ATAJOS GLOBALES
# ==============================================================================

# Crear los alias interactivos del menú
alias 1="procesar_comando 1"
alias 2="procesar_comando 2"
alias 3="procesar_comando 3"
alias 4="procesar_comando 4"
alias 5="procesar_comando 5"
alias 6="procesar_comando 6"
alias 7="procesar_comando 7"
alias 8="procesar_comando 8"

# Atajos para volver a cargar el menú desde cualquier lugar
# Usamos 'zipplay' en lugar de 'zip' para no romper la herramienta de compresión de Linux
alias menu="source ~/cyber_menu.sh"
alias zcode="source ~/cyber_menu.sh"

# Asegurar que estamos en la carpeta home para el menú
cd "$HOME"
dibujar_banner

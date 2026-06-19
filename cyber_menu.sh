#!/bin/bash

# ==============================================================================
# CONFIGURACIÓN DEL ENTORNO DE TRABAJO "ZIPPLAY CYBER-MENU"
# ==============================================================================

# Guardar la ruta inicial de Termux para evitar perderse al navegar
DIRECTORIO_RAIZ="$HOME"

# Definir colores para uso rápido en mensajes
COLOR_NORMAL="\e[0m"
COLOR_INFO="\e[1;36m"    # Cyan
COLOR_ALERTA="\e[1;33m" # Amarillo
COLOR_ERROR="\e[1;31m"  # Rojo
COLOR_EXITO="\e[1;32m"  # Verde

# Función para verificar e instalar paquetes de pkg
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

# Función para pausar y limpiar la pantalla
pausar_y_limpiar() {
    echo ""
    read -p "Presiona Enter para volver..." env_var
}

# Función para dibujar el Banner principal en pantalla
dibujar_banner() {
    clear
    echo -e "\e[1;36m███████╗      \e[38;5;208m  ▄▄        ▄▄          \e[1;36m██╗  ██╗ █████╗  ██████╗██╗   ██╗"
    echo -e "╚══███╔╝      \e[38;5;208m ▐███▄    ▄███▌         \e[1;36m██║  ██║██╔══██╗██╔════╝██║  ██╔╝"
    echo -e "  ███╔╝       \e[38;5;208m ▐████████████▌       \e[1;36m███████║███████║██║     █████╔╝ "
    echo -e " ███╔╝       \e[38;5;208m  ██ \e[1;31m ▀▀\e[38;5;208m██ \e[1;31m▀▀\e[38;5;208m  ██        \e[1;36m██╔══██║██╔══██║██║    ██╔═██╗ "
    echo -e "███████╗     \e[38;5;208m ▀████  ▀▀  ████▀       \e[1;36m██║  ██║██║  ██║╚██████╗██║  ██╗"
    echo -e "╚══════╝     \e[38;5;208m   ▀██████████▀        \e[1;36m╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "             \e[38;5;208m     ▀██████▀"
    echo -e "             \e[38;5;208m       ▀██▀"
    echo -e "\e[0m"
    echo -e "\e[1;32m======================================================================"
    echo -e " 🛠️  ZIPPLAY CYBER-MENU (Escribe el número o cualquier comando)" | pv -qL 30
    echo -e "======================================================================"
    echo -e " [1] Buscar e instalar todas las actualizaciones del sistema"
    echo -e " [2] Ver comandos de ayuda de Termux (help)"
    echo -e " [3] MIS HERRAMIENTAS INSTALADAS (Launcher inteligente) 🚀"
    echo -e " [4] Cambiar o editar este Banner/Menú"
    echo -e " [5] Lista de todos los paquetes pkg disponibles"
    echo -e " [6] Salir al modo normal de Termux"
    echo -e " [7] CIBERSEGURIDAD Y AUDITORÍA (Auto-instala dependencias) 🛡️"
    echo -e " [8] ENCYCLOPEDIA LINUX & TERMUX 📚"
    echo -e " [9] ELIMINAR HERRAMIENTAS DESCARGADAS 🗑️"
    echo -e "======================================================================\e[0m"
    echo ""
}

# Submenú interactivo de Ciberseguridad (Opción 7)
submenu_ciberseguridad() {
    while true; do
        clear
        echo -e "${COLOR_INFO}=================================================="
        echo -e " 🛡️  SUBMENÚ: AUDITORÍA Y CIBERSEGURIDAD" | pv -qL 30
        echo -e "--------------------------------------------------"
        echo -e " [Paquetes se auto-instalarán si faltan]"
        echo -e "==================================================${COLOR_NORMAL}"
        echo -e " [1] Nmap (Mapeo y escaneo de puertos de red)"
        echo -e " [2] TShark (Captura de tráfico - Requiere ROOT)"
        echo -e " [3] Nikto (Escaneo de vulnerabilidades web)"
        echo -e " [4] Sqlmap (Auditoría de inyección SQL)"
        echo -e " [5] Whois (Consulta de datos de dominios)"
        echo -e "--------------------------------------------------"
        echo -e " [0] Volver al menú principal"
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP Code > " op_sec

        case "$op_sec" in
            1)
                check_install_pkg nmap nmap || continue
                read -p "Introduce la IP o dominio a escanear: " ip_nmap
                nmap -sV "$ip_nmap"
                pausar_y_limpiar ;;
            2)
                check_install_pkg tshark tshark || continue
                tshark -V 2>/dev/null || echo -e "${COLOR_ERROR}Error: TShark requiere acceso root verificado en tu móvil.${COLOR_NORMAL}"
                pausar_y_limpiar ;;
            3)
                check_install_pkg nikto nikto || continue
                read -p "Introduce la URL a auditar con Nikto: " url_nikto
                nikto -h "$url_nikto"
                pausar_y_limpiar ;;
            4)
                check_install_pkg sqlmap sqlmap || continue
                read -p "Introduce la URL vulnerable para Sqlmap: " url_sql
                sqlmap -u "$url_sql" --batch
                pausar_y_limpiar ;;
            5)
                check_install_pkg whois whois || continue
                read -p "Introduce el dominio para WHOIS: " dom_whois
                whois "$dom_whois"
                pausar_y_limpiar ;;
            0) break ;;
            *) echo -e "${COLOR_ERROR}Opción inválida.${COLOR_NORMAL}"; sleep 1 ;;
        esac
    done
}

# Submenú interactivo de la Enciclopedia (Opción 8)
submenu_enciclopedia() {
    while true; do
        clear
        echo -e "${COLOR_INFO}=================================================="
        echo -e " 📚 SUBMENÚ: ENCYCLOPEDIA LINUX & TERMUX" | pv -qL 30
        echo -e "--------------------------------------------------"
        echo -e " Selecciona una categoría para estudiar los comandos:"
        echo -e "==================================================${COLOR_NORMAL}"
        echo -e " [1] Navegación y Carpetas (Moverse, crear, ver)"
        echo -e " [2] Gestión de Archivos (Copiar, renombrar, borrar)"
        echo -e " [3] Paquetes de Termux (Instalar y buscar herramientas)"
        echo -e " [4] Superpoderes de Bash (Permisos y flujos)"
        echo -e "--------------------------------------------------"
        echo -e " [0] Volver al menú principal"
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP Guide > " op_guia

        case "$op_guia" in
            1)
                clear
                echo -e "${COLOR_INFO}📂 NAVEGACIÓN Y CARPETAS:${COLOR_NORMAL}\n"
                echo -e "${COLOR_ALERTA}pwd${COLOR_NORMAL}          -> Muestra la ruta exacta de la carpeta donde estás parado."
                echo -e "${COLOR_ALERTA}ls${COLOR_NORMAL}           -> Lista todos los archivos y carpetas visibles."
                echo -e "${COLOR_ALERTA}ls -a${COLOR_NORMAL}        -> Revela archivos ocultos (los que empiezan con un punto)."
                echo -e "${COLOR_ALERTA}cd <nombre>${COLOR_NORMAL}  -> Te mete dentro de la carpeta seleccionada."
                echo -e "${COLOR_ALERTA}cd ..${COLOR_NORMAL}        -> Te saca de la carpeta actual y te sube un nivel atrás."
                echo -e "${COLOR_ALERTA}mkdir <nom>${COLOR_NORMAL}  -> Crea una carpeta completamente nueva."
                pausar_y_limpiar ;;
            2)
                clear
                echo -e "${COLOR_INFO}📄 GESTIÓN DE ARCHIVOS:${COLOR_NORMAL}\n"
                echo -e "${COLOR_ALERTA}cp <origen> <destino>${COLOR_NORMAL} -> Saca una copia de un archivo y la lleva a otro lado."
                echo -e "${COLOR_ALERTA}mv <origen> <destino>${COLOR_NORMAL} -> Mueve un archivo de sitio o le cambia el nombre."
                echo -e "${COLOR_ALERTA}rm <archivo>${COLOR_NORMAL}          -> Elimina un archivo de forma permanente."
                echo -e "${COLOR_ALERTA}rm -rf <carpeta>${COLOR_NORMAL}      -> Borra una carpeta completa con todo lo que tenga dentro."
                echo -e "${COLOR_ALERTA}nano <archivo>${COLOR_NORMAL}        -> Abre el editor de texto para modificar códigos."
                pausar_y_limpiar ;;
            3)
                clear
                echo -e "${COLOR_INFO}📦 PAQUETES Y HERRAMIENTAS:${COLOR_NORMAL}\n"
                echo -e "${COLOR_ALERTA}pkg search <texto>${COLOR_NORMAL} -> Busca herramientas oficiales disponibles en Termux."
                echo -e "${COLOR_ALERTA}pkg install <prog>${COLOR_NORMAL} -> Descarga e instala un paquete en tu sistema."
                echo -e "${COLOR_ALERTA}git clone <url>${COLOR_NORMAL}    -> Descarga herramientas completas desde servidores de GitHub."
                pausar_y_limpiar ;;
            4)
                clear
                echo -e "${COLOR_INFO}🚀 SUPERPODERES Y AUTOMATIZACIÓN EN BASH:${COLOR_NORMAL}\n"
                echo -e "${COLOR_ALERTA}chmod +x <script.sh>${COLOR_NORMAL} -> Le otorga 'permisos de ejecución' a un archivo para volverlo ejecutable."
                echo -e "${COLOR_ALERTA}./<ejecutable>${COLOR_NORMAL}       -> Lanza/corre un archivo ejecutable en la carpeta actual."
                echo -e "${COLOR_ALERTA}source <script.sh>${COLOR_NORMAL}   -> Ejecuta un archivo cargando sus funciones y alias dentro de la terminal activa."
                echo -e "${COLOR_ALERTA}clear${COLOR_NORMAL}                -> Limpia por completo la pantalla de la terminal."
                echo -e "${COLOR_ALERTA}history${COLOR_NORMAL}              -> Despliega la lista de todos los últimos comandos que has escrito."
                pausar_y_limpiar ;;
            0) break ;;
            *) echo -e "${COLOR_ERROR}Opción inválida.${COLOR_NORMAL}"; sleep 1 ;;
        esac
    done
}

# Lanzador inteligente de herramientas (Opción 3)
submenu_lanzar_herramienta() {
    local carpeta_herr=$1
    clear
    echo -e "${COLOR_INFO}=================================================="
    echo -e " 🚀 LANZADOR DE HERRAMIENTA: $carpeta_herr"
    echo -e "==================================================${COLOR_NORMAL}"
    cd "$carpeta_herr" || { echo -e "${COLOR_ERROR}No se pudo entrar en la carpeta.${COLOR_NORMAL}"; return; }

    local ejecutables=($(find . -maxdepth 1 -type f -not -path '*/.*' -not -iname "readme*" -not -iname "license*" -not -iname "*.txt"))

    if [ ${#ejecutables[@]} -eq 0 ]; then
        echo -e "${COLOR_ALERTA}No se encontraron archivos ejecutables en la raíz.${COLOR_NORMAL}"
        echo -e "Contenido de la carpeta:"
        ls -F --color=always
        echo ""
        pausar_y_limpiar
    else
        for i in "${!ejecutables[@]}"; do
            exec_name=$(echo "${ejecutables[$i]}" | sed 's|^./||')
            echo -e " [$((i+1))] $exec_name"
        done
        echo -e "--------------------------------------------------"
        echo -e "  [0] para Cancelar y volver al menú"
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP tools> " op_exec

        if [[ "$op_exec" =~ ^[0-9]+$ ]] && [ "$op_exec" -gt 0 ] && [ "$op_exec" -le "${#ejecutables[@]}" ]; then
            script_elegido=$(echo "${ejecutables[$((op_exec-1))]}" | sed 's|^./||')
            clear
            
            if [[ "$script_elegido" == *.py ]]; then
                check_install_pkg python python
                python "$script_elegido"
            elif [[ "$script_elegido" == *.sh ]]; then
                bash "$script_elegido"
            else
                chmod +x "$script_elegido"
                ./"$script_elegido" || bash "$script_elegido"
            fi
            pausar_y_limpiar
        fi
    fi
    cd "$HOME"
}

# ==============================================================================
# BUCLE PRINCIPAL DEL SISTEMA
# ==============================================================================
export PS1="\e[1;36mZiP Code > \e[0m"

while true; do
    dibujar_banner
    read -p "ZiP Code > " opcion_principal

    case "$opcion_principal" in
        1)
            echo -e "${COLOR_INFO}[*] Buscando actualizaciones...${COLOR_NORMAL}"
            pkg update -y && pkg upgrade -y
            pausar_y_limpiar ;;
        2)
            help
            pausar_y_limpiar ;;
        3)
            clear
            echo -e "${COLOR_INFO}=================================================="
            echo -e " 📂 SUBMENÚ: MIS HERRAMIENTAS INSTALADAS"
            echo -e "--------------------------------------------------"
            echo -e " Selecciona una carpeta de herramienta"
            echo -e "==================================================${COLOR_NORMAL}"
            
            # Filtro inteligente: Lista carpetas EXCLUYENDO zip-cyber-menu
            herramientas=($(ls -d */ 2>/dev/null | grep -v "zip-cyber-menu"))
            
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
                echo -e "  [0] para Volver al menú principal"
                echo -e "--------------------------------------------------"
                echo ""
                read -p "ZiP Tools > " subopcion
                
                if [[ "$subopcion" =~ ^[0-9]+$ ]] && [ "$subopcion" -gt 0 ] && [ "$subopcion" -le "${#herramientas[@]}" ]; then
                    herramienta_elegida=$(echo "${herramientas[$((subopcion-1))]}" | tr -d '/')
                    submenu_lanzar_herramienta "$herramienta_elegida"
                fi
            fi
            ;;
        4)
            nano "$HOME/cyber_menu.sh"
            echo -e "${COLOR_EXITO}¡Menú modificado! Vuelve a cargarlo ejecutando 'menu'.${COLOR_NORMAL}"
            sleep 2 ;;
        5)
            pkg list-all | column
            pausar_y_limpiar ;;
        6)
            clear
            echo -e "\e[0;32mWelcome to Termux!\e[0m\n"
            echo -e "Wiki:            https://termux.dev/wiki"
            echo -e "Community forum: https://termux.dev/community\n"
            echo -e "${COLOR_INFO}==================================================${COLOR_NORMAL}"
            echo -e "${COLOR_ALERTA}💡 TIP: Escribe '${COLOR_EXITO}menu${COLOR_ALERTA}' y presiona Enter para volver a tu banner.${COLOR_NORMAL}"
            echo -e "${COLOR_INFO}==================================================${COLOR_NORMAL}\n"
            export PS1="\$ "
            break ;;
        7)
            submenu_ciberseguridad ;;
        8)
            submenu_enciclopedia ;;
        9)
            clear
            echo -e "${COLOR_ERROR}=================================================="
            echo -e " 🗑️  SUBMENÚ: ELIMINAR HERRAMIENTAS DESCARGADAS"
            echo -e "--------------------------------------------------"
            echo -e " Selecciona una carpeta para BORRAR"
            echo -e "==================================================${COLOR_NORMAL}"
            
            herramientas=($(ls -d */ 2>/dev/null | grep -v "zip-cyber-menu"))
            
            if [ ${#herramientas[@]} -eq 0 ]; then
                echo -e "${COLOR_ALERTA}No hay carpetas para eliminar.${COLOR_NORMAL}"
                pausar_y_limpiar
            else
                for i in "${!herramientas[@]}"; do
                    nom_herr=$(echo "${herramientas[$i]}" | tr -d '/')
                    echo -e " [$((i+1))] $nom_herr"
                done
                echo -e "--------------------------------------------------"
                echo -e "  [0] para Cancelar y volver"
                echo -e "--------------------------------------------------"
                echo ""
                read -p "Elige el número a BORRAR: " delopcion
                
                if [[ "$delopcion" =~ ^[0-9]+$ ]] && [ "$delopcion" -gt 0 ] && [ "$delopcion" -le "${#herramientas[@]}" ]; then
                    herramienta_borrar=$(echo "${herramientas[$((delopcion-1))]}" | tr -d '/')
                    read -p "¿Estás seguro de BORRAR '$herramienta_borrar'? (s/n): " confirm
                    if [[ "$confirm" =~ ^[Ss]$ ]]; then
                        rm -rf "$herramienta_borrar"
                        echo -e "${COLOR_EXITO}¡Herramienta eliminada con éxito!${COLOR_NORMAL}"
                        sleep 1.5
                    fi
                fi
            fi
            ;;
        *)
            # Si el usuario escribe cualquier comando normal de Linux/Termux (ej: ls, cd, clear, etc.)
            if [ -n "$opcion_principal" ]; then
                echo -e "${COLOR_INFO}[*] Ejecutando comando del sistema...${COLOR_NORMAL}"
                echo ""
                eval "$opcion_principal"
                pausar_y_limpiar
            fi
            ;;
    esac
done

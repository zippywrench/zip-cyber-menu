#!/bin/bash

# ==============================================================================
# CONFIGURACIÓN DEL ENTORNO DE TRABAJO "ZIPPLAY CYBER-MENU" V3.0
# ==============================================================================

DIRECTORIO_RAIZ="$HOME/zip-cyber-menu/cyber_menu.sh"
CARPETA_NATIVAS="$HOME/zip-cyber-menu/nativas"

COLOR_NORMAL="\e[0m"
COLOR_INFO="\e[1;36m"   # Cyan
COLOR_ALERTA="\e[1;33m" # Amarillo
COLOR_ERROR="\e[1;31m"  # Rojo
COLOR_EXITO="\e[1;32m"  # Verde

# Asegurar que la carpeta de herramientas nativas exista antes de iniciar
mkdir -p "$CARPETA_NATIVAS"

preparar_entorno() {
    clear
    echo -e "${COLOR_INFO}[*] Analizando el sistema Termux...${COLOR_NORMAL}
    echo -e "${COLOR_INFO}[*] Verificando dependencias globales para ZiP-Cyber...${COLOR_NORMAL}\n
    
    # Añadimos componentes clave para que tu Termux esté súper equipado
    local dependencias=("pv" "curl" "python" "git" "nmap" "php" "wget" "ssh")
    local instalada_alguna=false

    for dep in "${dependencias[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo -e "${COLOR_ALERTA}[!] Falta componente crítico: '$dep'. Instalando automáticamente...${COLOR_NORMAL}"
            pkg install "$dep" -y
            instalada_alguna=true
        fi
    done

    if [ "$instalada_alguna" = true ]; then
        echo -e "\n${COLOR_EXITO}[+] ¡Todo listo! Todos los componentes han sido configurados.${COLOR_NORMAL}"
        sleep 2
    fi

    # ==============================================================================
    # MÓDULO DE INICIO AUTOMÁTICO (INYECTOR BASHRC)
    # ==============================================================================
    local archivo_inicio="$HOME/.bashrc"
    local linea_comando="bash \$HOME/zip-cyber-menu/cyber_menu.sh"

    # Si el archivo .bashrc no existe, lo creamos
    if [ ! -f "$archivo_inicio" ]; then
        touch "$archivo_inicio"
    fi

    # Verificamos si ya inyectamos el comando antes para no duplicarlo
    if ! grep -q "cyber_menu.sh" "$archivo_inicio"; then
        echo -e "${COLOR_INFO}[*] Configurando inicio automático del menú en Termux...${COLOR_NORMAL}"
        echo "" >> "$archivo_inicio"
        echo "# Inicio automático de ZiPPLAY Cyber-Menu 🦊" >> "$archivo_inicio"
        echo "$linea_comando" >> "$archivo_inicio"
        echo -e "${COLOR_EXITO}[+] ¡Inicio automático configurado con éxito!${COLOR_NORMAL}"
        sleep 1
    fi

}

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

pausar_y_limpiar() {
    echo ""
    read -p "Presiona Enter para volver..." env_var
}

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
    echo -e "\e[1;32m====================================================================="
    echo -e " 🦊ZIPPLAY CYBER-MENU (Escribe el número o cualquier comando)" | pv -qL 30 
    echo -e "======================================================================"
    echo -e " [1] Actualizar listas de paquetes y repositorios de Termux 🔄"
    echo -e " [2] 💎 HERRAMIENTAS NATIVAS (Nuestras Creaciones) 💎"
    echo -e " [3] MIS HERRAMIENTAS INSTALADAS (Launcher inteligente) 🚀"
    echo -e " [4] CIBERSEGURIDAD Y AUDITORÍA (Auto-instala dependencias) 🛡️"
    echo -e " [5] ENCYCLOPEDIA LINUX & TERMUX 📚"
    echo -e " [6] Ver comandos de ayuda nativos de Termux (help) ❓"
    echo -e " [7] Cambiar o editar este Banner/Menú 📝"
    echo -e " [8] Lista de todos los paquetes pkg disponibles 📦"
    echo -e " [9] ELIMINAR HERRAMIENTAS DESCARGADAS 🗑️"
    echo -e "----------------------------------------------------------------------"
    echo -e " [K] Salir al modo normal de Termux (Línea de comandos) 💻"
    echo -e " [0] Cerrar la aplicación de Termux por completo ❌"
    echo -e "======================================================================\e[0m"
    echo ""
}

submenu_nativas() {
    while true; do # Activador de permisos automáticos en silencio
    for script in "$CARPETA_NATIVAS"/*.sh; do
        if [ -f "$script" ] && [ ! -x "$script" ]; then
            chmod +x "$script"
        fi
        done
        clear
        echo -e "${COLOR_INFO}=================================================="
        echo -e " 💎 SUBMENÚ: HERRAMIENTAS NATIVAS ZIPPLAY"| pv -qL 30
        echo -e "--------------------------------------------------"
        echo -e " Espacio reservado para las herramientas que creemos juntos."
        echo -e "==================================================${COLOR_NORMAL}"
        
        local nativas=($(ls "$CARPETA_NATIVAS"/*.sh 2>/dev/null))
        
        if [ ${#nativas[@]} -eq 0 ]; then
            echo -e "${COLOR_ALERTA}[!] Próximamente: Nuestro primer script de seguridad.${COLOR_NORMAL}"
            echo -e "Aquí se guardarán las herramientas nativas protegidas."
            echo -e "--------------------------------------------------"
            echo -e " [0] Volver al menú principal 🔙"
            echo -e "--------------------------------------------------"
            read -p "ZiP Code > " op_nat
            break
        else
            for i in "${!nativas[@]}"; do
                echo -e " [$((i+1))] $(basename "${nativas[$i]}")"
            done
            echo -e "--------------------------------------------------"
            echo -e " [0] Volver al menú principal 🔙"
            echo -e "--------------------------------------------------"
            read -p "ZiP Native > " op_nat
            
            if [ "$op_nat" = "0" ] || [ -z "$op_nat" ]; then break; fi
            
            if [[ "$op_nat" =~ ^[0-9]+$ ]] && [ "$op_nat" -gt 0 ] && [ "$op_nat" -le "${#nativas[@]}" ]; then
                submenu_lanzar_herramienta "${nativas[$((op_nat-1))]}"
            fi
        fi
    done
}

submenu_ciberseguridad() {
    while true; do
        clear
        echo -e "${COLOR_INFO}=================================================="
        echo -e " 🛡️  SUBMENÚ: AUDITORÍA Y CIBERSEGURIDAD" | pv -qL 30
        echo -e "--------------------------------------------------"
        echo -e " [Paquetes se auto-instalarán si faltan]"
        echo -e "==================================================${COLOR_NORMAL}"
        echo -e " [1] Nmap (Mapeo y escaneo de puertos de red) 🌐"
        echo -e " [2] TShark (Captura de tráfico - Requiere ROOT) 🦈"
        echo -e " [3] Nikto (Escaneo de vulnerabilidades web) 🕸️"
        echo -e " [4] Sqlmap (Auditoría de inyección SQL) 🛢️"
        echo -e " [5] Whois (Consulta de datos de dominios) 🔍"
        echo -e "--------------------------------------------------"
        echo -e " [0] Volver al menú principal 🔙"
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP Code > " op_sec

        case "$op_sec" in
            1)
                check_install_pkg nmap nmap || continue
                read -p "Introduce la IP o dominio a escanear: " ip_nmap
                if [ -n "$ip_nmap" ]; then nmap -sV "$ip_nmap"; pausar_y_limpiar; fi ;;
            2)
                check_install_pkg tshark tshark || continue
                tshark -V 2>/dev/null || echo -e "${COLOR_ERROR}Error: TShark requiere acceso root verificado en tu móvil.${COLOR_NORMAL}"
                pausar_y_limpiar ;;
            3)
                check_install_pkg nikto nikto || continue
                read -p "Introduce la URL a auditar con Nikto: " url_nikto
                if [ -n "$url_nikto" ]; then nikto -h "$url_nikto"; pausar_y_limpiar; fi ;;
            4)
                check_install_pkg sqlmap sqlmap || continue
                read -p "Introduce la URL vulnerable para Sqlmap: " url_sql
                if [ -n "$url_sql" ]; then sqlmap -u "$url_sql" --batch; pausar_y_limpiar; fi ;;
            5)
                check_install_pkg whois whois || continue
                read -p "Introduce el dominio para WHOIS: " dom_whois
                if [ -n "$dom_whois" ]; then whois "$dom_whois"; pausar_y_limpiar; fi ;;
            0) break ;;
            *) echo -e "${COLOR_ERROR}Opción inválida.${COLOR_NORMAL}"; sleep 1 ;;
        esac
    done
}

submenu_enciclopedia() {
    while true; do
        clear
        echo -e "${COLOR_INFO}=================================================="
        echo -e " 📚 SUBMENÚ: ENCYCLOPEDIA LINUX & TERMUX" | pv -qL 30
        echo -e "--------------------------------------------------"
        echo -e " Selecciona una categoría para estudiar los comandos:"
        echo -e "==================================================${COLOR_NORMAL}"
        echo -e " [1] Navegación y Carpetas (Moverse, crear, ver) 📂"
        echo -e " [2] Gestión de Archivos (Copiar, renombrar, borrar) 📄"
        echo -e " [3] Paquetes de Termux (Instalar y buscar herramientas) 📦"
        echo -e " [4] Superpoderes de Bash (Permisos y flujos) 🚀"
        echo -e "--------------------------------------------------"
        echo -e " [0] Volver al menú principal 🔙"
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
                echo -e "${COLOR_ALERTA}chmod +x <script.sh>${COLOR_NORMAL} -> Otorga 'permisos de ejecución' a un archivo para volverlo ejecutable."
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

submenu_lanzar_herramienta() {
    local carpeta_herr=$1
    clear
    echo -e "${COLOR_INFO}=================================================="
    echo -e " 🚀 LANZADOR DE HERRAMIENTAS DESCARGADAS"| pv -qL 30
    echo -e "==================================================${COLOR_NORMAL}"
    
    # 1. Entramos a la carpeta de la herramienta
    cd "$HOME/$carpeta_herr" || cd "$carpeta_herr" 2>/dev/null || { echo -e "${COLOR_ERROR}No se pudo entrar en la carpeta.${COLOR_NORMAL}"; return; }

    # 2. Buscamos archivos ejecutables locales de forma limpia (.)
    local ejecutables=($(find . -maxdepth 1 -type f -not -path '*/.*' -not -iname "readme*" -not -iname "license*" -not -iname "*.txt"))

    if [ ${#ejecutables[@]} -eq 0 ] || [ -z "${ejecutables[0]}" ]; then
        echo -e "${COLOR_ALERTA}[!] No se encontraron scripts ejecutables aquí dentro.${COLOR_NORMAL}"
        echo -e "Contenido real de la carpeta:"
        ls -F --color=always
        pausar_y_limpiar
    else
        for i in "${!ejecutables[@]}"; do
            exec_name=$(echo "${ejecutables[$i]}" | sed 's|^./||')
            echo -e " [$((i+1))] $exec_name"
        done
        echo -e "--------------------------------------------------"
        echo -e "  [0] para Cancelar y volver al menú 🔙"
        echo -e "--------------------------------------------------"
        echo ""
        read -p "ZiP tools> " op_exec

        if [[ "$op_exec" =~ ^[0-9]+$ ]] && [ "$op_exec" -gt 0 ] && [ "$op_exec" -le "${#ejecutables[@]}" ]; then
            script_elegido=$(echo "${ejecutables[$((op_exec-1))]}" | sed 's|^./||')
            clear
            
            chmod +x "$script_elegido" 2>/dev/null
            
            if [[ "$script_elegido" == *.py ]]; then
                check_install_pkg python python
                python "$script_elegido"
            elif [[ "$script_elegido" == *.sh ]]; then
                bash "$script_elegido"
            else
                ./"$script_elegido" || bash "$script_elegido"
            fi
            pausar_y_limpiar
        fi
    fi
    # 3. ¡SIEMPRE VOLVER A LA RAÍZ AL TERMINAR!
    cd "$HOME"
}

# ==============================================================================
# BUCLE PRINCIPAL DEL SISTEMA
# ==============================================================================
export PS1="\e[1;36mZiP Code > \e[0m"

preparar_entorno
SKIP_BANNER=false

while true; do
    if [ "$SKIP_BANNER" = true ]; then
        SKIP_BANNER=false
    else
        dibujar_banner
    fi
    
    read -p "ZiP Code > " opcion_principal

    case "$opcion_principal" in
        1)
            echo -e "${COLOR_INFO}[*] Sincronizando y actualizando repositorios de Termux...${COLOR_NORMAL}"
            pkg update && pkg upgrade -y
            pausar_y_limpiar ;;
        2)
            submenu_nativas ;;
        3)
            clear
            echo -e "${COLOR_INFO}=================================================="
            echo -e " 📂 SUBMENÚ: MIS HERRAMIENTAS INSTALADAS"| pv -qL 30
            echo -e "--------------------------------------------------"
            echo -e " Selecciona una carpeta de herramienta"
            echo -e "==================================================${COLOR_NORMAL}"
        
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
                echo -e "  [0] para Volver al menú principal 🔙"
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
            submenu_ciberseguridad ;;
        5)
            submenu_enciclopedia ;;
        6)
            help
            pausar_y_limpiar ;;
        7)
            nano "$HOME/zip-cyber-menu/cyber_menu.sh" # Superpoder: Edita este mismo script donde sea que esté guardado
            
            echo -e "${COLOR_EXITO}¡Menú modificado! Vuelve a cargarlo ejecutando 'menu'.${COLOR_NORMAL}"
            sleep 2 ;;
        8)
            pkg list-all | column
            pausar_y_limpiar ;;
        9)
            clear
            echo -e "${COLOR_ERROR}=================================================="
            echo -e " 🗑️  SUBMENÚ: ELIMINAR HERRAMIENTAS DESCARGADAS"| pv -qL 30
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
                echo -e "  [0] para Cancelar y volver 🔙"
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
  
        [kK]) # SALIDA NATIVA: Regresa al usuario al Termux original
            clear
            echo -e "${COLOR_ERROR}☣️  ALERTA MÁXIMA CRÍTICA: DETECTADO ACCESO AL KERNEL LIBRE  ☣️"| pv -qL 25
            echo -e "======================================================================"
            echo -e "¡CUIDADO! Estás a punto de perforar el entorno seguro de ZiPPLAY."
            echo -e "Si no tienes conocimientos avanzados de Linux o Termux, puedes"
            echo -e "borrar tus archivos del sistema o dañar la aplicación por completo."
            echo -e "----------------------------------------------------------------------"
            echo -e "¿Realmente posees el conocimiento para asumir el riesgo? (s/n)"
            echo -e "======================================================================${COLOR_NORMAL}"
            read -p "ZiP Security > " confirmar_riesgo
            
            if [[ "$confirmar_riesgo" =~ ^[sS]$ ]]; then
                while true; do
                    clear
                    # Se muestra la pantalla de bienvenida original de Termux
                    echo -e "Welcome to Termux!"
                    echo -e "Wiki:            https://termux.dev"
                    echo -e "Community forum: https://termux.dev"
                    echo -e "--------------------------------------------------"
                    echo -e "${COLOR_ALERTA} 💡 TIP: Escribe '${COLOR_EXITO}menu${COLOR_ALERTA}' para reactivar tu entorno seguro${COLOR_NORMAL} O '${COLOR_EXITO}exit${COLOR_ALERTA}' para salir de la proteccion${COLOR_NORMAL}"| pv -qL 35
                    echo -e "--------------------------------------------------"
                    
                    # Línea de comandos simulada nativa (A prueba de tontos y libre de alias externos)
                    read -p "☣️ ZCODE > " cmd_kernel
                    
                    if [ "$cmd_kernel" = "menu" ]; then
                        break
                    elif [ "$cmd_kernel" = "exit" ]; then
                        exit 0
                    elif [ ! -z "$cmd_kernel" ]; then
                        eval "$cmd_kernel"
                        pausar_y_limpiar
                    fi
                done
            else
                echo -e "${COLOR_EXITO}[+] Sabia decisión. Regresando al entorno seguro estilo Windows...${COLOR_NORMAL}"
                sleep 2
            fi
            ;;

        0|exit|quit)
            # CIERRE TOTAL: Destrucción elegante del proceso de Termux
            clear
            echo -e "\n\n\n\n\n\n\n\n"
            echo -e "     ${COLOR_INFO}==================================================${COLOR_NORMAL}"
            echo -e "            🦊 ¡Gracias por usar ZiP-Cyber-menu! 🦊"
            echo -e "               Cerrando la aplicación... 👋"
            echo -e "     ${COLOR_INFO}==================================================${COLOR_NORMAL}"
            echo -e "\n\n\n\n\n\n\n"
            sleep 1.4
            kill -9 $PPID
            break ;;
        clear)
            clear
            SKIP_BANNER=false
            ;;
        *)
            if [ -n "$opcion_principal" ]; then
                echo -e "${COLOR_INFO}[*] Ejecutando comando...${COLOR_NORMAL}\n"
                eval "$opcion_principal"
                
                while read -t 0.1 linea_siguiente; do
                    if [ -n "$linea_siguiente" ]; then
                        eval "$linea_siguiente"
                    fi
                done
                
                if read -t 0; then
                    SKIP_BANNER=true
                else
                    pausar_y_limpiar
                fi
            fi
            ;;
    esac
done

## Descripción

El proyecto utiliza Dancer2, un framework ligero para construir aplicaciones web en Perl. Permite cargar, visualizar, editar y guardar archivos planos. Los archivos pueden ser guardados en formato txt o csv.

## Requisitos

- Perl (se recomienda ultima versión)
- Dancer2 (se recomienda ultima versión)

## Instalación

1. Clonar este repositorio:
 
    git clone https://github.com/SPEREZB/Archivos_planos
 
2. Instalar Strawberry Perl [perl](https://strawberryperl.com/)

3. En caso de ser necesario crear variables de entorno y reiniciar el sistema

4. Abrir el CMD y escribir los siguientes comandos

    cpan App::cpanminus  

    cpanm Dancer2

    Dentro de la ruta donde se clono el repositorio: cpanm --installdeps .  
    
    set LANG=C  
        
## Uso

1. Iniciar la aplicación:
 
    perl app.pl 

2. Abrir el navegador y visitar [http://localhost:3000](http://localhost:3000).
 
## Funcionalidades

- **Cargar Archivos:** Selecciona un archivo de texto para cargar y visualizar su contenido.
- **Guardar Archivos:** Guarda el contenido modificado en un nuevo archivo.

## Estructura del Proyecto

- `app.pl`: Archivo principal de la aplicación.
- `views/`: Contiene las plantillas HTML/TT.
- `public/`: Carpeta para archivos estáticos (CSS, JS, etc.).
- `t/`: Directorio de pruebas (tests).
- `environments/`: Configuraciones de entorno.
- `bin/`: Scripts y utilidades ejecutables.
 
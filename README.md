# dinaIP para Linux (shell)

## dinaIP: haz que tu dominio resuelva en una IP dinámica

**dinaIP** es una aplicación que se encarga de monitorizar la IP del equipo en el que se está ejecutando y actualizar la información de las zonas según vaya cambiando la misma. Así, permite que todas aquellas zonas que están apuntando a dicho equipo estén siempre actualizadas con los cambios que se van dando.

**dinaIP** mantiene estable el punto de entrada a tu host para acceder a él de forma remota tecleando el nombre de tu dominio. Es muy fácil de usar e incluso te permite la gestión completa de las zonas DNS de tu dominio. Por ejemplo: puedes asignarle tu IP a la zona "micasa", de manera que si tecleas en un navegador "micasa.example.net" (o por SSH, VNC...) podrás acceder a tu PC.

### Requisitos para la instalación

#### Para OpenWrt:
Para un correcto funcionamiento en OpenWrt es necesario disponer de:
 - Perl
 - SSL
 - curl (comando, necesario solamente si no se pueden instalar los modulos Crypt::SSLeay de Perl, por defecto no aparecen en OpenWrt)

 Para instalar estas dependencias se deben ejecutar los siguientes comandos:

  - Actualizar lista de paquetes con
  ```bash
  opkg update
  ```

  - Instalar la paquetería de perl-base, curl y SSL:
  ```bash
  opkg install perlbase-base perlbase-essential perlbase-cwd perlbase-b perlbase-xsloader perlbase-bytes perlbase-posix perlbase-autoloader perlbase-fcntl perlbase-tie perlbase-io perlbase-symbol perlbase-selectsaver perlbase-data perlbase-mime perlbase-time perlbase-config perlbase-integer perlbase-getopt perlbase-socket perlbase-dynaloader perlbase-errno perl-www perl-uri perl-html-tagset perl-html-parser perl-www-curl libopenssl openssl-util curl
  ```


### HOWTO:
Con el parametro -h se ejecuta la ayuda online:

Uso: dinaIP [OPCIONES] ...

- -u	ID en dinahosting
- -p	Clave de tu perfil de dinahosting
- -i 	Arranca el demonio de dinaIP con la configuracion almacenada
- -a	Agrega una zona a monitorizar. Sintaxis: dominio:zona1,zona2...
- -l	Muestra una lista de los dominios pertenecientes a esta cuenta
- -b	Elimina una zona de la monitorizacion. Sintaxis: dominio:zona_a_eliminar
- -d	Detiene el demonio de dinaIP
- -h	Despliega esta ayuda
- -s	Muestra el status del demonio de dinaIP.

### Uso de la imagen de Docker

La imagen de Docker crea un fichero de configuración `dinaip.conf` con las 
zonas a monitorizar. Puedes añadir nuevas zonas en él también usando variables.

Estas son las variables de entorno que puedes usar:

- `USUARIO`: usuario de Dinahosting
- `PASSWORD`: contraseña del usuario de Dinahosting
- `CUENTA`: cuenta de Dinahosting. Creo que siempre es lo mismo que el usuario
pero lo separé porque pensé que podía no serlo. Otro día las uno en la misma
varible, `si eso`. 
- `DOMINIO`: Dominio a monitorizar
- `ZONAS`: zonas a actualizar, es una cadena de texto con las zonas separadas
únicamente por comas (no añadas una coma al final).
- `COMPROBAR_CADA`: número entero. Es 10 por defecto, pero creo que es
irrelevante en el estado actual porque la imagen muere antes.

En el estado actual, la imagen pasa un tiempo inútil durmiendo porque la
actualización no sucede lo bastante rápido para cerrar tras iniciar el
proceso. Yo la uso como un cronjob cada 10 minutos en Kubernetes. 

#### Clonar el repositorio

Para modificar esta imagen y usar las acciones de github para subirla a tu 
repositorio, puedes clonar este proyecto y cambiar las variables para que
apunten a tu cuenta.  
Añade un usuario y un
[token de acceso](https://docs.docker.com/docker-hub/access-tokens/)
a tus variables secretas de Github con los nombres `DOCKERHUB_USERNAME` y 
`DOCKERHUB_TOKEN` 

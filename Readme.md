# Script de Configuración e Instalación de Tomcat y Maven

Este script en Bash automatiza la instalación, configuración y despliegue de aplicaciones en un entorno con Apache Tomcat y Maven. Incluye pasos para configurar usuarios, roles y proyectos listos para desplegar.

## Requisitos previos

Configuración de Vagrant

![Vagrant File](./fotos/vagrantFile.png)

## Descripción del Script

### 1. Instalación de dependencias
- Actualiza los repositorios e instala:
  - **OpenJDK 11**.
  - **Apache Tomcat 9** y sus herramientas administrativas.
  - **Maven** para la gestión de proyectos Java.

### 2. Configuración de Tomcat
- Crea un grupo y un usuario específicos para Tomcat.
- Configura el usuario administrador en `tomcat-users.xml` con roles como `admin` y `manager`.
- Permite el acceso remoto a los paneles administrativos mediante la configuración del archivo `context.xml`.
![Comando 1](comando1.png)
![Foto 1](./fotos/tomcat2.png)

![Comando 2](comando2.png)
![Comando 3](comando3.png)

### 3. Administrador web
![Foto](./fotos/tomcat5.png)

![Foto](./fotos/tomcat6.png)

### 4. Despliegue con Tomcat

- Nos identificamos
![Foto 2](./fotos/tomcat4.png)

![Foto 3](./fotos/tomcat3.png)

- Seleccionamos el archivo que vamos a subir
![Foto 4](./fotos/tomcat7.png)

-Pulsamos sobre la url 
![Foto 5](./fotos/tomcat8.png)

![Foto 6](./fotos/tomcat9.png)



### 5. Configuración de Maven
- Añade un servidor llamado `Tomcat` en el archivo `settings.xml` de Maven con credenciales para despliegue automático.
![Comando 4](./fotos/comando4.png)

### 6. Creación de un proyecto con Maven
- Genera un proyecto web básico usando el arquetipo `maven-archetype-webapp`.
- Configura el plugin de Tomcat Maven para automatizar el despliegue del proyecto.

![Comando 5](./fotos/comando5.png)
![Foto 7](./fotos/tomcat1.png)


### 7. Clonación y despliegue de ejemplo
- Clona el repositorio [rock-paper-scissors](https://github.com/cameronmcnz/rock-paper-scissors).
- Modifica el `pom.xml` para configurar el despliegue en Tomcat.
- Despliega la aplicación en Tomcat con Maven.
![Comando 6](./fotos/comando6.png)
![Foto 8](./fotos/tomcat10.png)




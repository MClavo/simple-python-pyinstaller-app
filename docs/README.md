# Guía de instalación

## 1. Crear la imagen de BlueOcean con Dockerfile
```
docker build -t myjenkins-blueocean . 
```

## 2. Inicializar terraform 
```
terraform init 
```

## 3. Crear un plan para terraform
```
terraform plan 
```

## 4. Desplegar los contenedores con terraform
```
terraform apply 
```

## 5. Copiar la contraseña para desbloquear Jenkins
1. Acceder a los logs del contenedor
```
docker logs jenkins-blueocean
```
2. Obtener la contraseña

## 6. Acceder a Jenkins en http://localhost:8080

## 7. Introducir la contraseña del paso 2

## 8. Instalar los plugins deseados

## 9. Introducir los datos de usuario

## 10. Arreglar problemas con la instalación de los plugins
1. Administrar Jenkins
2. Plugins
3. Download progress
4. Activar la opción: **Reiniciar Jenkins cuando termine la instalación y no queden trabajos en ejecución**

## 11. Crear Pipeline
1. Seleccionar Nueva Tarea
2. Introducir un nombre
3. Seleccionar la opción Pipeline y aceptar
4. Seleccionar en Definition: **Pipelane script from SCM**
5. Seleccionar en SCM: **Git**
6. Introducir la URL del repositorio, en este caso:**https://github.com/MClavo/simple-python-pyinstaller-app**
7. Seleccionar Guardar

## 12. Ejecutar el Pipeline
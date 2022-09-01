# Práctica GCP de Roberto Pérez

## Índice:
- [Primera parte](#primera-parte): *IAM, Facturación, gestión de proyecto y diseño de arquitectura.*
- [Segunda parte](#segunda-parte): *Almacenamiento y bases de datos.*
- [Tercera parte](#tercera-parte): *Compute Engine, Imágenes y Grupos de Instancias.*
- [Cuarta parte](#cuarta-parte): *App Engine Estándar y Cloud SDK.*
- [Bonus](#bonus): *Terraform en GCP.*

***

## Primera parte
1. Crear un proyecto con vuestras cuentas personales.
2. Dar acceso completo al proyecto al profesor para su revisión (javioreto@gmail.com).

![imagen](https://user-images.githubusercontent.com/2046110/187798959-1a9b6328-2ad3-4e72-a59c-7a0d2eb4c8a4.png)

3. Crear varios avisos de facturación según distintos porcentajes de gasto (% a vuestraelección).

![imagen](https://user-images.githubusercontent.com/2046110/187799395-4f120f29-735b-4f71-b59b-b95ccdd51656.png)

4. Mediante Draw.io o una solución equivalente, dibujar la arquitectura final que tendría vuestro proyecto una vez ejecutada la segunda, tercera y cuarta parte de esta práctica. Se pide una única arquitectura unificada con las relaciones entre los servicios, no tres arquitecturas por separado.
![practica-gcp-infraestructura](https://user-images.githubusercontent.com/2046110/187799768-dd0bbd6e-a043-4add-bfd8-75444271102c.jpg)


5. El entregable de este último punto podrá ser una imagen en jpg o png, una slide de powerpoint o un archivo editable de draw.io.

La imagen anterior está disponible también en este repo con el nombre `practica-gcp-infraestructura.jpg`


## Segunda parte
1. Crear una base de datos MySQL mediante CloudSQL.
![imagen](https://user-images.githubusercontent.com/2046110/187800827-195f52f4-37de-4e8d-945f-d201c8d969cc.png)

2. Configurar las copias de seguridad automáticas para que se lancen por el medio día.
![imagen](https://user-images.githubusercontent.com/2046110/187801022-0156b673-eff0-4940-b172-8e4f6eba0999.png)

3. Crear un nuevo usuario llamado “alumno” y contraseña “googlecloud”.
![imagen](https://user-images.githubusercontent.com/2046110/187801096-a82240f0-46af-42c3-9f44-adfc85f0fdf8.png)

4. Se deben crear dos bases de datos llamadas “google” y “cloud”.
![imagen](https://user-images.githubusercontent.com/2046110/187801196-47d84f5c-34cc-4516-b0b5-97da049ccf46.png)

5. Procede a exportar exclusivamente estas dos bases de datos mediante la función exportar, en formato SQL. Para lo cual deberás crear un segmento de Cloud Storage.
6. Una vez finalizada la exportación, realiza una importación de dicho fichero.

![imagen](https://user-images.githubusercontent.com/2046110/187801309-3d32847b-add0-4f83-8bfa-08c238391bd7.png)

7. Se comprobarán los logs de auditación para ver si se ha realizado la importación satisfactoriamente.
8. Por último, (des)escala la máquina de base de datos a la configuración de CPU y RAMmás baja.
![imagen](https://user-images.githubusercontent.com/2046110/187801760-cba705a3-bce3-4c16-8fbc-e76b367cd964.png)

## Tercera parte
1. Crear una imágen personalizada con un servidor web Apache instalado.
2. Usar esa imagen para crear una plantilla de instancia con la configuración mínima deCPU y RAM.

![imagen](https://user-images.githubusercontent.com/2046110/187801878-2033961c-6a1b-4e59-994d-19c2226d064b.png)

3. Crear un grupo de instancias de autoescalado basado en consumos de CPU muy bajo para forzar un escalado rápido, configurando el tiempo de enfriamiento oportuno para nuestra imagen y que cuente el grupo con un mínimo de 1 instancia y un máximo de 4.

> En esta captura tengo la duda de que aparecen 7 instancias en la parte izquierda aunque el límite es de 4 para el autoescalado como se muestra a la derecha
![imagen](https://user-images.githubusercontent.com/2046110/187802184-ecd3616a-4485-43e6-a2ae-120b3f9b422c.png)

Para asegurar el correcto funcionamiento del script del siguiente punto y que siempre se acceda correctamente a las instancias del grupo he configurado un balanceador de carga de modo que siempre se acceda a través de la misma IP.
![imagen](https://user-images.githubusercontent.com/2046110/187803275-d9d4467a-1e60-4af0-9304-0a0197a0408c.png)


4. Crear una máquina virtual independiente en Compute Engine, que en su directorio localtenga un sencillo script para comprobar si funciona el autoescalado (atacando a la ip propia del grupo de instancias).

![imagen](https://user-images.githubusercontent.com/2046110/187802633-a6c305ec-c002-4055-bde8-87d3b3679ab6.png)
![imagen](https://user-images.githubusercontent.com/2046110/187802838-b148ef69-fbc0-4791-80dc-66332f36ab39.png)


## Cuarta parte

1. Haz un deploy de la siguiente aplicación en GAE Estándar:○https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/appengine/standard/cloudsql

2. Configura el archivo app.yaml con la configuración generada en la SEGUNDA PARTE.
![imagen](https://user-images.githubusercontent.com/2046110/187804096-f7fb1e4a-5275-4081-8837-f37a67e1a7fa.png)

3. Una vez subida la app, comprueba el correcto funcionamiento accediendo a al url de la aplicación.

URL de acceso a la aplicación:
https://practica-gcp-roberto.ew.r.appspot.com/

4. Vuelve a hacer el deploy de la aplicación, pero esta vez no sobre el servicio “default”,sino sobre un servicio nuevo llamado “practica” y personaliza el nombre de la versión llamándola “version-1-0-0”.○Puedes ver los parámetros que puede tener el app.yaml en la documentación:https://cloud.google.com/appengine/docs/standard/python/config/appref
5. Repite el paso anterior, pero esta vez llamando a la version “version-2-0-0”.
6. Una vez subida la segunda versión, cambia la distribución del tráfico de forma aleatoria al 50% entre las dos versiones.
![imagen](https://user-images.githubusercontent.com/2046110/187804199-e82518ae-763d-414f-acfa-91a89e0a63b9.png)


## Bonus

1. Crear una configuración de Terraform en un único fichero main.tf (que será el entregable de este apartado).
2. Añadir a la configuración las instrucciones para que utilice la librería de Google Cloud.
3. Crear una cuenta de servicio y descargar el fichero JSON con las credenciales.
4. Añadir a la configuración el proyecto, región, zona y credenciales.
5. Crear los siguientes recursos con configuración libre (nombres, tipos de máquinas,so,etc.):
  - Nueva red virtual.
  - Bucket de almacenamiento en Cloud Storage.
  - Aprovisionar una máquina virtual enlazada con la red virtual creada anteriormente.
6. Ejecutar Terraform para crear los recursos.
7. Eliminar los recursos con Terraform.

El archivo `main.tf` está subido a este repositorio en el directorio `terraform`

# dosmerk

A new Flutter project.

#dev
1. copiar el .env.template y renombrarlo a .env
2. cambiar las variables de entorno(The movieDB)
3. cambios en la entidad, hay que ejecutar el comando '''flutter pub run build_runner build'''

#prod
para cambiar el nombre de la aplicaciion'recordar que se uso change_app_package_name en el pubspect dev asist':
```
flutter pub run change_app_package_name:main com.gustavogarcia.name
```


para cambiar el icono de la app
```
flutter pub run flutter_launcher_icons
```
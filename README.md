### Контейнер для развертки Тестового задания Агентства «Автодрайв»

### смысл:
поднимет приложение, nginx, бд в контейнерах, с конфигурацией в которой точно всё работает
например я использовал constraints, а они поддерживаются только innoDb, поэтому взял MariaDb
в папке api лежит data.xml, который тоже скопируется в контейнер

### команды:
### если совсем лень:
запустить команду up.sh
она запечёт образы, поднимет их, поднимет миграции
autodrivedocker_api_1 - приложение 
autodrivedocker_web_1 - nginx порт 8001
autodrivedocker_db_1  - база порт 6033

бывает, что база не успевает прогрузиться, поэтому нужно запустить
sudo docker exec -ti autodrivedocker_api_1 php artisan migrate

можно сразу запустить команду импорта, она возьмёт в качестве файла тот, что скопировался в контейнер
sudo docker exec -ti autodrivedocker_api_1 php artisan car:import

#### поднять контейнер 
sudo docker-compose -f docker-compose.yml -f build.yml up -d

#### поднять контейнер с локальным репозиторием 
склонировать репозиторий
https://github.com/steel0rat/autodrive-gazin
прописать путь в .env

sudo docker-compose -f docker-compose.yml -f build.yml -f dev.yml up -d --build

## Реализация тестового задания описана <a href="https://github.com/steel0rat/autodrive-gazin/">тут</a>

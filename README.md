### Контейнер для развертки Тестового задания Агентства «Автодрайв»

### команды:
#### поднять контейнер 
sudo docker-compose -f docker-compose.yml up -d

#### поднять контейнер и запечь образ контейнера (при первом запуске)
sudo docker-compose -f docker-compose.yml -f build.yml up -d --build

#### поднять контейнер с локальным репозиторием 
склонировать репозиторий
https://github.com/steel0rat/autodrive-gazin
в путь /var/www/projects/autodrive-gazin

sudo docker-compose -f docker-compose.yml -f build.yml -f dev.yml up -d --build
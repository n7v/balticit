## Разворачивание проекта

### Файлы

`config/deploy.rb`
* ставим в `application` название приложения
* ставим в `repository` ссылку на репозиторий

`config/deploy/production`
* ставим production-сервер для ролей

`config/deploy/staging`
* ставим stage-сервер для ролей

### Установка структуры директорий на сервере
```bash
cap production deploy:setup
cap staging deploy:setup
```

### Настройка базы данных на сервере
```bash
cap production db:mysql:setup
cap staging db:mysql:setup
```
(для выполнения команд потребуется пароль от рута MySQL)
* создастся `database.yml` в приватной директории на сервере со случайным паролем
* создастся новый пользователь для проекта (%application%_%stage%)
* создастся начальная база для проекта
* новому пользователю даются права на управление этой базой

### Настройка unicorn и nginx
Генерация конфигов для production:
```bash
rails g nginx:config production --server-name=YOUR_PRODUCTION_DOMAIN
rails g unicorn:config production
```
и для staging:
```bash
rails g nginx:config staging --server-name=YOUR_STAGING_DOMAIN
rails g unicorn:config staging
```
созданные конфиги отправить в git-репозиторий

### Деплой
```bash
cap production deploy
cap staging deploy
```

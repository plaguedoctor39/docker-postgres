#!/bin/bash

# Запустить Docker Compose
echo "Запуск Docker Compose..."
docker-compose up -d

# Подождать несколько секунд, чтобы контейнеры успели запуститься
echo "Ожидание запуска контейнеров..."
sleep 10

# Проверить состояние контейнеров
echo "Проверка состояния контейнеров..."
docker ps -a

# Получить токен из логов контейнера Jupyter
echo "Получение токена..."
container_id=$(docker ps -q --filter "ancestor=docker-postgre-jupyter")
if [ -z "$container_id" ]; then
  echo "Контейнер Jupyter не запущен. Проверьте логи."
  exit 1
fi

token=$(docker logs "$container_id" 2>&1 | grep -o 'token=[a-zA-Z0-9]\+' | head -1 | cut -d '=' -f 2)
if [ -z "$token" ]; then
  echo "Не удалось получить токен. Проверьте логи контейнера."
  exit 1
fi

# Открыть Jupyter Notebook в браузере
url="http://localhost:8888/?token=$token"
echo "Открытие браузера с URL: $url"

if command -v xdg-open > /dev/null; then
  xdg-open "$url"
elif command -v open > /dev/null; then
  open "$url"
elif command -v start > /dev/null; then
  start "$url"
else
  echo "Не удалось открыть браузер. Откройте URL вручную: $url"
fi

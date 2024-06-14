# Запуск Jupyter Notebook и PostgreSQL с помощью Docker

Этот проект настраивает окружение с Jupyter Notebook и PostgreSQL с использованием Docker и Docker Compose.

## Предварительные требования

- Docker
- Docker Compose

## Запуск проекта

Следуйте этим шагам, чтобы запустить проект у себя локально.

### 1. Клонирование репозитория

Сначала клонируйте репозиторий к себе на локальный компьютер:

```sh
git clone https://github.com/plaguedoctor39/docker-postgres.git
cd docker-postgres
```

### 2. Запуск Docker Compose

Запустите Docker Compose, чтобы собрать образы и запустить контейнеры:

```sh
docker-compose build
```

### 3. Запуск скрипта для автоматического открытия Jupyter Notebook

Сделайте файл исполняемым:
```sh
chmod +x start.sh
```

Запустите скрипт для автоматического открытия Jupyter Notebook:

```sh
./start.sh
```

### 4. Использование PostgreSQL

Для подключения к базе данных PostgreSQL из Jupyter Notebook используйте следующий пример кода на Python:

```import psycopg2

# Подключение к базе данных PostgreSQL
conn = psycopg2.connect(
    dbname="mydatabase",
    user="user",
    password="password",
    host="postgres"  # Это имя сервиса, определенное в docker-compose.yml
)

# Создание объекта-курсора
cur = conn.cursor()

# Выполнение запроса
cur.execute("SELECT version();")
record = cur.fetchone()

# Вывод результата
print("Вы подключены к - ", record, "\n")

# Закрытие курсора и соединения
cur.close()
conn.close()
```
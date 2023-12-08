FROM golang:latest

WORKDIR /app

# Копируем исходный код в контейнер
COPY . .



# Устанавливаем зависимости
RUN go get -u github.com/gonum/matrix/mat64

# Собираем программу
RUN go build -o main .

# Запускаем программу
CMD ["./main"]

# Этап сборки
FROM golang:1.23-alpine AS builder

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

# Копируем зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем исходники
COPY . .

# Сборка
RUN go build -o tracker

# Финальный нулевой образ
FROM scratch

COPY --from=builder /app/tracker /tracker

ENTRYPOINT ["/tracker"]

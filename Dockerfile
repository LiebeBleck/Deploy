FROM golang:1.23-alpine AS builder

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app


COPY go.mod go.sum ./
RUN go mod download


COPY . .


RUN go build -o tracker


FROM scratch

COPY --from=builder /app/tracker /tracker

ENTRYPOINT ["/tracker"]

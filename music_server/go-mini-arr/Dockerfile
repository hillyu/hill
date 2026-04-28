# Build stage
FROM golang:1.26-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o mini-arr ./cmd/server/main.go

# Final stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates sqlite

WORKDIR /root/
COPY --from=builder /app/mini-arr .
COPY --from=builder /app/web ./web

# Default config path
ENV CONFIG_PATH=/config/config.json

EXPOSE 8080

CMD ["./mini-arr", "/config/config.json"]

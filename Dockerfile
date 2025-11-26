FROM golang:1.21 AS builder

WORKDIR /app

COPY main.go ./

RUN CGO_ENABLED=0 go build -o main main.go

FROM alpine:latest

EXPOSE 8080

COPY --from=builder /app/main /

ENTRYPOINT ["/main"]
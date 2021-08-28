FROM golang AS building
WORKDIR /app
ADD . /app
RUN go build -o meugo
ENTRYPOINT ./meugo

FROM alpine
WORKDIR /app
COPY --from=building /app/meugo /app

ENTRYPOINT ./meugo
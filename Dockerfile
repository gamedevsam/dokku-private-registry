FROM registry:latest

WORKDIR /app

COPY . /app

ENTRYPOINT [""]
CMD ["/app/run"]

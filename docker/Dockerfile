FROM google/dart:2.15.1

COPY . /app

COPY docker/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

WORKDIR /app/unpub

RUN dart pub get 

WORKDIR /app

EXPOSE 4000

ENTRYPOINT [ "/app/entrypoint.sh" ]

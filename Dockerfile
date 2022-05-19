FROM alpine/git:latest as git

ARG GIT_REPO=https://github.com/plentific/unpub

WORKDIR /tmp

RUN git clone $GIT_REPO /tmp
RUN ls -la


FROM google/dart:2.15.1

COPY --from=git /tmp /app

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

WORKDIR /app/unpub

RUN dart pub get 

WORKDIR /app

EXPOSE 4000

ENTRYPOINT [ "/app/entrypoint.sh" ]

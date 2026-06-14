FROM alpine:3.24.0

RUN apk update && apk upgrade --no-cache

COPY ./bin/php /bin/php

COPY ./bin/composer /bin/composer

COPY ./bin/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY app /app

WORKDIR /app

EXPOSE 2345

ENTRYPOINT ["/entrypoint.sh"]

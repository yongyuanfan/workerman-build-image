FROM alpine:3.24.0

RUN apk update && apk upgrade --no-cache

COPY ./php /bin/php

COPY ./composer /bin/composer

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY . /app

WORKDIR /app

EXPOSE 2345

ENTRYPOINT ["/entrypoint.sh"]
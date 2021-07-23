FROM python:3.7-alpine

WORKDIR /app

COPY requirements.txt requirements.txt
RUN apk add --update --no-cache mariadb-connector-c \
     && apk add --no-cache --virtual .build-deps mariadb-dev gcc musl-dev gcc build-base libffi-dev cargo \
     && pip install --upgrade pip \
     && pip install -r requirements.txt \
     && apk del .build-deps

RUN mkdir /var/run/discreetly

COPY . .

CMD ["sh", "-c", "SECRET_KEY=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1` gunicorn --worker-class sync --log-level DEBUG --reload -b 0.0.0.0:8000 --graceful-timeout 5 --workers 2 --access-logfile - 'dashboard.app:create_app()'"]

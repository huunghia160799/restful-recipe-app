FROM python:3.7-alpine
LABEL Huu-Nghia H. Nguyen

# prevent Python from misbehaving when using Docker
ENV PYTHONUNBUFFERED 1

# copy the requirements from the project to docker machine
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
# make /app default folder
WORKDIR /app
COPY ./app /app

# prevent any user from taking root priorities
RUN adduser -D user
USER user
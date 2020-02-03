FROM python:3.7-alpine
LABEL Huu-Nghia H. Nguyen

# prevent Python from misbehaving when using Docker
ENV PYTHONUNBUFFERED 1

# copy the requirements from the project to docker machine
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
# make /app default folder
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# prevent any user from taking root priorities
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web

# change current user to "user"
USER user
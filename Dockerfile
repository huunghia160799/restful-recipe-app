FROM python:3.7-alpine
MAINTAINER Huu-Nghia H. Nguyen

# prevent Python from misbehaving when using Docker
ENV PYTHONUNBUFFERED 1

# copy the requirements from the project to docker machine
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
# make /app default folder
WORKDIR /app
COPY ./app /app

# prevent any user from taking root priorities
RUN adduser -D user
USER user
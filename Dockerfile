FROM python:3.8

# Creating Application Source Code Directory
RUN mkdir -p /usr/src/app

# Setting Home Directory for containers
WORKDIR /usr/src/app

# Installing python dependencies
COPY requirements.txt /usr/src/app/
RUN pip3 install --upgrade setuptools
RUN pip3 install  -r requirements.txt

# Copying src code to Container
COPY . /usr/src/app

# Application Environment variables
#ENV APP_ENV development
ENV PORT 8080

# Exposing Ports
EXPOSE $PORT


# Running Python Application
ENTRYPOINT ["python3", "routes.py"]
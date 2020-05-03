# Dockerfile HAS NO extension & HAS TO start with a CAPITAL letter
# The reason it is called Dockerfile is because this is the standard convention
# that Docker uses to identify the docker file in the project


# image from which this project will inherit the Dockerfile since in 
# Docker we can build images in top of other images. This will make it 
# easier to add costumized bits (libraries, files) that the project needs
# 3.7-alpine is the tag name of the image
FROM python:3.7-alpine  

# SET python unbuffered environment variable
# PYTHONUNBUFFERED 1 tells python to run in unbuffered mode 
# (recommended when is running in Docker containers)
ENV PYTHONUNBUFFERED 1

# create a file (any file name or extension) for the lsit of requirements packages for the project
# ./requirements.txt is the adjacent to the Dockerfile source file 
# requirements.txt is the dest file IN THE DOCKER IMAGE
COPY ./requirements.txt /requirements.txt
# takes the requirements file and installs the packages to the docker image
RUN pip install -r /requirements.txt

# create a directory in the docker image where the source code of the app will be created
RUN mkdir /app
# the path to use a the working irectory in the image
# any application we run that uses Docker container will run starting from /app location unless we specify otherwise
WORKDIR /app 
# copy from the local machine the app folder to the app folder created in the Docker image
COPY ./app /app

# create a user that will run the app using Docker -D means create a new user called 'user'
# creating and user and using it on the docker image that will run the app using the root account
# will limit the access that an attacker would have to the Docker container

RUN adduser -D user
# switch the Docker to the user that was created
USER user


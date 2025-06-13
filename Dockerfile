FROM httpd:alpine
COPY . /usr/local/apache2/htdocs/

EXPOSE 80
# This Dockerfile uses the official httpd image based on Alpine Linux.
# It copies the current directory contents into the Apache document root.
# The container will listen on port 80.
# To build this Dockerfile, run:
# docker build -t convertisseur .
# To run the container, use:
# docker run -d -p 8080:80 convertisseur
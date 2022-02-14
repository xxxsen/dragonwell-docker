FROM ubuntu:20.04

ARG DOWNLOAD_URL=
RUN apt-get update && apt-get install curl -y 
RUN curl -v -L $DOWNLOAD_URL -o - | tar -zxf - && mv jdk-* jdk

ENV JAVA_HOME=/jdk
ENV PATH=/jdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CMD ["/jdk/bin/java", "--version"]

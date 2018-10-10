FROM factual/docker-base
MAINTAINER Maxime DEVALLAND <maxime@factual.com>



RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -y git zip ipmitool unzip wget openjdk-8-jdk openjdk-8-jdk-headless zip unzip ipmitool && rm -r /var/lib/apt/lists/*
RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac

RUN useradd -Ur -d /opt/collins collins
RUN for dir in /build /build/collins /var/log/collins /var/run/collins; do mkdir $dir; done
ENV APP_HOME /opt/collins
ENV LOG_HOME /var/log/collins
ENV ACTIVATOR_VERSION=1.3.7

RUN git clone https://github.com/tumblr/collins /build/collins

WORKDIR /build
# get Play, Collins, build, and deploy it to /opt/collins
#COPY collins/ /build/collins/
RUN echo "Fetching Play 2.3.9" && \
    wget -q http://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION-minimal.zip -O /build/activator.zip && \
    unzip -q ./activator.zip && \
    cd collins && \
    java -version 2>&1 && \
    PLAY_CMD=/build/activator-$ACTIVATOR_VERSION-minimal/activator FORCE_BUILD=true ./scripts/package.sh && \
    unzip -q /build/collins/target/collins.zip -d /opt/ && \
    cd / && rm -rf /build 

# Add in all the default configs we want in this build so collins can run.
# Override /opt/collins/conf with your own configs with -v
COPY database.conf.mo	        		       /opt/collins/conf/database.conf.mo

RUN mkdir -p /etc/service/collins/
COPY collins.sh /etc/service/collins/run

WORKDIR /opt/collins
EXPOSE 9000

FROM factual/docker-base-openjdk
MAINTAINER Maxime DEVALLAND <maxime@factual.com>

RUN apt-get update && apt-get install -y git zip unzip wget && rm -r /var/lib/apt/lists/*

RUN useradd -Ur -d /opt/collins collins
RUN for dir in /build /build/collins /var/log/collins /var/run/collins; do mkdir $dir; done
ENV APP_HOME /opt/collins
ENV LOG_HOME /var/log/collins

RUN git clone https://github.com/tumblr/collins /build/collins

WORKDIR /build
# get Play, Collins, build, and deploy it to /opt/collins
#COPY collins/ /build/collins/
RUN echo "Fetching Play 2.2.6" && \
    wget -q http://downloads.typesafe.com/play/2.2.6/play-2.2.6.zip -O /build/play-2.2.6.zip && \
    unzip -q ./play-2.2.6.zip && \
    cd collins && \
    java -version 2>&1 && \
    PLAY_CMD=/build/play-2.2.6/play ./scripts/package.sh && \
    unzip -q /build/collins/target/collins.zip -d /opt/ && \
    cd / && rm -rf /build 

# Add in all the default configs we want in this build so collins can run.
# Override /opt/collins/conf with your own configs with -v
RUN cp /build/collins/conf/docker/validations.conf     /opt/collins/conf/validations.conf
RUN cp /build/collins/conf/docker/profiles.yaml        /opt/collins/conf/profiles.yaml
RUN cp /build/collins/conf/docker/logger.xml           /opt/collins/conf/logger.xml
COPY database.conf.mo	        		       /opt/collins/conf/database.conf.mo

RUN mkdir -p /etc/service/collins/
COPY collins.sh /etc/service/collins/run

WORKDIR /opt/collins
EXPOSE 9000

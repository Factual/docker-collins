#!/bin/bash

#COLLINS_DB_LOGIN=${COLLINS_DB_LOGIN:-collins}
#COLLINS_DB_PASSWORD=${COLLINS_DB_PASSWORD:-collins}
#COLLINS_DB_URL=${COLLINS_DB_URL:-localhost}
#COLLINS_CONFIG_URL="http://resources.prod.factual.com/services/collins"
#
#/usr/bin/mo /opt/collins/conf/database.conf.mo > /opt/collins/conf/database.conf
#
#wget -q ${COLLINS_CONFIG_URL}/production.conf -O /opt/collins/conf/production.conf
#wget -q ${COLLINS_CONFIG_URL}/authentication.conf -O /opt/collins/conf/authentication.conf
#wget -q ${COLLINS_CONFIG_URL}/permissions.yaml -O /opt/collins/conf/permissions.yaml
#wget -q ${COLLINS_CONFIG_URL}/logger.xml -O /opt/collins/conf/logger.xml
#wget -q ${COLLINS_CONFIG_URL}/profiles.yaml -O /opt/collins/conf/profiles.yaml
#wget -q ${COLLINS_CONFIG_URL}/validations.conf -O /opt/collins/conf/validations.conf


APP_HOME=/opt/collins
LOG_HOME=/var/log/collins
cd $APP_HOME &&
/usr/bin/java -server \
      -Dconfig.file=$APP_HOME/conf/production.conf \
      -Dhttp.port=9000 \
      -Dlogger.file=$APP_HOME/conf/logger.xml \
      -Dnetworkaddress.cache.ttl=1 \
      -Dnetworkaddress.cache.negative.ttl=1 \
      -Dcom.sun.management.jmxremote \
      -Dcom.sun.management.jmxremote.port=3333 \
      -Dcom.sun.management.jmxremote.authenticate=false \
      -Dcom.sun.management.jmxremote.ssl=false \
      -XX:MaxPermSize=384m \
      -XX:+CMSClassUnloadingEnabled \
      -XX:+PrintGCDetails \
      -XX:+PrintGCTimeStamps \
      -XX:+PrintGCDateStamps \
      -XX:+PrintTenuringDistribution \
      -XX:+PrintHeapAtGC \
      -Xloggc:$LOG_HOME/gc.log \
      -XX:+UseGCLogFileRotation \
      -cp "$APP_HOME/lib/*" \
      play.core.server.NettyServer $APP_HOME

#!/bin/bash

# 
/usr/bin/mo /opt/collins/conf/database.conf.mo > /opt/collins/conf/database.conf


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

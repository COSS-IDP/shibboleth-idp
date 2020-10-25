#!/bin/sh

#set -x

export JAVA_HOME=/usr/lib/jvm/default-jvm \
export PATH=$PATH:$JAVA_HOME/bin

if [ -e "/opt/shibboleth-idp/ext-conf/idp-secrets.properties" ]; then
  export JETTY_BACKCHANNEL_SSL_KEYSTORE_PASSWORD=`gawk 'match($0,/^jetty.backchannel.sslContext.keyStorePassword=\s?(.*)\s?$/, a) {print a[1]}' /opt/shibboleth-idp/ext-conf/idp-secrets.properties`
  export JETTY_BROWSER_SSL_KEYSTORE_PASSWORD=`gawk 'match($0,/^jetty\.sslContext\.keyStorePassword=\s?(.*)\s?$/, a) {print a[1]}' /opt/shibboleth-idp/ext-conf/idp-secrets.properties`
fi

# export JETTY_ARGS="jetty.sslContext.keyStorePassword=58463 jetty.backchannel.sslContext.keyStorePassword=$JETTY_BACKCHANNEL_SSL_KEYSTORE_PASSWORD"

exec /opt/jetty-home/bin/jetty.sh run

FROM debian:buster-slim

RUN apt-get update && \
  apt-get install gnupg2 -y && \
  # install tini
  apt-get install tini -y && \
  # install seafile client
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61 && \
  echo deb http://deb.seadrive.org wheezy main | tee /etc/apt/sources.list.d/seafile.list && \
  apt-get install -y seafile-cli procps curl grep && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /seafile-client
WORKDIR /seafile-client

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
  seaf-cli init -d /seafile-client

ENTRYPOINT ["tini", "-vg", "--", "/entrypoint.sh"]

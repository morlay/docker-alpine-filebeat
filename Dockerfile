FROM alpine:3.4

ENV FILEBEAT_VERSION=5.1.1 \
    FILEBEAT_SHA1=6e629825010b816b627ac531ddbb50b960bbbcba

ADD https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz /tmp/filebeat.tar.gz

RUN cd /tmp \
  && echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - \
  && tar -xzvf filebeat.tar.gz \
  && cd filebeat* \
  && cp filebeat /usr/bin \
  && rm -rf /tmp/filebeat*

COPY ./docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
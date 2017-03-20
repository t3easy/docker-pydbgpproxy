FROM python:2-alpine

ENV RD_VERSION="10.2.1" RD_BUILD="89853"

RUN apk add --no-cache tar \
    && wget -O pythonremotedebugging.tar.gz http://downloads.activestate.com/Komodo/releases/$RD_VERSION/remotedebugging/Komodo-PythonRemoteDebugging-$RD_VERSION-$RD_BUILD-linux-x86_64.tar.gz \
    && mkdir -p /usr/local/pythonremotedebugging \
    && tar -xzC /usr/local/pythonremotedebugging --strip-components=1 -f pythonremotedebugging.tar.gz \
    && rm pythonremotedebugging.tar.gz \
    && ln -s /usr/local/pythonremotedebugging/pydbgpproxy /usr/local/bin/pydbgpproxy \
    && apk del tar

ENV PYTHONPATH /usr/local/pythonremotedebugging/pythonlib

EXPOSE 9000 9001

CMD ["pydbgpproxy", "-d", "0.0.0.0:9000", "-i", "0.0.0.0:9001"]

# INSTALL PYTHON IMAGE
FROM python:2.7-slim
MAINTAINER Surisetty, Naresh <naresh@naresh.co>

# INSTALL TOOLS
RUN apt-get update \
    # gcc required for cx_Oracle
    && apt-get -y install gcc \
    && apt-get -y install unzip \
    && apt-get -y install libaio-dev \
    && apt-get -y install postgresql-client \
    && apt-get -y install postgresql-client-common \
    && apt-get -y install python-psycopg \
    && mkdir -p /opt/data/api

ADD ./oracle-instantclient/ /opt/data
ADD ./install-instantclient.sh /opt/data
ADD ./requirements.txt /opt/data

WORKDIR /opt/data

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include

# INSTALL INSTANTCLIENT AND DEPENDENCIES
RUN ./install-instantclient.sh \
    && pip install -r requirements.txt

EXPOSE 5000

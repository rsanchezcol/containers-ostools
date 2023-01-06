FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y python python3-pip vim net-tools libaio1 wget unzip traceroute dnsutils iputils-ping tcpdump telnetd openssh-client curl wget nmap telnet strace default-jdk nodejs npm ftp netcat ethtool apache2-utils tcptrack vnstat darkstat
RUN pip3 install tcp-latency
RUN python3 -m pip install cx_Oracle --upgrade

# Installing Apache JMeter
ARG JMETER_VERSION="5.5"
RUN mkdir -p /opt/jmeter
WORKDIR /opt/jmeter
RUN wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip
RUN unzip apache-jmeter-${JMETER_VERSION}.zip
RUN rm -f apache-jmeter-${JMETER_VERSION}.zip

# Installing Oracle Client
WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip
RUN unzip instantclient-basiclite-linuxx64.zip
RUN rm -f instantclient-basiclite-linuxx64.zip
RUN cd /opt/oracle/instantclient* \
    && echo "#Oracle Variables" >> ~/.bashrc \
    && echo "export ORACLE_HOME=`pwd`" >> ~/.bashrc \
    && echo "export TNS_ADMIN=`pwd`" >> ~/.bashrc \
    && echo "export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH" >> ~/.bashrc
RUN echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig

WORKDIR /opt/
USER root


CMD ["/bin/bash"]

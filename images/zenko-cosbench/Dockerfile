FROM java:openjdk-8-jre

ARG COSBENCH_VERSION
ENV USER="zenko"
RUN useradd -ms /bin/bash zenko
ENV HOME_DIR="/home/${USER}"
ENV COSBENCH_DIR="${HOME_DIR}/cosbench"

#-------------------------------------
# Download and install Cosbench
#-------------------------------------
RUN apt-get update ; apt-get install -y curl crudini
RUN curl --retry 6 \
    -Ls "https://github.com/intel-cloud/cosbench/releases/download/v${COSBENCH_VERSION}/${COSBENCH_VERSION}.zip" > /tmp/cosbench.zip && \
    cd /tmp ; unzip -q /tmp/cosbench.zip && \
    mv "/tmp/${COSBENCH_VERSION}" ${COSBENCH_DIR} && \
    rm /tmp/cosbench.zip

WORKDIR  ${HOME_DIR}/cosbench

# COSBench controller port
# COSBench driver port
EXPOSE 19088 18088

COPY docker-entrypoint.sh /
COPY controller.conf ${COSBENCH_DIR}/conf
COPY driver.conf ${COSBENCH_DIR}/conf

#-------------------------------------
# DOCKER STARTUP
#-------------------------------------
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD java -Dcosbench.tomcat.config=conf/controller-tomcat-server.xml -server -cp main/* org.eclipse.equinox.launcher.Main -configuration controller.conf -console 19089

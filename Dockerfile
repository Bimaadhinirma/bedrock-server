FROM fedora:latest

ENV release=1.18.12.01
ENV DOCKER_TAG=${release}

LABEL version="${release}"
LABEL description="The MineCraft Bedrock Server"
LABEL maintainer="@IMetZach"

ENV NAME Bedrock-Server
ENV arc=bedrock-server-${release}.zip
ENV dlarc=https://minecraft.azureedge.net/bin-linux/${arc}

WORKDIR /opt/minecraft

RUN dnf -y upgrade && dnf -y install unzip telnet libnsl && dnf clean all && rm -rf /var/cache/dnf
RUN ["mkdir", "/opt/minecraft/worlds"]

ADD ${dlarc} ${arc}
RUN unzip -n ${arc}

ADD ./startup.sh /opt/minecraft/
RUN ["chmod", "+x", "/opt/minecraft/startup.sh"]
RUN ["chmod", "+x", "/opt/minecraft/bedrock_server"]

EXPOSE 7777
EXPOSE 7777

ENTRYPOINT ["/opt/minecraft/startup.sh", "/bin/bash"]

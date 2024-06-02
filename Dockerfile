# una imagen de un agente JNLP para Jenkins sin nada más instalado
FROM ubuntu:jammy

ENTRYPOINT ["java", "-jar", "/var/jenkins_home/agent.jar"]

RUN apt update && \
    apt install -y openssh-server openjdk-17-jre-headless git wget

# crear el usuario Jenkins con contraseña jenkins
RUN useradd -m -d /var/jenkins_home -s /bin/bash jenkins
RUN echo 'jenkins:jenkins' | chpasswd

WORKDIR /var/jenkins_home
USER jenkins

# el ejecutable agent.jar que da a este contenedor las capacidades de Jenkins
COPY agent.jar ./agent.jar
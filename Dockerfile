FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN curl -L https://github.com/snyk/cli/releases/download/v1.1130.0/snyk-alpine -o snyk-linux
RUN curl -L https://github.com/snyk/snyk-to-html/releases/download/v2.3.6/snyk-to-html-alpine -o snyk-to-html-linux
RUN chmod +x ./snyk-linux ./snyk-to-html-linux
RUN mv ./snyk-linux ./snyk-to-html-linux /usr/local/bin/
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.27.1 docker-workflow:563.vd5d2e5c4007f"

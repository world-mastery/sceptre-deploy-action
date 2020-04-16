FROM ubuntu:18.04

LABEL version="0.0.1"

LABEL com.github.actions.name="Sceptre Deploy Action"
LABEL com.github.actions.description="Deploy AWS CloudFormation Stacks using Sceptre"
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="orange"

LABEL repository="https://github.com/world-mastery/sceptre-deploy-action"
LABEL homepage="https://github.com/world-mastery/sceptre-deploy-action"
LABEL maintainer="Vicent Soria <vicentgodella@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV GITHUB_WORKSPACE=/github/workspace
RUN ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime

RUN apt-get update && apt-get install -y awscli python-pip

RUN pip install sceptre

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sceptre"]

WORKDIR ${GITHUB_WORKSPACE}

RUN apt-get clean

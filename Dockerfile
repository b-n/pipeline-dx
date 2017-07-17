FROM atlassian/default-image:1.54

ENV SF_ANT_VERSION 40.0

ADD build-ant.sh /root/build-ant.sh
ADD build-dx.sh /root/build-dx.sh

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y jq

RUN /root/build-ant.sh $SF_ANT_VERSION
RUN /root/build-dx.sh

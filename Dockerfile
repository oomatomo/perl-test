FROM centos:centos6
MAINTAINER oomatomo ooma0301@gmail.com

# install package
RUN rpm -Uhv http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y tar bzip2 gcc make perl perl-ExtUtils-MakeMaker mysql-devel

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton

ENV APPROOT /app
RUN mkdir -p $APPROOT

# ディレクトリの移動
WORKDIR /app
COPY cpanfile $APPROOT/cpanfile
RUN carton install
COPY ./ $APPROOT

CMD ["carton", "exec", "--", "prove", "-r", "/app/"]

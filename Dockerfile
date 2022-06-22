# build for test
FROM centos:7

RUN yum -y update

ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin:/usr/local/go/bin

RUN mkdir -p /go && chmod -R 777 /go && \
    yum install -y centos-release-scl which && \
    yum groupinstall -y "Development Tools" && \
    yum install -y git gcc ca-certificates wget && yum clean all

RUN wget https://go.dev/dl/go1.17.11.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    go version

# 安装单测的一些工具
RUN ["cd", "/"]
RUN ["go", "install", "github.com/jstemmer/go-junit-report@latest"]
RUN ["go", "install", "github.com/boumenot/gocover-cobertura@latest"]

WORKDIR /go




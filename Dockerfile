FROM debian:testing-slim

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV WORK_DIR /usr/src/app
ENV RVM_INSTALLER https://get.rvm.io

MAINTAINER Liu Lantao <liulantao@gmail.com>
ENV REFRESHED_AT 2017-12-14

RUN apt-get update \
	&& apt-get install -q -y --no-install-recommends curl gpg ca-certificates procps nodejs build-essential \
	&& bash -c 'gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
	&& \curl -sSL ${RVM_INSTALLER} | bash -s stable --ruby --gems=bundler,nokogiri,rails,ffi \
	&& source /etc/profile.d/rvm.sh \
	&& rvm cleanup all' \
	&& apt-get -q -y remove build-essential && apt autoremove -q -y \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR $WORK_DIR

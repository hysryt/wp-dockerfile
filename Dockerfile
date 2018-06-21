FROM wordpress:4.9.6-php7.2-apache

RUN DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -q -y --no-install-recommends \
         wget \
         zlib1g-dev \
         libssl-dev \
    && rm -rf /var/lib/apt/lists/*

ENV RUBY_MAJOR 2.5
ENV RUBY_VERSION 2.5.1

RUN wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
    && mkdir -p /usr/src/ruby \
    && tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 \
    && rm ruby.tar.xz \
    && cd /usr/src/ruby \
    && ./configure --disable-install-doc --enable-shared \
    && make -j$(nproc)\
    && make install \
    && cd \
    && rm -r /usr/src/ruby \
    && gem install wordmove \
    && apt autoremove -y wget libssl-dev

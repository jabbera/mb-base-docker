# Mediabrowser base includes all dependencies to make rebuilding the main mediabrowser image faster
FROM debian:jessie
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Set locale to UTF-8
RUN apt-get update && apt-get install -qy --force-yes locales && apt-get clean
RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
# Install needed default locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen
# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Add keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 637D1286; \
    echo 'deb http://ppa.launchpad.net/apps-z/mediabrowser/ubuntu trusty main' > /etc/apt/sources.list.d/20mediabrowser.list

RUN apt-get update && \
    apt-get install -qy \
        mono-runtime libmediainfo0 libmono-corlib2.0-cil libmono-corlib4.5-cil libmono-microsoft-csharp4.0-cil \
        libmono-posix4.0-cil libmono-security4.0-cil libmono-sharpzip2.84-cil libmono-system-configuration4.0-cil \
        libmono-system-core4.0-cil libmono-system-data-linq4.0-cil libmono-system-data2.0-cil libmono-system-data4.0-cil \
        libmono-system-drawing4.0-cil libmono-system-runtime-serialization4.0-cil libmono-system-servicemodel4.0a-cil \
        libmono-system-transactions4.0-cil libmono-system-web4.0-cil libmono-system-windows-forms4.0-cil \
        libmono-system-xml-linq4.0-cil libmono-system-xml4.0-cil libmono-system2.0-cil libmono-system4.0-cil libsqlite3-0 \
        libwebp5 mono-devel libsqlite3-dev sqlite3 && \
    apt-get clean    

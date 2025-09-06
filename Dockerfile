FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools & Apache + Perl deps
RUN apt-get update && apt-get install -y \
    apache2 \
    wget curl unzip nano git \
    libapache2-mod-perl2 \
    libapache2-request-perl \
    libxml-libxml-perl \
    libxml-libxslt-perl \
    libdbi-perl \
    libdbd-mysql-perl \
    libterm-readline-gnu-perl \
    libunicode-string-perl \
    libtime-parsedate-perl \
    libdigest-md5-perl \
    libjson-perl \
    libio-string-perl \
    build-essential \
    cpanminus \
    && rm -rf /var/lib/apt/lists/*

# Install additional CPAN modules for plugins/Bazaar
RUN cpanm XML::LibXML XML::LibXSLT JSON DBI DBD::mysql \
    Text::Unidecode Time::ParseDate \
    CGI Session::CookieIO

# Download & extract EPrints
WORKDIR /opt
RUN wget -O eprints.zip https://github.com/eprints/eprints3.4/archive/refs/heads/master.zip \
    && unzip eprints.zip \
    && mv eprints3.4-master eprints3 \
    && rm eprints.zip

# Add eprints user
RUN useradd -m -d /opt/eprints3 -s /bin/bash eprints && \
    chown -R eprints:eprints /opt/eprints3

# Apache config
COPY config/apache-eprints.conf /etc/apache2/sites-available/eprints.conf

RUN a2enmod perl && a2ensite eprints.conf && a2dissite 000-default.conf

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

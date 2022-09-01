FROM php:8.0-fpm

COPY opcache.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get upgrade -y \
    && apt-get install sudo\
    && apt-get install apt-utils -y \
    && apt-get install git zip vim libzip-dev libgmp-dev libffi-dev libssl-dev -y \
    && docker-php-ext-install -j$(nproc) sockets zip gmp pcntl bcmath ffi \
    && docker-php-source delete \
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y

RUN docker-php-ext-install mysqli pdo pdo_mysql
# install timezone
RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo Europe/Moscow > /etc/timezone && \
            printf '[PHP]\ndate.timezone = "Europe/Moscow"\n' > /usr/local/etc/php/conf.d/tzone.ini


ARG WORKUSER=apache
ARG WORKUSER_HOME=/home/${WORKUSER}
ARG WORKUSER_UID=1000
ARG WORKDIR

# add user
RUN useradd -U -m -s /bin/bash -d ${WORKUSER_HOME} -b ${WORKDIR} -u ${WORKUSER_UID} ${WORKUSER}

# change default fpm user
RUN if [ -f /usr/local/etc/php-fpm.d/www.conf ]; then \
        sed -i s/'user = www-data'/"user = ${WORKUSER}"/g /usr/local/etc/php-fpm.d/www.conf; \
        sed -i s/'group = www-data'/"group = ${WORKUSER}"/g /usr/local/etc/php-fpm.d/www.conf; \
    fi

#pull project
ARG REPO_URL
ARG REPO_BRANCH
ARG REPO_USER
ARG REPO_PWD
ARG REPO_CACHEBUST=2

RUN apt-get update \
    && apt-get install -y git \
    && curl -s https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && mkdir ${WORKDIR}  \
    && chown ${WORKUSER}:${WORKUSER} ${WORKDIR} \
    && chmod 0700 ${WORKDIR} \
    && su - ${WORKUSER} -c "\
        git clone ${REPO_URL} --branch ${REPO_BRANCH} ${WORKDIR} \
        && cd ${WORKDIR}\
        && composer install\
        && cp .env.example .env"

COPY data.xml ${WORKDIR}/storage/app/car/data.xml
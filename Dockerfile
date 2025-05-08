FROM php:8.1

WORKDIR /app

RUN apt-get update && apt-get install -y \
  libzip-dev \
  zip \
  git \
  libpq-dev

# Install php extensions
RUN docker-php-ext-install pdo pdo_pgsql

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

COPY . /app

RUN composer install --ignore-platform-reqs

# Give execute permission to startup script
RUN chmod +x /app/docker-startup.sh

ENTRYPOINT [ "/app/docker-startup.sh" ]


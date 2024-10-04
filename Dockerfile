FROM wordpress:6.3-apache
EXPOSE 80
USER root
RUN curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz \
    && tar -zxvf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;').so /usr/local/lib/php/extensions/no-debug-non-zts-$(php -r 'echo PHP_MAJOR_VERSION."".PHP_MINOR_VERSION;')/ \
    && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-$(php -r 'echo PHP_MAJOR_VERSION."".PHP_MINOR_VERSION;')/ioncube_loader_lin_$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;').so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf ioncube.tar.gz ioncube

    RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
CMD ["apache2-foreground"]

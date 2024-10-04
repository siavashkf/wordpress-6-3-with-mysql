FROM wordpress:6.3-apache
EXPOSE 80
USER root

# نصب ionCube Loader
RUN curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz \
    && tar -zxvf ioncube.tar.gz \
    && mv ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ \
    && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4.so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf ioncube.tar.gz ioncube

# فعال کردن mod_rewrite در Apache
RUN a2enmod rewrite

# تغییر دسترسی‌ها به دایرکتوری وردپرس
RUN chown -R www-data:www-data /var/www/html

# اجرای Apache
CMD ["apache2-foreground"]

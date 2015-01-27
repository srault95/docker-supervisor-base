FROM srault95/docker-python-base:dev

MAINTAINER <stephane.rault@radicalspam.org>

ENV SP_HTTP true
ENV SP_HTTP_SERVER 0.0.0.0:9001
ENV SP_HTTP_USERNAME supervisor
ENV SP_HTTP_PASSWORD docker

RUN pip install https://github.com/Supervisor/supervisor/tarball/master
RUN pip install envtpl

RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor /etc/setup.d

ADD supervisord.conf.tpl /etc/supervisor/
ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

RUN echo "alias ctl='/usr/local/bin/supervisorctl -c /etc/supervisor/supervisord.conf'" >> /root/.bashrc

EXPOSE 9001

VOLUME ["/etc/supervisor/conf.d"]

WORKDIR /etc/supervisor/conf.d

CMD ["/usr/local/bin/start.sh"]


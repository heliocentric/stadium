FROM ruby:2.1
COPY . /usr/src/app
RUN cd /usr/src/app && bundle install
CMD ["/usr/src/app/entrypoint.sh"]

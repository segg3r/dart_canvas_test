FROM google/dart
MAINTAINER segg3r <segg3r@gmail.com>

ADD pubspec.yaml /container/pubspec.yaml
ADD bin /container/bin
ADD web /container/web

WORKDIR /container
RUN pub get
RUN pub build

EXPOSE 8080

WORKDIR /container/bin
ENTRYPOINT ["dart"]

CMD ["httpserver.dart"]
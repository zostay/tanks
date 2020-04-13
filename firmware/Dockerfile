FROM zostay/rakudo:latest AS build-container

ADD . /build
WORKDIR /build

RUN zef install --force-test .

FROM zostay/rakudo:latest AS run-container

COPY --from=build-container /usr/share/raku/site /usr/share/raku/site

CMD ["/usr/share/raku/site/bin/tank-firmware"]

FROM zostay/rakudo:latest AS build-container

ADD . /build
WORKDIR /build

RUN TEST_VERBOSE=1 zef install --force-test .

FROM zostay/rakudo:latest AS run-container

COPY --from=build-container /usr/local/share/perl6/site /usr/lcoal/share/perl6/site

CMD ["/usr/local/share/raku/site/bin/tank-firmware"]

FROM ubuntu

RUN apt-get update \
    && apt-get install --yes build-essential git libssl-dev curl \
    && mkdir /rakudo 

WORKDIR /rakudo

RUN curl -LJO https://rakudo.org/latest/star/source \
    && tar -xzf rakudo-star-*.tar.gz \
    && mv rakudo-star-*/* . \
    && rm -fr rakudo-star-* 

RUN perl Configure.pl --backend=moar --gen-moar
RUN make 
RUN make install

ENV PATH="/rakudo/install/bin:/rakudo/install/sahre/perl6/site/bin:${PATH}"

ENTRYPOINT [ 'perl6' ]

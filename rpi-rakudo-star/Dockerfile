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

# echo "export PATH=$(pwd)/install/bin/:$(pwd)/install/share/perl6/site/bin:\$PATH" >> ~/.bashrc
# source ~/.bashrc

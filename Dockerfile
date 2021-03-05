FROM ubuntu AS build

RUN apt-get update
RUN apt-get install -y libssl-dev build-essential
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git gcc cmake

RUN mkdir -p /code
WORKDIR /code
RUN git clone https://github.com/Fantastic-Dave/xdccget.git
WORKDIR /code/xdccget
RUN mkdir -p build
WORKDIR /code/xdccget/build
RUN cmake ..
RUN make


FROM ubuntu

RUN apt-get update
RUN apt-get install -y openssl

COPY --from=build /code/xdccget/build/xdccget /usr/bin/xdccget
RUN chmod +x /usr/bin/xdccget
ENTRYPOINT [ "/usr/bin/xdccget" ]


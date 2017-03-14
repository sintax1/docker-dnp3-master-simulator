# https://www.automatak.com/opendnp3/docs/guide/current/build/cmake/
#
# Start with ubuntu as base
FROM ubuntu:latest

# Update ubuntu and install dependencies
RUN apt-get update && \
    apt-get install -y git build-essential cmake findutils libasio-dev

# Pull the dnp3 source
RUN cd /usr/local/src && \
    git clone --recursive https://github.com/sintax1/dnp3.git

# Compile the dnp3 source
RUN cd /usr/local/src/dnp3 && \
    cmake -DDNP3_DEMO=true . && \
    make

# Copy the binary to /usr/local/bin
RUN cd /usr/local/src/dnp3 && \
    cp outstation-demo /usr/local/bin

# Open DNP3 port
EXPOSE 20000

# User docker compose to link this master and an outstation
# called 'outstation1'. Then, an entry will exist in /etc/host
# to resolve outstation1's IP, which is passed in as an argument here.
ENTRYPOINT /usr/local/bin/master-demo outstation1

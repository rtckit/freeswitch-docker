FROM debian:buster-slim

# Add prerequisites
RUN apt-get update && \
  apt-get install -y gnupg2 wget lsb-release && \
  wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - && \
  echo "deb http://files.freeswitch.org/repo/deb/debian-release/ buster main" > /etc/apt/sources.list.d/freeswitch.list && \
  apt-get update

# Configure apt release
ENV APT_RELEASE=1.10.4~release~16~133fc2c870~buster-1~buster+1

# Install FreeSWITCH's core
RUN apt-get install -y freeswitch=${APT_RELEASE}

# Default command
CMD ["/usr/bin/freeswitch", "-c", "-nonat"]

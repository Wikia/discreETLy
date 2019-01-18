FROM python:3.7.1-stretch

WORKDIR /tmp/dashboard/

RUN echo "deb http://ftp.debian.org/debian stretch-backports main libs contrib non-free" > /etc/apt/sources.list.d/backports.list
RUN apt update && apt upgrade -y
RUN apt-get -t stretch-backports -y install libsqlite3-0
RUN pip install pytest

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

CMD ["pytest"]

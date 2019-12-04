FROM python:3.7.1-stretch

WORKDIR /app

RUN echo "deb http://ftp.debian.org/debian stretch-backports main libs contrib non-free" > /etc/apt/sources.list.d/backports.list
RUN apt update && apt upgrade -y
RUN apt-get -t stretch-backports -y install libsqlite3-0
RUN pip install pytest 'moto==1.3.9'

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

RUN mkdir /var/run/discreetly

ENV AWS_ACCESS_KEY_ID=dummy
ENV AWS_SECRET_ACCESS_KEY=dummy

CMD ["pytest", "--disable-pytest-warnings"]

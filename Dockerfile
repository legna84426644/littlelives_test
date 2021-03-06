FROM ubuntu:16.04

LABEL name="Docker build for acceptance testing using the robot framework"

RUN apt-get update \
	&& apt-get install -y build-essential libssl-dev libffi-dev python-dev \
		python-pip python-dev gcc phantomjs firefox \
		xvfb zip wget ca-certificates ntpdate \
		libnss3-dev libxss1 libappindicator3-1 libindicator7 gconf-service libgconf-2-4 libpango1.0-0 xdg-utils fonts-liberation \
	&& rm -rf /var/lib/apt/lists/*
#COPY requirements.txt .
#RUN mkdir -p ./littlelives/

#COPY . ./littlelives/
COPY . ./

RUN chmod 755 ./run_all_test.sh

RUN pip install --upgrade pip

RUN pip install -r ./requirements.txt

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz \
	&& tar xvzf geckodriver-*.tar.gz \
	&& rm geckodriver-*.tar.gz \
	&& mv geckodriver /usr/local/bin \
	&& chmod a+x /usr/local/bin/geckodriver

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
	&& dpkg -i google-chrome*.deb \
	&& rm google-chrome*.deb

#RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_74.0.3729.157-1_amd64.deb \
#	&& dpkg -i google-chrome-stable_74.0.3729.157-1_amd64.deb \
#	&& rm google-chrome*.deb

RUN wget https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip \
	&& unzip chromedriver_linux64.zip \
	&& rm chromedriver_linux64.zip \
	&& mv chromedriver /usr/local/bin \
	&& chmod +x /usr/local/bin/chromedriver

CMD ["./run_all_test.sh"]
FROM python:3.9
ENV TZ=America/New_York

ARG WG_USER
ARG WG_PASS
ARG WG_PORT=53255

RUN mkdir /code
WORKDIR /code

RUN apt-get update -y && \
    apt-get install -y gcc git && \
	git clone https://github.com/pysanders/waterguru-api && \
    pip install -r /code/waterguru-api/requirements.txt && \
	sed -i "s/WG_USER/${WG_USER}/" /code/waterguru-api/waterguru_flask.py && \
	sed -i "s/WG_PASS/${WG_PASS}/" /code/waterguru-api/waterguru_flask.py && \
	sed -i "s/WG_PORT/${WG_PORT}/" /code/waterguru-api/waterguru_flask.py && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#ADD . /code/
EXPOSE ${WG_PORT}
CMD [ "python3.9", "/code/waterguru-api/waterguru_flask.py" ]

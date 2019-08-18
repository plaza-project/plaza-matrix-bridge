FROM python:3-alpine

# Note that everything is uninstalled later.
ADD requirements.txt /requirements.txt
RUN apk add --no-cache gcc libressl-dev musl-dev libffi-dev && \
  pip install -U -r /requirements.txt && \
  apk del            gcc libressl-dev musl-dev libffi-dev

ADD . /app
RUN pip install -e /app

# Bridge database (registrations, chatrooms, ...)
VOLUME /root/.local/share/plaza/bridges/matrix/db.sqlite

CMD plaza-matrix-service

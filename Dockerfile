FROM alpine:3.5
RUN apk add --update python py-pip
COPY requirements.txt /src/requirements.txt
RUN echo "${foo}" > /tmp/hurrah
# RUN pip install -r /src/requirements.txt
COPY webapp.py /src/webapp.py
COPY buzz /src/buzz
CMD python /src/webapp.py

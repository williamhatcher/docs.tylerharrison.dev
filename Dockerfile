FROM python:3.9-alpine
WORKDIR /app
COPY docs/ /app/docs
COPY mkdocs.yml /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
RUN apk add cairo-dev
CMD ["mkdocs", "build", "--clean"]
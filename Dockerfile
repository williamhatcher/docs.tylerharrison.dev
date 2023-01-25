FROM python:3.9-alpine
RUN pip install mkdocs mkdocs-material
COPY . /app
WORKDIR /app
CMD ["mkdocs", "build", "--clean"]
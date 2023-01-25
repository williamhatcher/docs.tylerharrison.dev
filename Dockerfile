FROM python:3.9-alpine
RUN pip install mkdocs mkdocs-material
WORKDIR /app
COPY docs/ /app/docs
COPY mkdocs.yml /app
CMD ["mkdocs", "build", "--clean"]
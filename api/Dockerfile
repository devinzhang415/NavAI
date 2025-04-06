FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Cloud Run will set this environment variable
ENV PORT 8080
EXPOSE 8080
# Important: this makes the container listen on the specified PORT
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 server:app 
FROM python:3.8-slim
# copy the requirements file into the image
COPY ./app/requirments.txt /app/requirments.txt

# switch working directory
WORKDIR /app

RUN apt-get update && \
    apt-get install -y git
# install the dependencies and packages in the requirements file
RUN pip install -r requirments.txt

# copy every content from the local file to the image
COPY ./app /app

# Install nginx
RUN apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Install ffmpeg
RUN apt install ffmpeg

# Copy Nginx config into the container
COPY ./nginx/default /etc/nginx/sites-enabled/

COPY cipher.py /usr/local/lib/python3.9/dist-packages/pytube
# Expose ports
EXPOSE 80

# Start Nginx and the Flask app
CMD service nginx start && python app.py
# Stage 1: Node.js Scraper
FROM node:18-slim as scraper-build
MAINTAINER vinitkulkarni39@gmail.com

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
WORKDIR /app

# Install Chromium and dependencies
RUN apt-get update && apt-get install -y \
  chromium \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Generate scraped_data.json file
COPY package.json ./
RUN npm install
COPY .env ./
COPY scrape.js ./
RUN node scrape.js

# Stage 2: Python Flask server
FROM python:3.10-slim

WORKDIR /app
COPY --from=scraper-build /app/scraped_data.json ./
COPY server.py requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "server.py"]

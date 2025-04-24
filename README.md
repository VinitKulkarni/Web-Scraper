# Web-Scraper
Building a multi-stage Docker container with A Node.js + Puppeteer scraper and Python + Flask web server to serve the scraped content

### Step-1: Clone the project
```sh
git clone https://github.com/VinitKulkarni/Web-Scraper.git
```

### Step-2: Add the URL in .env File
```sh
vi .env
SCRAPE_URL="your_url.com"
```

### Step-3: Build the Docker Image
```sh
docker build -t <user_name>/<image_name>:<version> .
docker build -t vinitkulkarni/web-scraper:1.0 .
```

### Step-4: Run the Docker Image
```sh
docker run -d -p <port>:<port> <user_name>/<image_name>:<version> 
docker run -d -p 5000:5000 vinitkulkarni/web-scraper:1.0
```

### Step-5: Access The data usign python web application
```sh
http://localhost:5000
or
http://<publicIP>:5000
```

### To generate new scraped content for the new URL
```sh
vi .env
SCRAPE_URL="your_new_url.com"
use docker build(Step-3) and docker run(Step-4) as mentioned above
```

# Project templates

In most cases, you do not need this. But for some projects it is quite useful.

You make a docker-compose.yml, but instead of loading an image, you build your own.

## Build development

With build-development you can build smaller websites without having to create a new Docker project each time.
Of course it is also sent, if you just want to test something for a short time.

Copy the folder build-development into your project folder and change this in your docker-compose.yml file:

```yaml
services:
  web:
    build: build-development
    #image: pluswerk/php-dev:nginx-7.2 (or simply remove this line)
    environment:
      - VIRTUAL_HOST=~^(.+\.)?development\.(vm|vmd)$$
      - WEB_DOCUMENT_ROOT=/app
```

Build with docker-compose and start the container:

```bash
docker-compose build && docker-compose up -d
```

Now you have little magic in the script.
For example, you now have this folder structure:

```bash
# test1.development.vm
./test1/index.php

# test2.development.vm/script.php
./test2/public/script.php

# development.vm/test.php
./test.php
```

If you go to development.vm you will get a small file list.

If you create a folder, a domain is automatically reachable: test1.development.vm

If there is a subfolder "public" in the created folder, then the created domain will be accessible from there: test2.development.vm

In this sense, happy coding!

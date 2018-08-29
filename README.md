# PHP Zotero WebDAV Docker container

## To build

docker build --no-cache --build-arg MY_ZOTERO_API_KEY=test --build-arg MY_ZOTERO_USER_ID=userid --build-arg MY_ZOTERO_USER_NAME=username --build-arg MY_ZOTERO_CACHE_BASE_URL=baseurl -t tabashir/zotero_webdav .

## To run

docker-compose -d run

This will create a folder one up from the current folder called 'data' where the zotero data will be stored

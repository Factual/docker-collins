# docker-collins


```
docker run -dit --name collins -p 9000:9000 \
-e COLLINS_DB_LOGIN=mysql_user \
-e COLLINS_DB_PASSWORD=mysql_password \
-e COLLINS_DB_URL=mysql_host \
factual/docker-collins
```

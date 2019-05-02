# See https://www.elastic.co/blog/elasticsearch-docker-plugin-management
# and https://github.com/docker-library/elasticsearch/issues/32#issuecomment-278212815

FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.15

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-s3

RUN /usr/share/elasticsearch/bin/elasticsearch-keystore create

RUN echo $AWS_ACCESS_KEY_ID | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo $AWS_SECRET_ACCESS_KEY | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key

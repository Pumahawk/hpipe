FROM alpine:3.20

RUN apk add --no-cache --allow-untrusted --no-check-certificate \
	kubectl \
	helm \
	jq \
	yq \
	bash \
	curl

WORKDIR /app

COPY hpipe /app/hpipe

CMD /app/hpipe

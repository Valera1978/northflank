FROM nginx:mainline-alpine-slim
EXPOSE 80
WORKDIR /app
USER root

ENV UUID='de04add9-5c68-8bab-950c-08cd5320df18'
ENV VLESS_WSPATH='/vless'
ENV SS_WSPATH='/shadowsocks'

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apk update && apk add --no-cache supervisor wget unzip curl && \
	wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip temp.zip xray && \
    rm -f temp.zip && \
    chmod -v 755 xray entrypoint.sh \
    apk del wget unzip && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "./entrypoint.sh" ]
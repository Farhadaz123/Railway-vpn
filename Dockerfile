FROM alpine:3.19

RUN apk add --no-cache \
    v2ray \
    python3 \
    ca-certificates \
    tzdata \
    curl \
    openssl

ENV TZ=Asia/Tehran

RUN mkdir -p /etc/v2ray /var/log/v2ray

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

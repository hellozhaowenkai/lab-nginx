FROM nginx

ENV TZ=Asia/Shanghai

WORKDIR /app

COPY . .

EXPOSE 8888
EXPOSE 10000:10100

ENTRYPOINT ["nginx", "-g", "daemon off;"]

CMD ["-p", "/app", "-c", "/app/config/nginx.conf"]

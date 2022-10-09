# syntax=docker/dockerfile:1

# build stage
FROM nginx:stable

# set timezone
ENV TZ=Asia/Shanghai

# make the `app` folder the current working directory
WORKDIR /app/

# copy project files and folders to the current working directory (i.e. `app` folder)
COPY . .

# the container listens on the specified network ports at runtime
EXPOSE 80
EXPOSE 443
EXPOSE 8888

# run NGINX server in foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# run NGINX server in `/app` prefix path
CMD ["-p", "/app/", "-c", "/app/config/nginx.conf"]

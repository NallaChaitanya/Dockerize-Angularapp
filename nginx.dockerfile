#### Stage 1

FROM node:latest as node

LABEL author="Chaitanya Nalla"

WORKDIR '/builddir'

COPY package.json  package.json 

RUN npm install

COPY . ./

RUN npm run build -- --prod



##########################################

#####Stage 2

FROM nginx:1.18-alpine

VOLUME /var/nginx/cache

RUN rm /etc/nginx/conf.d/default.conf
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY  --from=node /builddir/dist/testapp /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



##docker build -t nginx-angular -f nginx.dockerfile .

##docker run -p 8080:80 nginx-angular 
FROM node:20-alpine as build
RUN mkdir -p /srv/app
RUN mkdir -p /srv/app/lists
RUN mkdir -p /srv/app/css
RUN npm cache clear --force
WORKDIR /srv/app
COPY package.json /srv/app
RUN npm install
COPY lists/ /srv/app/lists
COPY css/ /srv/app/css
COPY index.html /srv/app
COPY index.js /srv/app
COPY favicon.ico /srv/app

FROM nginx
COPY --from=build /srv/app /usr/share/nginx/html

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]

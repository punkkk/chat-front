FROM node:alpine as build-stage

RUN mkdir /front
COPY . /front/
WORKDIR /front


RUN yarn install
RUN yarn global add parcel
RUN yarn run build

FROM nginx:alpine as production-stage

COPY default.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /front/dist/ /etc/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
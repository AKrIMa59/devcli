FROM nginx:1.21.6

ARG PROJET_NAME

#Copy du vhost
COPY $PROJET_NAME-vhost.conf /etc/nginx/vhost.conf.template

#Copy de la conf nginx dans un emplacement temporaire sur le docker
COPY nginx.conf /etc/nginx/nginx.conf.template
COPY entrypoint.sh /entrypoint.sh

WORKDIR /$PROJET_NAME

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["nginx", "-g", "daemon off;"]
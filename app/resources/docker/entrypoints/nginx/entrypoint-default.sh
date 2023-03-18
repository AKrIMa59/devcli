
echo "Ajout de l'utilisateur non root"
groupadd -f -g ${GROUP_ID} "${USER_NAME}"
useradd -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} "${USER_NAME}"

echo "Transformation variable d'environnement en texte"
envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && rm /etc/nginx/nginx.conf.template
envsubst '${PROJET_NAME}' < /etc/nginx/vhost.conf.template > /etc/nginx/conf.d/default.conf && rm /etc/nginx/vhost.conf.template

echo "Ajout de l'utilisateur non root"
groupadd -f -g ${GROUP_ID} "${USER_NAME}"
useradd -s /bin/bash -u ${USER_ID} -g ${GROUP_ID} "${USER_NAME}"

echo "projetname : ${PROJET_NAME}"
mkdir /${PROJET_NAME}
chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}
chown -R ${USER_NAME}:${USER_NAME} /${PROJET_NAME}

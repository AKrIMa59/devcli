#!/bin/bash
source "app/resources/color.sh"
source "app/resources/testing.sh"
source "app/resources/operation.sh"
source "app/resources/tools.sh"

readonly BIN_DIRECTORY="/usr/local/bin"
readonly RESSOURCES_DIRECTORY="/lib/devcli"
readonly CONFIG_DIRECTORY="/etc/devcli"

readonly DEPENDENCY_DOCKER="dependency/docker-list"
readonly DEPENDENCY_LIB="dependency/lib-list"

#retire les sorties erreurs des commandes
#exec 2>/dev/null

function isInstalledPackage () {
    local packageName
    packageName=$1

    local packageExist
    packageExist=$(dpkg-query -W "$packageName" | awk '{print $1}')

    if [[ "$packageExist" == "$packageName" ]]; then
        cecho green "Package $packageName déjà installé."
    else
        cecho green "Installation du package $packageName"
        apt -qq update
        apt install -y $packageName 
    fi
}

function installDocker()
{
    local packageExist
    packageExist=$(dpkg-query -W "docker-ce" | awk '{print $1}')

    if [[ "$packageExist" == "docker-ce" ]]; then
        cecho green "Docker est déjà installé sur ce serveur"
    else
        cecho green "Ajout du repository Docker"
        #Add repository docker
        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        cecho green "Installation du package $packageName"
        #Installation des packages docker
        for line in $(cat $DEPENDENCY_DOCKER)
        do
        isInstalledPackage $line
        done
    fi
}

function installDockerCompose()
{
    if [ ! -f "/usr/local/bin/docker-compose" ]; then
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    else
        cecho green "Docker compose est déjà installé sur ce serveur"
    fi
}

function installDependance()
{
    for line in $(cat $DEPENDENCY_LIB)
    do
        isInstalledPackage $line
    done
}

verifyIfRoot

cecho green-bold "-----------------------------------------"
cecho yellow-bold "  Reinstallation DEV-CLI  "
cecho green-bold "-----------------------------------------"

cecho red "  Suppresion des anciens fichiers (sauf dossier config) "
deleteDirectory $RESSOURCES_DIRECTORY
deleteFile $BIN_DIRECTORY/devcli

cecho cyan "  Création des répertoires  "
createDirectory $BIN_DIRECTORY
createDirectory $RESSOURCES_DIRECTORY
createDirectory $CONFIG_DIRECTORY

cecho cyan "  Copie des sources  "
copyFile app/bin/devcli $BIN_DIRECTORY
copyContentDirectory app/resources $RESSOURCES_DIRECTORY
copyContentDirectory app/config $CONFIG_DIRECTORY

cecho cyan "  Vérification des dépendances  "
installDependance

cecho cyan "  Vérification de docker  "
installDocker

cecho cyan "  Vérification de docker-compose  "
installDockerCompose

cecho cyan-bold "Retrouver l'ensembles des fonctionnalités avec la commande dev-cli help"
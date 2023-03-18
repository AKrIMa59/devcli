#!/bin/bash

source color.sh 2>/dev/null
source testing.sh 2>/dev/null

readonly MSG_DIRECTORY_NO_CREATE="Le répertoire ne peut pas être créé, veuillez vérifier les ACLs. Emplacement du répertoire :"
readonly MSG_DIRECTORY_CREATE="Creation du repertoire effectué. Emplacement du répertoire :"
readonly MSG_DIRECTORY_EXIST="Le repertoire existe déjà. Emplacement du répertoire :"

readonly MSG_FILE_NO_COPY="Le fichier n'a pas pu être copié, veuillez vérifier les ACLs. Emplacement du fichier :"
readonly MSG_FILE_COPY="Le fichier a été copié. Emplacement du fichier :"

readonly MSG_FILES_NO_COPY="Les fichiers n'ont pas pu être copié, veuillez vérifier les ACLs. Emplacement du fichier :"
readonly MSG_FILES_COPY="Les fichiers ont été copié. Emplacement du fichier :"

readonly MSG_DIRECTORY_DELETE="Le répertoire a été correctement supprimé. Emplacement du répertoire :"
readonly MSG_DIRECTORY_NO_DELETE="Le répertoire n'a pas pu être supprimé. Emplacement du répertoire :"

readonly MSG_FILE_DELETE="Le répertoire a été correctement supprimé. Emplacement du répertoire :"
readonly MSG_FILE_NO_DELETE="Le répertoire n'a pas pu être supprimé. Emplacement du répertoire :"

function createDirectory () {
    local directory_name
    directory_name=$1
    if [ ! -d $directory_name ]; then
        mkdir $directory_name || { cecho red-bold "$MSG_DIRECTORY_NO_CREATE $directory_name"; exit 1; } 
        cecho green-bold "$MSG_DIRECTORY_CREATE $directory_name"
    else
        cecho green-bold "$MSG_DIRECTORY_EXIST $directory_name"
    fi
}

function copyFile () {
    local source
    source=$1
    local dest
    dest=$2
    cp -f $source $dest || { cecho red-bold "$MSG_FILE_NO_COPY $dest"; exit 1; } 
    cecho green-bold "$MSG_FILE_COPY $dest"
}

function copyContentDirectory () {
    local source
    source=$1
    local dest
    dest=$2
    cp -rf $source/* $dest/. || { cecho red-bold "$MSG_FILES_NO_COPY $dest"; exit 1; } 
    cecho green-bold "$MSG_FILES_COPY $dest"
}


function copyDirectory () {
    echo "$1" # arguments are accessible through $1, $2,...
}

function moveFile () {
    echo "$1" # arguments are accessible through $1, $2,...
}

function moveDirectory () {
    echo "$1" # arguments are accessible through $1, $2,...
}

function deleteDirectory () {
    local directory
    directory=$1
    rm -rf $1 || { cecho red-bold "$MSG_DIRECTORY_NO_DELETE $directory"; exit 1; }
    cecho red "$MSG_DIRECTORY_DELETE $directory"
}

function deleteFile () {
    local file
    file=$1
    rm -f $1 || { cecho red-bold "$MSG_FILE_NO_DELETE $file"; exit 1; }
    cecho red "$MSG_FILE_DELETE $file"
}


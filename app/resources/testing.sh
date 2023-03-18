#!/bin/bash

source color.sh 2>/dev/null

readonly MSG_DIRECTORY_NO_EXIST="Le répertoire n'existe pas, veuillez vérifier les ACLs. Emplacement du répertoire :"
readonly MSG_FILE_NO_EXIST="Le fichier n'existe pas, veuillez vérifier les ACLs. Emplacement du fichier :"

function fileExist () {
    if [ ! -f $1 ]; then
        cecho red-bold "$MSG_FILE_NO_EXIST $1"
        exit 0
    fi
}

function directoryExist () {
    if [ ! -d $1 ]; then
        cecho red-bold "$MSG_DIRECTORY_NO_EXIST $1"
        exit 0
    fi
}




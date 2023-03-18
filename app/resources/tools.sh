#!/bin/bash

source color.sh 2>/dev/null

readonly MSG_ERROR_NO_ROOT="Vous devez être connecté en tant que root pour effectuer l'action ! "
readonly MSG_ERROR_ROOT="Vous devez être connecté en tant qu'utilisateur standard pour effectuer l'action ! "

function verifyIfRoot () {
    if [[ "$(whoami)" == *"root"* ]]; then
        cecho cyan "Connecté en tant que root"
    else
        cecho red-bold "$MSG_ERROR_NO_ROOT"
        exit 0
    fi
}

function verifyIfNoRoot () {
    if [[ "$(whoami)" != *"root"* ]]; then
        cecho cyan "Connecté en tant qu'utilisateur non root"
    else
        cecho red-bold "$MSG_ERROR_ROOT"
        exit 0
    fi
}

function DirectoryInPath () {
    local path
    path=$1
    cd $1
    for f in *; do
        if [[ "$f" == *"*"* ]]; then
            cecho gray "Null"
        else
            cecho gray "- $f"
        fi
    done
    cd - >/dev/null
}

function devcliVerifyEnv () {
    local installName
    local env_path
    local line
    env_path=$1
    installName=$2
    for l in $(cat $env_path );do
        line=$(echo $l | awk -F";" '{print $1}')
        if [[ "$line" == "$installName" ]] 
        then
            line=$(grep -n "$installName" $env_path | awk -F: '{print $1}')
            sed -i $line"d" $env_path
        fi
    done
}

function devcliListInstall () {
    local env_path
    env_path=$1
    local installName
    local projetName
    local installPath
    for l in $(cat $env_path );do
        installName="$(echo $l | awk -F";" '{print $1}')"
        projetName="$(echo $l | awk -F";" '{print $2}')"
        installPath="$(echo $l | awk -F";" '{print $3}')"
        cecho gray-bold "# $installName #"
        cecho gray "  > Projet : $projetName"
        cecho gray "  > Path : $installPath"
    done
}
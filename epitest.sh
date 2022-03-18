#!/bin/bash

#autor Nathan Chiodin <nathan.chiodin@epitech.eu>
#docker image author epitechcontent/epitest-docker

if [[ $# -eq 0 ]]
then
    docker run --name test-epitech --env-file=test.env -v "$(pwd)/test-src:/home/test" --workdir=/home/test --rm -it epitechcontent/epitest-docker
    exit
fi

if [[ $# -eq 1 ]] && [ -d "$1" ]
then
    cp -r $1 $(pwd)/test-src
    docker run --name test-epitech --env-file=test.env -v "$(pwd)/test-src:/home/test" --workdir=/home/test --rm -it epitechcontent/epitest-docker
    exit
fi

if ([[ $# -eq 1 ]] && [[ $1 = "-h" ]]) || ([[ $# -eq 1 ]] && [[ $1 = "-h" ]])
then
    echo "USAGE:"
    echo
    echo "to start \"Mouli\" environment in docker copy your project into \"test-src\" folder"
    echo
    echo "./epitest.sh"
    echo
    echo "if you need sudo to use docker you can do:"
    echo
    echo "./epitest.sh -sudo"
    echo
    echo "or you can specify which folder copy and run test"
    echo
    echo "./epitest.sh <link to folder>"
    echo "./epitest.sh -sudo <link to folder>"
    echo
    echo "USAGE INSTALL:"
    echo
    echo "./epitest.sh -install"
    echo
    echo "to install docker in your system if you don't have it"
    echo
    echo "USAGE FLUSH:"
    echo
    echo "./epitest.sh -flush"
    echo
    echo "to flush test-src folder"
    exit
fi

if [[ $# -eq 1 ]] && [[ $1 = "-sudo" ]]
then
    sudo docker run --name test-epitech --env-file=test.env -v "$(pwd)/test-src:/home/test" --workdir=/home/test --rm -it epitechcontent/epitest-docker
    exit
fi

if [[ $# -eq 2 ]] && [[ $1 = "-sudo" ]] && [ -d "$2" ]
then
    cp -r $2 $(pwd)/test-src
    sudo docker run --name test-epitech --env-file=test.env -v "$(pwd)/test-src:/home/test" --workdir=/home/test --rm -it epitechcontent/epitest-docker
    exit
fi

if [[ $# -eq 1 ]] && [[ $1 = "-flush" ]]
then
    rm -Rf ./test-src/*
    exit
fi

if [[ $# -eq 1 ]] && [[ $1 = "-install" ]]
then
    echo "USAGE install:"
    echo
    echo "./epitest.sh -install <distribution>"
    echo
    echo "AVAILABLE DISTRIBUTION:"
    echo "fedora (dnf)"
    echo "debian (apt)"
    echo "ubuntu (apt)"
    echo
    echo "EXEMPLE:"
    echo
    echo "./epitest.sh -install fedora"
    exit
fi

if [[ $# -eq 2 ]] && [[ $1 = "-install" ]] && ([[ $2 = "fedora" ]] || [[ $2 = "debian" ]] || [[ $2 = "ubuntu" ]])
then
    if [[ $2 = "fedora" ]]
    then
        sudo dnf install docker-ce docker-ce-cli containerd.io
    fi
    if [[ $2 = "debian" ]]
    then
        sudo apt-get update && sudo apt-get upgrade && sudo apt-get install docker-ce docker-ce-cli containerd.io
    fi
    if [[ $2 = "ubuntu" ]]
    then
        sudo apt-get update && sudo apt-get upgrade && sudo apt-get install docker-ce docker-ce-cli containerd.io
    fi
elif [[ $# -eq 2 ]] && [[ $1 = "-install" ]]
then
    echo "ERROR: invalid distribution"
    exit
fi

echo "ERROR: arguments invalid !!"
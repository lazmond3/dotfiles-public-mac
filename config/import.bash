. ${CONFIG_DIR%/}/declare.bash
load ${CONFIG_DIR%/}/languages
load ${CONFIG_DIR%/}/git
load ${CONFIG_DIR%/}/fzf
load ${CONFIG_DIR%/}/docker
load ${CONFIG_DIR%/}/line
load ${CONFIG_DIR%/}/functions
load ${CONFIG_DIR%/}/k8s
load ${CONFIG_DIR%/}/elasticsearch
load ${CONFIG_DIR%/}/alias
load ${CONFIG_DIR%/}/common-cd
load ${CONFIG_DIR%/}/altcd
# load ${CONFIG_DIR%/}/cd
load ${CONFIG_DIR%/}/tty 
# load ${CONFIG_DIR%/}/test
# load ${CONFIG_DIR%/}/complete

if  [[ -t 1 ]]; then
    load ${CONFIG_DIR%/}/sensible
fi


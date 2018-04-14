# Start ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

### Aliases

# Python
alias py=python
alias py3=python3

# Google cloud 
alias gc='gcloud compute'
alias gc-setm='gcloud compute instances set-machine-type'
alias gc-s='gcloud compute instances start'
alias gc-ssh='gcloud compute ssh'
alias gc-l='gcloud compute instances list'
alias gc-stop='gcloud compute instances stop'
alias gc-scp='gcloud compute scp'
alias gc-setp='gcloud config set project'
alias gc-actc='gcloud config configurations activate'

# Function for setting machine type and starting
gc-3s() {
    gcloud compute instances set-machine-type $1 --machine-type=$2
    gcloud compute instances start $1
    sleep 6
    gcloud compute ssh $1
}
# Function for just starting and sshing
gc-2s() {
    gcloud compute instances start $1
    sleep 6
    gcloud compute ssh $1
}

# Misc bash aliases
alias ll='ls -lah'
alias histg='history | grep'
alias hist='history'

# Path stuff
alias rp='realpath'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# Source .bashrc
if [ -f ~/.bashrc ]; then 
    source ~/.bashrc 
fi

### SSH
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

### Basic Aliases
# Python
alias py=python
alias py3=python3

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

### Google cloud 
# Aliases
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

### AWS
# Aliases
alias ec='aws ec2'
alias ec-s='aws ec2 start-instances --instance-ids'
alias ec-stop='aws ec2 stop-instances --instance-ids'
alias ec-reboot='aws ec2 reboot-instances --instance-ids'
alias ec-d='aws ec2 describe-instances --filters "Name=tag:Owner, Values=ksolvik"'
alias s3-cp='aws s3 cp'
alias s3-ls='aws s3 ls'
alias s3-rm='aws s3 rm'
alias s3-mv='aws s3 mv'
alias s3-sync='aws s3 sync'
    
# Function for connecting to AWS instance
ec-ssh() {
    dns=$(aws ec2 describe-instances --instance-ids $1 --query  'Reservations[0].Instances[0].PublicDnsName')
    dns=$(echo $dns | tr -d '"')
    ssh ubuntu@${dns}
}

# Function for connecting to AWS instance with non-default ssh key
ec-ssh-key() {
    dns=$(aws ec2 describe-instances --instance-ids $2 --query  'Reservations[0].Instances[0].PublicDnsName')
    dns=$(echo $dns | tr -d '"')
    ssh -i $1 ec2-user@${dns}
}

# Function to grab IP address
ec-ip() {
    ip=$(aws ec2 describe-instances --instance-ids $1 --query  'Reservations[0].Instances[0].PublicIpAddress')
    echo $ip | tr -d '"'
}

# Some env variables for instance IDs
aid_ci1=lookitupdontputthisongithub

### Initiate autojump
if [ -f /usr/share/autojump/autojump.sh ];then
    . /usr/share/autojump/autojump.sh
fi

### Initiate virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh

### Pureline
# source $HOME/.local/lib/pureline/pureline $HOME/.pureline.conf

### Source .bashrc
if [ -f ~/.bashrc ]; then 
    source ~/.bashrc 
fi

### Initiate autojump
if [ -f /usr/share/autojump/autojump.sh ];then
    . /usr/share/autojump/autojump.sh
fi
